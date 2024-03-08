cloc_03AE:	; entry point
	MOVR	i500, i353
	MOVR	i501, i354
cloc_03BA:
	TBOPEN	9, 1, 19, 9, 6, 1
	CMD2F	2, 12, 385, 12, 14, 0, 5, 305
	CHRDLY	i1000
	PRINT	9, cstr_0C03
	CHRDLY	i352
cloc_03E8:
	CMD3F	i321, i333
	CMD6A	32, 320, 143, 383
	MENUSEL	i112, i113, csel_0C3F, cloc_040C
cloc_0402:
	CMD43	i321, i333
	JP	cloc_0402

cloc_040C:
	JTBL	i113
	DW	cloc_07AA	; 0
	DW	cloc_0418	; 1
	DW	cloc_07AA	; 2
	DW	cloc_0418	; 3

cloc_0418:
	TBCLOSE	9
	TBCLOSE	12
	CMD1E	i0
	JP	mainloc_01A8

cloc_0428:	; entry point
	TBCLOSE	12
	PALFADE	1, 3
	CALL	cloc_04F4
	PALBW	1, 3
	JTBL	i353
	DW	cloc_0454	; 0
	DW	cloc_0458	; 1
	DW	cloc_045C	; 2
	DW	cloc_0460	; 3
	DW	cloc_0464	; 4
	DW	cloc_0468	; 5
	DW	cloc_046C	; 6
	DW	cloc_0470	; 7
	DW	cloc_0474	; 8
	DW	cloc_0478	; 9

cloc_0454:
	LDSCENE	cfile_047C	; snr\s0.lsp

cloc_0458:
	LDSCENE	cfile_0488	; snr\s1.lsp

cloc_045C:
	LDSCENE	cfile_0494	; snr\s2.lsp

cloc_0460:
	LDSCENE	cfile_04A0	; snr\s3.lsp

cloc_0464:
	LDSCENE	cfile_04AC	; snr\s4.lsp

cloc_0468:
	LDSCENE	cfile_04B8	; snr\s5.lsp

cloc_046C:
	LDSCENE	cfile_04C4	; snr\s6.lsp

cloc_0470:
	LDSCENE	cfile_04D0	; snr\s7.lsp

cloc_0474:
	LDSCENE	cfile_04DC	; snr\s8.lsp

cloc_0478:
	LDSCENE	cfile_04E8	; snr\s9.lsp

cfile_047C:
	DB	1, "snr\\s0.lsp", 0
cfile_0488:
	DB	1, "snr\\s1.lsp", 0
cfile_0494:
	DB	1, "snr\\s2.lsp", 0
cfile_04A0:
	DB	1, "snr\\s3.lsp", 0
cfile_04AC:
	DB	1, "snr\\s4.lsp", 0
cfile_04B8:
	DB	1, "snr\\s5.lsp", 0
cfile_04C4:
	DB	1, "snr\\s6.lsp", 0
cfile_04D0:
	DB	1, "snr\\s7.lsp", 0
cfile_04DC:
	DB	1, "snr\\s8.lsp", 0
cfile_04E8:
	DB	1, "snr\\s9.lsp", 0

cloc_04F4:	; entry point
	CMD2F	2, 72, 96, 8, 32, 0, 0, 0
	CMD2F	2, 72, 128, 8, 32, 0, 8, 0
	CMD2F	2, 72, 160, 8, 32, 0, 16, 0
	CMD2F	2, 72, 192, 8, 32, 0, 0, 32
	CMD2F	2, 72, 224, 8, 32, 0, 8, 32
	CMD2F	2, 72, 256, 8, 32, 0, 16, 32
	CMD2F	2, 72, 0, 8, 32, 0, 0, 64
	CMD2F	2, 72, 32, 8, 32, 0, 8, 64
	CMD2F	2, 72, 64, 8, 32, 0, 16, 64
	CMD2F	0, 0, 0, 24, 96, 0, 24, 0
	CMD2F	0, 0, 0, 24, 96, 0, 48, 0
	CMD2F	0, 0, 0, 8, 96, 0, 72, 0
	CMD2F	0, 12, 0, 60, 96, 0, 0, 96
	CMD2F	0, 0, 0, 20, 96, 0, 60, 96
	CMD2F	0, 0, 0, 80, 192, 0, 0, 192
	CMD2F	0, 0, 0, 80, 16, 0, 0, 384
	MOVI	i112, 72
	MOVI	i113, 304
	MOVI	i114, 4
	MOVI	i115, 16
	MOVI	i116, 2
	MOVI	i117, 336
	GFX63	2, 72, 288, 4, 32, 0, 2, 304
cloc_064A:
	GFX64	i1002, i112, i113, i114, i115, i1000, i116, i117
	ADDI	i117, 16
	CMPI	i117, 384
	JLT	cloc_064A
	MOVI	i112, 74
	MOVI	i113, 288
	MOVI	i114, 2
	MOVI	i115, 16
	MOVI	i116, 6
	MOVI	i117, 304
cloc_0690:
	CALL	cloc_0762
	MOVI	i113, 288
	ADDI	i116, 1
	CMPI	i116, 75
	JLT	cloc_0690
	GFX63	2, 72, 320, 2, 16, 0, 2, 384
	MOVI	i112, 74
	MOVI	i113, 320
	MOVI	i114, 2
	MOVI	i115, 16
	MOVI	i116, 4
	MOVI	i117, 384
cloc_06E0:
	GFX64	i1002, i112, i113, i114, i115, i1000, i116, i117
	ADDI	i116, 2
	CMPI	i116, 75
	JLT	cloc_06E0
	GFX63	2, 76, 288, 2, 16, 0, 76, 304
	MOVI	i112, 76
	MOVI	i113, 304
	MOVI	i116, 76
	MOVI	i117, 320
cloc_072C:
	GFX64	i1002, i112, i113, i114, i115, i1000, i116, i117
	ADDI	i117, 16
	CMPI	i117, 384
	JLT	cloc_072C
	GFX63	2, 76, 320, 2, 16, 0, 76, 384
	RET

cloc_0762:	; entry point
	MOVI	i117, 304
	GFX64	i1002, i112, i113, i114, i115, i1000, i116, i117
	ADDI	i113, 16
	ADDI	i117, 16
cloc_0786:
	GFX64	i1002, i112, i113, i114, i115, i1000, i116, i117
	ADDI	i117, 16
	CMPI	i117, 384
	JLT	cloc_0786
	RET

cloc_07AA:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_07BC	; 0
	DW	cloc_08A3	; 1
	DW	cloc_0A4F	; 2
	DW	cloc_0B3A	; 3

cloc_07BC:
	CMD3F	i323, i334
	CMD6A	16, 336, 127, 383
	TBOPEN	10, 0, 20, 9, 5, 1
	CHRDLY	i1000
	PRINT	10, cstr_0CCB
	CHRDLY	i352
	MENUSEL	i112, i113, csel_0C69, cloc_07FC
cloc_07F2:
	CMD43	i323, i334
	JP	cloc_07F2

cloc_07FC:
	JTBL	i113
	DW	cloc_0810	; 0
	DW	cloc_0808	; 1
	DW	cloc_0810	; 2
	DW	cloc_0808	; 3

cloc_0808:
	TBCLOSE	10
	JP	cloc_03E8

cloc_0810:
	SUBI	i112, 1
	TBCLOSE	10
	TBCLOSE	9
	JTBL	i112
	DW	cloc_0861	; 0
	DW	cloc_0877	; 1
	DW	cloc_088D	; 2
cstr_0828:
	DS	"セーブしました。", 1, 0
cstr_083A:
	DS	"ファイル１に", 0
cstr_0847:
	DS	"ファイル２に", 0
cstr_0854:
	DS	"ファイル３に", 0

cloc_0861:
	REGFSAV	0, cfile_0D2B	; SAVE_F1.lsp
	PRINT	12, cstr_083A
	PRINT	12, cstr_0828
	JP	cloc_03BA

cloc_0877:
	REGFSAV	0, cfile_0D38	; SAVE_F2.lsp
	PRINT	12, cstr_0847
	PRINT	12, cstr_0828
	JP	cloc_03BA

cloc_088D:
	REGFSAV	0, cfile_0D45	; SAVE_F3.lsp
	PRINT	12, cstr_0854
	PRINT	12, cstr_0828
	JP	cloc_03BA

cloc_08A3:
	FILETM	i113, s3, cfile_0D2B	; SAVE_F1.lsp
	FILETM	i114, s4, cfile_0D38	; SAVE_F2.lsp
	FILETM	i115, s5, cfile_0D45	; SAVE_F3.lsp
	MOVR	i112, i113
	ADDR	i112, i114
	ADDR	i112, i115
	CMD3F	i325, i335
	JTBL	i112
	DW	cloc_03E8	; 0
	DW	cloc_08DF	; 1
	DW	cloc_08FB	; 2
	DW	cloc_0917	; 3

cloc_08DF:
	TBOPEN	10, 0, 22, 19, 3, 1
	CMD6A	16, 368, 127, 383
	JP	cloc_092F

cloc_08FB:
	TBOPEN	10, 0, 21, 19, 4, 1
	CMD6A	16, 352, 127, 383
	JP	cloc_092F

cloc_0917:
	TBOPEN	10, 0, 20, 19, 5, 1
	CMD6A	16, 336, 127, 383
cloc_092F:
	STRCLR	s6
	STRCLR	s7
	STRCLR	s8
	CHRDLY	i1000
	CMPI	i113, 0
	JEQ	cloc_095B
	STRCPYI	s6, cstr_0CF8
	STRCAT	s6, s3
	STRCPYI	s6, cstr_0D22
cloc_095B:
	CMPI	i114, 0
	JEQ	cloc_0977
	STRCPYI	s7, cstr_0D06
	STRCAT	s7, s4
	STRCPYI	s7, cstr_0D22
cloc_0977:
	CMPI	i115, 0
	JEQ	cloc_0993
	STRCPYI	s8, cstr_0D14
	STRCAT	s8, s5
	STRCPYI	s8, cstr_0D22
cloc_0993:
	PRINT	10, cstr_0D24
	CHRDLY	i352
	JTBL	i112
	DW	cloc_09E5	; 0
	DW	cloc_09A9	; 1
	DW	cloc_09B7	; 2
	DW	cloc_09C5	; 3

cloc_09A9:
	MENUSEL	i118, i117, csel_0CBF, cloc_09D9
	JP	cloc_09CF

cloc_09B7:
	MENUSEL	i118, i117, csel_0CA9, cloc_09D9
	JP	cloc_09CF

cloc_09C5:
	MENUSEL	i118, i117, csel_0C89, cloc_09D9
cloc_09CF:
	CMD43	i325, i335
	JP	cloc_09CF

cloc_09D9:
	JTBL	i117
	DW	cloc_09ED	; 0
	DW	cloc_09E5	; 1
	DW	cloc_09ED	; 2
	DW	cloc_09E5	; 3

cloc_09E5:
	TBCLOSE	10
	JP	cloc_03E8

cloc_09ED:
	TBCLOSE	10
	TBCLOSE	9
	SUBI	i118, 1
	MOVI	i0, 0
	JTBL	i113
	DW	cloc_0A19	; 0
	DW	cloc_0A09	; 1

cloc_0A09:
	SUBI	i118, 1
	CMPI	i0, 0
	JNE	cloc_0A3B
cloc_0A19:
	JTBL	i114
	DW	cloc_0A31	; 0
	DW	cloc_0A21	; 1

cloc_0A21:
	SUBI	i118, 1
	CMPI	i0, 0
	JNE	cloc_0A45
cloc_0A31:
	REGFLD	0, cfile_0D45	; SAVE_F3.lsp
	JP	cloc_0428

cloc_0A3B:
	REGFLD	0, cfile_0D2B	; SAVE_F1.lsp
	JP	cloc_0428

cloc_0A45:
	REGFLD	0, cfile_0D38	; SAVE_F2.lsp
	JP	cloc_0428

cloc_0A4F:
	CMD3F	i336, i0
	TBOPEN	10, 1, 22, 10, 3, 1
	CHRDLY	i1000
	PRINT	10, cstr_0A8F
	CHRDLY	i352
	CMD6A	80, 368, 111, 383
	MENUSEL	i112, i113, csel_0B91, cloc_0AA0
cloc_0A85:
	CMD43	i336, i0
	JP	cloc_0A85

cstr_0A8F:
	DS	" 　小　  　大 　", 0

cloc_0AA0:
	TBCLOSE	10
	JTBL	i113
	DW	cloc_0AB4	; 0
	DW	cloc_0AB0	; 1
	DW	cloc_0AB4	; 2
	DW	cloc_0AB0	; 3

cloc_0AB0:
	JP	cloc_03E8

cloc_0AB4:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_0AC2	; 0
	DW	cloc_0AD6	; 1

cloc_0AC2:
	MOVI	i352, 1
	CHRDLY	i352
	PRINT	12, cstr_0AEA
	JP	cloc_03E8

cloc_0AD6:
	MOVI	i352, 5
	CHRDLY	i352
	PRINT	12, cstr_0B12
	JP	cloc_03E8

cstr_0AEA:
	DS	"メッセージウェイトを＜小＞にしました。", 1, 0
cstr_0B12:
	DS	"メッセージウェイトを＜大＞にしました。", 1, 0

cloc_0B3A:
	CMD3F	i337, i0
	PRINT	12, cstr_0BDF
	TBOPEN	10, 1, 22, 10, 3, 1
	CHRDLY	i1000
	PRINT	10, cstr_0B80
	CHRDLY	i352
	CMD6A	80, 368, 111, 383
	MENUSEL	i112, i113, csel_0B91, cloc_0BA7
cloc_0B76:
	CMD43	i337, i0
	JP	cloc_0B76

cstr_0B80:
	DS	"  はい   いいえ ", 0
csel_0B91:
	DW	1, 32, 368, 96, 384
	DW	2, 96, 368, 160, 384
	DW	0

cloc_0BA7:
	TBCLOSE	10
	JTBL	i113
	DW	cloc_0BBF	; 0
	DW	cloc_0BB7	; 1
	DW	cloc_0BBF	; 2
	DW	cloc_0BB7	; 3

cloc_0BB7:
	TBCLEAR	12
	JP	cloc_03E8

cloc_0BBF:
	SUBI	i112, 1
	JTBL	i112
	DW	cloc_0BCD	; 0
	DW	cloc_0BB7	; 1

cloc_0BCD:
	TBCLOSE	9
	PALFADE	0, 0
	GV02
	BGMFADE
	GV02

cunk_0BDD:	; unused
	DB	0xFF, 0xFF
cstr_0BDF:
	DS	"ＤＯＳに戻ります。", 0x0D
	DS	"よろしいですか？", 0
cstr_0C03:
	DS	"　 Ｓａｖｅ 　", 0x0D
	DS	"　 Ｌｏａｄ 　", 0x0D
	DS	"　 Ｗａｉｔ 　", 0x0D
	DS	"　 Ｅｘｉｔ 　", 0
csel_0C3F:
	DW	1, 32, 320, 144, 336
	DW	2, 32, 336, 144, 352
	DW	3, 32, 352, 144, 368
	DW	4, 32, 368, 144, 384
	DW	0
csel_0C69:
	DW	1, 16, 336, 128, 352
	DW	2, 16, 352, 128, 368
	DW	3, 16, 368, 128, 384
	DW	0
csel_0C89:
	DW	1, 16, 336, 288, 352
	DW	2, 16, 352, 288, 368
	DW	3, 16, 368, 288, 384
	DW	0
csel_0CA9:
	DW	1, 16, 352, 288, 368
	DW	2, 16, 368, 288, 384
	DW	0
csel_0CBF:
	DW	1, 16, 368, 288, 384
	DW	0
cstr_0CCB:
	DS	"　ファイル１　", 0x0D
	DS	"　ファイル２　", 0x0D
	DS	"　ファイル３　", 0
cstr_0CF8:
	DS	"　ファイル１ ", 0
cstr_0D06:
	DS	"　ファイル２ ", 0
cstr_0D14:
	DS	"　ファイル３ ", 0
cstr_0D22:
	DS	0x0D, 0
cstr_0D24:
	DS	4, 6, 4, 7, 4, 8, 0
cfile_0D2B:
	DB	1, "SAVE_F1.lsp", 0
cfile_0D38:
	DB	1, "SAVE_F2.lsp", 0
cfile_0D45:
	DB	1, "SAVE_F3.lsp", 0
