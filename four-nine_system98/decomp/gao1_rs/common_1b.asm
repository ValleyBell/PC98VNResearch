cloc_07EA:	; entry point (unused)
	MOVI	i112, 1
	MOVI	i113, 0
	MOVI	i114, 0
	MOVI	i115, 60
	MOVI	i116, 1
	MOVI	i117, 0
	MOVI	i118, 2
	MOVI	i119, 16
	MOVI	i120, 144
cloc_0820:
	BLIT1R	i112, i113, i114, i115, i116, i117, i118, i119
	ADDI	i114, 2
	ADDI	i119, 2
	SUBI	i120, 1
	CMPI	i120, 0
	JNE	cloc_0820
	MOVI	i114, 287
	MOVI	i119, 303
	MOVI	i120, 144
cloc_0860:
	BLIT1R	i112, i113, i114, i115, i116, i117, i118, i119
	SUBI	i114, 2
	SUBI	i119, 2
	SUBI	i120, 1
	CMPI	i120, 0
	JNE	cloc_0860
	RET

cloc_0890:	; entry point
	MOVI	i48, 0
	MOVI	i49, 0
	MOVI	i50, 0
	MOVI	i51, 0
	MOVI	i52, 0
	MOVI	i53, 0
	MOVI	i54, 0
	MOVI	i55, 0
	MOVI	i56, 0
	MOVI	i57, 0
	MOVI	i58, 0
	MOVI	i59, 0
	MOVI	i60, 0
	MOVI	i61, 0
	MOVI	i62, 0
	MOVI	i63, 0
	MOVI	i321, 0
	MOVI	i323, 0
	MOVI	i325, 0
	MOVI	i327, 0
	MOVI	i329, 0
	MOVI	i331, 0
	MOVI	i322, 0
	MOVI	i324, 0
	MOVI	i326, 0
	MOVI	i328, 0
	MOVI	i330, 0
	MOVI	i332, 0
	RET

cloc_093A:	; entry point
	MOVI	i80, 0
	MOVI	i81, 0
	MOVI	i82, 0
	MOVI	i83, 0
	MOVI	i84, 0
	MOVI	i85, 0
	MOVI	i86, 0
	MOVI	i87, 0
	MOVI	i88, 0
	MOVI	i89, 0
	MOVI	i90, 0
	MOVI	i91, 0
	MOVI	i92, 0
	MOVI	i93, 0
	MOVI	i94, 0
	MOVI	i95, 0
	RET

cfile_099C:
	DB	1, "SNR\\S0.LSP", 0
cfile_09A8:
	DB	1, "SNR\\S1.LSP", 0
cfile_09B4:
	DB	1, "SNR\\S2.LSP", 0
cfile_09C0:
	DB	1, "SNR\\S3.LSP", 0
cfile_09CC:
	DB	1, "SNR\\S4.LSP", 0
cfile_09D8:
	DB	1, "SNR\\S5.LSP", 0
cfile_09E4:
	DB	1, "SNR\\S6.LSP", 0
cfile_09F0:
	DB	1, "SNR\\S7.LSP", 0
cfile_09FC:
	DB	1, "SNR\\S8.LSP", 0
cfile_0A08:
	DB	1, "SNR\\S9.LSP", 0
cstr_0A14:
	DS	"　 Ｓａｖｅ 　", 0x0D
	DS	"　 Ｌｏａｄ 　", 0x0D
	DS	"　 Ｗａｉｔ 　", 0x0D
	DS	"　 Ｅｘｉｔ 　", 0
csel_0A50:
	DW	1, 512, 160, 624, 176
	DW	2, 512, 176, 624, 192
	DW	3, 512, 192, 624, 208
	DW	4, 512, 208, 624, 224
	DW	0
cstr_0A7A:
	DS	"　ファイル１　", 0x0D
	DS	"　ファイル２　", 0x0D
	DS	"　ファイル３　", 0
csel_0AA7:
	DW	1, 496, 192, 608, 208
	DW	2, 496, 208, 608, 224
	DW	3, 496, 224, 608, 240
	DW	0
csel_0AC7:
	DW	3, 336, 240, 608, 256
csel_0AD1:
	DW	2, 336, 224, 608, 240
csel_0ADB:
	DW	1, 336, 208, 608, 224
	DW	0
cfile_0AE7:
	DB	1, "SAVE_F1.LSP", 0
cfile_0AF4:
	DB	1, "SAVE_F2.LSP", 0
cfile_0B01:
	DB	1, "SAVE_F3.LSP", 0
cstr_0B0E:
	DS	"ファイル１に", 0
cstr_0B1B:
	DS	"ファイル２に", 0
cstr_0B28:
	DS	"ファイル３に", 0
cstr_0B35:
	DS	"セーブしました。", 1, 0
cstr_0B47:
	DS	4, 6, 4, 7, 4, 8, 0
cstr_0B4E:
	DS	"　ファイル１ ", 0
cstr_0B5C:
	DS	"　ファイル２ ", 0
cstr_0B6A:
	DS	"　ファイル３ ", 0
cstr_0B78:
	DS	0x0D, 0
cstr_0B7A:
	DS	"　小　　大　", 0
csel_0B87:
	DW	1, 512, 224, 560, 240
	DW	2, 560, 224, 608, 240
	DW	0
cstr_0B9D:
	DS	"メッセージウェイトを＜小＞にしました。", 1, 0
cstr_0BC5:
	DS	"メッセージウェイトを＜大＞にしました。", 1, 0
cstr_0BED:
	DS	"ＤＯＳに戻ります。", 0x0D
	DS	"よろしいですか？", 0
cstr_0C11:
	DS	" はい いいえ", 0
csel_0C1E:
	DW	1, 512, 240, 560, 256
	DW	2, 560, 240, 608, 256
	DW	0
