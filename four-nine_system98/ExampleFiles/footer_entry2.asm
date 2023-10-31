cloc_080A:	; entry point
	CALL	cloc_0B48
	CALL	cloc_0B7C
	CMPI	i561, 1
	JNE	cloc_081E
	RET

cloc_081E:
	CALL	cloc_0AEC
	TBOPEN	9, 2, 19, 37, 6, 0
	MOVI	i561, 1
	RET
