cloc_8555:
	SFXSSG	17
	MOVI	i112, 0
	MOVI	i113, 0
	MOVI	i115, 2
	MOVI	i116, 0
	CMD62	i113, i113
	ADDI	i113, 1
cloc_857D:
	CMD62	i113, i113
	WAIT	i115
	SUBI	i113, 2
	CMD62	i113, i113
	WAIT	i115
	ADDI	i113, 2
	ADDI	i116, 1
	CMPI	i116, 5
	JNE	cloc_857D
	CMD62	i112, i112
	RET

cloc_85B5:
	LOOPSTI	0
	SFXSSG	16
	CMPI	i174, 45056
	JNE	cloc_863B
	MOVI	i161, 4
	TXCLR2	72, 0, 8, 25, 1
	CMD62	i161, i1000
	MOVI	i161, 3
	CMD62	i161, i1000
	TXCLR2	72, 0, 2, 25, 0
cloc_85F7:
	LOOPJPI	1, cloc_85F7
	LOOPSTI	0
	MOVI	i161, 2
	CMD62	i161, i1000
	TXCLR2	74, 0, 2, 25, 0
	MOVI	i161, 1
	CMD62	i161, i1000
	TXCLR2	76, 0, 2, 25, 0
cloc_8631:
	LOOPJPI	1, cloc_8631
	LOOPSTI	0
cloc_863B:
	MOVI	i174, 45056
	MOVI	i161, 0
	CMD62	i161, i1000
	TXCLR2	78, 0, 2, 25, 0
	MOVI	i161, 79
	TXCLR2	0, 0, 2, 25, 1
	CMD62	i161, i1000
cloc_8671:
	LOOPJPI	1, cloc_8671
	LOOPSTI	0
	MOVI	i161, 78
	TXCLR2	2, 0, 2, 25, 1
	CMD62	i161, i1000
	MOVI	i161, 77
	TXCLR2	4, 0, 2, 25, 1
	CMD62	i161, i1000
cloc_86AB:
	LOOPJPI	1, cloc_86AB
	LOOPSTI	0
	MOVI	i161, 76
	TXCLR2	6, 0, 2, 25, 1
	CMD62	i161, i1000
	MOVI	i161, 75
	TXCLR2	8, 0, 2, 25, 1
	CMD62	i161, i1000
cloc_86E5:
	LOOPJPI	1, cloc_86E5
	LOOPSTI	0
	MOVI	i161, 76
	CMD62	i161, i1000
	TXCLR2	8, 0, 2, 25, 0
	MOVI	i161, 77
	CMD62	i161, i1000
	TXCLR2	6, 0, 2, 25, 0
cloc_871F:
	LOOPJPI	1, cloc_871F
	LOOPSTI	0
	MOVI	i161, 76
	TXCLR2	6, 0, 2, 25, 1
	CMD62	i161, i1000
	RET

cloc_8743:
	SFXSSG	16
	LOOPSTI	0
	CMPI	i174, 45056
	JNE	cloc_87C9
	MOVI	i161, 36
	TXCLR2	0, 0, 8, 25, 1
	CMD62	i161, i1000
	ADDI	i161, 1
	CMD62	i161, i1000
	TXCLR2	6, 0, 2, 25, 0
	ADDI	i161, 1
cloc_878B:
	LOOPJPI	1, cloc_878B
	LOOPSTI	0
	CMD62	i161, i1000
	TXCLR2	4, 0, 2, 25, 0
	ADDI	i161, 1
	CMD62	i161, i1000
	TXCLR2	2, 0, 2, 25, 0
cloc_87BF:
	LOOPJPI	1, cloc_87BF
	LOOPSTI	0
cloc_87C9:
	MOVI	i174, 45056
	MOVI	i161, 0
	CMD62	i161, i1000
	TXCLR2	0, 0, 2, 25, 0
	MOVI	i161, 1
	TXCLR2	78, 0, 2, 25, 1
	CMD62	i161, i1000
cloc_87FF:
	LOOPJPI	1, cloc_87FF
	LOOPSTI	0
	MOVI	i161, 2
	TXCLR2	76, 0, 2, 25, 1
	CMD62	i161, i1000
	MOVI	i161, 3
	TXCLR2	74, 0, 2, 25, 1
	CMD62	i161, i1000
cloc_8839:
	LOOPJPI	1, cloc_8839
	LOOPSTI	0
	MOVI	i161, 4
	TXCLR2	72, 0, 2, 25, 1
	CMD62	i161, i1000
	MOVI	i161, 5
	TXCLR2	70, 0, 2, 25, 1
	CMD62	i161, i1000
cloc_8873:
	LOOPJPI	1, cloc_8873
	LOOPSTI	0
	MOVI	i161, 4
	CMD62	i161, i1000
	TXCLR2	70, 0, 2, 25, 0
	MOVI	i161, 3
	CMD62	i161, i1000
	TXCLR2	72, 0, 2, 25, 0
cloc_88AD:
	LOOPJPI	1, cloc_88AD
	LOOPSTI	0
	MOVI	i161, 4
	TXCLR2	72, 0, 2, 25, 1
	CMD62	i161, i1000
	RET

cloc_88D1:
	MOVI	i174, 0
	WAIT	i1001
	CMD62	i1000, i1000
	TXCLR2	0, 0, 8, 25, 0
	TXCLR2	72, 0, 8, 25, 0
	RET
