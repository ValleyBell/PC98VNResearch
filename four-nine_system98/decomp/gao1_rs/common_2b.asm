cloc_0B10:	; entry point
	MOVI	i160, 0
	MOVI	i161, 1
	MOVI	i162, 2
	MOVI	i163, 60
	MOVI	i164, 288
	MOVI	i165, 16
	MOVI	i166, 0
	MOVI	i167, 1
cloc_0B40:
	WAIT	i161
	GFX3A	i161, i160, i166, i163, i167, i160, i162, i165
	ADDI	i166, 2
	ADDI	i165, 2
	CMPI	i166, 288
	JEQ	cloc_0BBC
	GFX3A	i161, i160, i166, i163, i167, i160, i162, i165
	ADDI	i166, 2
	ADDI	i165, 2
	CMPI	i166, 288
	JEQ	cloc_0BBC
	GFX3A	i161, i160, i166, i163, i167, i160, i162, i165
	ADDI	i166, 2
	ADDI	i165, 2
	CMPI	i166, 288
	JNE	cloc_0B40
cloc_0BBC:
	SUBI	i165, 1
	SUBI	i166, 1
	MOVI	i0, 0
cloc_0BCE:
	WAIT	i161
	GFX3A	i161, i160, i166, i163, i167, i160, i162, i165
	SUBI	i166, 2
	SUBI	i165, 2
	CMPI	i0, 1
	JEQ	cloc_0C4A
	GFX3A	i161, i160, i166, i163, i167, i160, i162, i165
	SUBI	i166, 2
	SUBI	i165, 2
	CMPI	i0, 1
	JEQ	cloc_0C4A
	GFX3A	i161, i160, i166, i163, i167, i160, i162, i165
	SUBI	i166, 2
	SUBI	i165, 2
	CMPI	i0, 1
	JNE	cloc_0BCE
cloc_0C4A:
	GFX63	2, 24, 392, 30, 4, 0, 2, 304
	GFX63	2, 49, 392, 31, 4, 0, 32, 304
	GFX63	2, 79, 344, 1, 50, 0, 62, 18
	GFX63	2, 79, 344, 1, 50, 0, 62, 66
	GFX63	2, 79, 344, 1, 50, 0, 62, 116
	GFX63	2, 79, 344, 1, 50, 0, 62, 166
	GFX63	2, 79, 344, 1, 50, 0, 62, 216
	GFX63	2, 79, 344, 1, 38, 0, 62, 266
	RET

cloc_0CDC:	; entry point
	TXFILL	1, 1, 30, 18, 0, 60488
	CALL	cloc_0EBA
	TXFILL	1, 1, 30, 18, 0, 60489
	CALL	cloc_0EBA
	TXFILL	1, 1, 30, 18, 0, 60490
	CALL	cloc_0EBA
	TXFILL	1, 1, 30, 18, 0, 60491
	CALL	cloc_0EBA
	TXFILL	1, 1, 30, 18, 0, 60492
	CALL	cloc_0EBA
	TXFILL	1, 1, 30, 18, 0, 60493
	CALL	cloc_0EBA
	TXFILL	1, 1, 30, 18, 0, 60494
	CALL	cloc_0EBA
	TXFILL	1, 1, 30, 18, 0, 60495
	CALL	cloc_0EBA
	TXCLR2	2, 1, 60, 18, 1
	CMD2F	1, 0, 0, 60, 288, 0, 2, 16
	PALAPL
	TXFILL	1, 1, 30, 18, 0, 60495
	CALL	cloc_0EBA
	TXFILL	1, 1, 30, 18, 0, 60494
	CALL	cloc_0EBA
	TXFILL	1, 1, 30, 18, 0, 60493
	CALL	cloc_0EBA
	TXFILL	1, 1, 30, 18, 0, 60492
	CALL	cloc_0EBA
	TXFILL	1, 1, 30, 18, 0, 60491
	CALL	cloc_0EBA
	TXFILL	1, 1, 30, 18, 0, 60490
	CALL	cloc_0EBA
	TXFILL	1, 1, 30, 18, 0, 60489
	CALL	cloc_0EBA
	TXFILL	1, 1, 30, 18, 0, 60488
	CALL	cloc_0EBA
	TXCLR2	2, 1, 60, 18, 0
	GFX63	2, 24, 392, 30, 4, 0, 2, 304
	GFX63	2, 49, 392, 31, 4, 0, 32, 304
	GFX63	2, 79, 344, 1, 50, 0, 62, 18
	GFX63	2, 79, 344, 1, 50, 0, 62, 66
	GFX63	2, 79, 344, 1, 50, 0, 62, 116
	GFX63	2, 79, 344, 1, 50, 0, 62, 166
	GFX63	2, 79, 344, 1, 50, 0, 62, 216
	GFX63	2, 79, 344, 1, 38, 0, 62, 266
	RET

cloc_0EBA:
	WAIT	i1002
	WAIT	i1002
	RET

cloc_0EC4:	; entry point
	MOVI	i160, 0
	MOVI	i161, 1
	MOVI	i162, 0
	MOVI	i163, 80
	MOVI	i165, 0
	MOVI	i166, 0
	MOVI	i167, 1
cloc_0EEE:
	WAIT	i161
	GFX3A	i161, i160, i166, i163, i167, i160, i162, i165
	ADDI	i166, 2
	ADDI	i165, 2
	CMPR	i166, i164
	JEQ	cloc_0F6A
	GFX3A	i161, i160, i166, i163, i167, i160, i162, i165
	ADDI	i166, 2
	ADDI	i165, 2
	CMPR	i166, i164
	JEQ	cloc_0F6A
	GFX3A	i161, i160, i166, i163, i167, i160, i162, i165
	ADDI	i166, 2
	ADDI	i165, 2
	CMPR	i166, i164
	JNE	cloc_0EEE
cloc_0F6A:
	SUBI	i165, 1
	SUBI	i166, 1
	MOVI	i0, 0
cloc_0F7C:
	WAIT	i161
	GFX3A	i161, i160, i166, i163, i167, i160, i162, i165
	SUBI	i166, 2
	SUBI	i165, 2
	CMPI	i0, 1
	JEQ	cloc_0FF8
	GFX3A	i161, i160, i166, i163, i167, i160, i162, i165
	SUBI	i166, 2
	SUBI	i165, 2
	CMPI	i0, 1
	JEQ	cloc_0FF8
	GFX3A	i161, i160, i166, i163, i167, i160, i162, i165
	SUBI	i166, 2
	SUBI	i165, 2
	CMPI	i0, 1
	JNE	cloc_0F7C
cloc_0FF8:
	RET

cloc_0FFA:	; entry point
	TXFILL	0, 0, 80, 25, 7, 60488
	CALL	cloc_0EBA
	TXFILL	0, 0, 40, 25, 7, 60489
	CALL	cloc_0EBA
	TXFILL	0, 0, 40, 25, 7, 60490
	CALL	cloc_0EBA
	TXFILL	0, 0, 40, 25, 7, 60491
	CALL	cloc_0EBA
	TXFILL	0, 0, 40, 25, 7, 60492
	CALL	cloc_0EBA
	TXFILL	0, 0, 40, 25, 7, 60493
	CALL	cloc_0EBA
	TXFILL	0, 0, 40, 25, 7, 60494
	CALL	cloc_0EBA
	TXFILL	0, 0, 40, 25, 7, 60495
	CALL	cloc_0EBA
	TXCLR1	0, 0, 80, 25, 1
	CMD2F	1, 0, 0, 80, 400, 0, 0, 0
	PALFADE	1, 0
	TXCLR2	0, 0, 80, 25, 0
	PALBW	1, 5
	RET

cloc_10C2:	; entry point
	MOVI	i321, 512
	MOVI	i322, 168
	MOVI	i323, 512
	MOVI	i324, 200
	MOVI	i325, 512
	MOVI	i326, 200
	MOVI	i327, 512
	MOVI	i328, 200
	MOVI	i329, 512
	MOVI	i330, 200
	MOVI	i331, 512
	MOVI	i332, 200
	REGCLR	i48, i111
	RET
