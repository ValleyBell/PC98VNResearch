cloc_07BC:	; entry point
	CALL	cloc_0B48
	CALL	cloc_0B68
	CMPI	i560, 1
	JNE	cloc_07D0
	RET

cloc_07D0:
	CALL	cloc_0AEC
	TBOPEN	8, 5, 16, 7, 7, 1
	TBOPEN	9, 12, 16, 22, 7, 2
	CMD2F	0, 12, 264, 12, 96, 2, 68, 304
	MOVI	i560, 1
	RET
