;
; PROGRAMME DE DESTRUCTION DES MUSIQUES VIDES
;
LOAD=$40000

	BRA	SKIPFILE
FILE:
	IF	0=1
	DC.B	"ASTAR.MUS",0
	DC.B	"ASTAR2.MUS",0
	DC.B	"THALION.MUS",0
	DC.B	"MADMUS2.MUS",0
	DC.B	"NY3.MUS",0
	DC.B	"SPACEBAL.MUS",0
	DC.B	"WEIRD.MUS",0
	DC.B	"DRAGON1.MUS",0
	DC.B	"FOLEY1.MUS",0
	DC.B	"THAL1.MUS",0
	DC.B	'MASTER2.MME',0
	ENDIF

	DC.B	'COSO28.PAK',0
	DC.B	'COSO49.PAK',0
	EVEN
SKIPFILE:

PRINT:	MACRO
	PEA	?1
	MOVE	#9,-(SP)
	TRAP	#1
	ADDQ	#6,SP
	ENDM

	LEA	LOAD,A0
	MOVE	#32000/4-1,D0
CLEAR:	CLR.L	(A0)+
	DBRA	D0,CLEAR

	PRINT	FILE(PC)
	PRINT	CR(PC)

	CLR	-(SP)
	PEA	FILE(PC)
	MOVE	#$3D,-(SP)
	TRAP	#1
	ADDQ	#8,SP
	MOVE.L	D0,D6
	BMI	ERREUR

	PEA	LOAD
	PEA	32000
	MOVE	D6,-(SP)
	MOVE	#$3F,-(SP)
	TRAP	#1
	LEA	12(SP),SP
	MOVE.L	D0,D7		;NB BYTES
	BMI	ERREUR

	MOVE	D6,-(SP)
	MOVE	#$3E,-(SP)
	TRAP	#1
	ADDQ	#4,SP

	LEA	LOAD,A6
	MOVE.L	A6,A5
	ADD.L	$14(A6),A5
	MOVEQ	#0,D6
TSTMUS:
	ADDQ	#1,D6
	MOVE	(A5),D0
	OR	2(A5),D0
	OR	4(A5),D0
	BEQ	FINI

	MOVE	(A5),D0
	MULU	#12,D0
	MOVE.L	A6,A0
	ADD.L	D0,A0
	ADD.L	$10(A6),A0

	MOVE	2(A5),D0
	ADDQ	#1,D0
	MULU	#12,D0
	MOVE.L	A6,A1
	ADD.L	D0,A1
	ADD.L	$10(A6),A1

	MOVEQ	#0,D0
ORL:
	OR	(A0)+,D0
	CMP.L	A1,A0
	BLO.S	ORL

	TST	D0
	BNE.S	ZERO

	MOVEQ	#'0',D0
	ADD	D6,D0
	MOVE.B	D0,AFF
	PRINT	AFF0(PC)

	MOVE.L	A5,A0
MOVEL:
	MOVE	6(A0),(A0)+
	MOVE	6(A0),(A0)+
	MOVE	6(A0),(A0)+
	MOVE	(A0),D0
	OR	2(A0),D0
	OR	4(A0),D0
	BNE.S	MOVEL

	CMP.L	#'COSO',(A6)
	BNE.S	ZERO
	SUBQ.L	#6,D7
ZERO:
	ADDQ	#6,A5
	BRA	TSTMUS

FINI:
	LEA	LOAD,A0
	MOVE.L	A0,A1
	ADD.L	D7,A1
	MOVE.L	A0,A2
	ADD.L	$14(A2),A2
	ILLEGAL

ERREUR:
	ILLEGAL
CR:	DC.B	13,10,0
AFF0:	DC.B	"MUSIQUE "
AFF:	DC.B	'0 DEGAGEE',13,10,0
	EVEN
