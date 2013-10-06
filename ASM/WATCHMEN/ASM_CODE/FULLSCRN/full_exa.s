************************************
* FULLSCREEN 460*274 68000 ROUTINE *
* CODED BY KILLER D FROM CONNEXION *
* ON 9/90 .  (C) KILLER D Software *
************************************
*
* CETTE ROUTINE AFFICHE UN FICHIER *.KID
* A L'ECRAN. IL FAUT CREER UN BUFFER DE 63 K0 POUR
* L'ECRAN ET FAIRE UN XBIOS(5) POUR CALER LES
* ADRESSES XBIOS(3) ET XBIOS(2) SUR L'ADRESSE >>PICTURE<<
* (LA OU EST L'ECRAN).
*
* GLORY CONNEXION
* GLORY KILLER D & HUTCH
*
* (EXCUSEZ DE METTRE ICI CES MACROS POURLINGUES, MAIS CA SIMPLIFIE
* LA VIE...)

TERM      macro               
          clr.w     -(sp)
          trap      #1
          endm
CLS 	  macro
	  CCONOUT #27
	  CCONOUT #'E'
	  endm
WAIT      macro               
          move.w    #7,-(sp)
          trap      #1
          addq.l    #2,sp
          endm
PRINTLINE macro     $\1
          pea       \1        
          move.w    #9,-(sp)
          trap      #1
          addq.l    #6,sp
          endm
SUPER     macro
          clr.l     -(sp)       
          move.w    #$20,-(sp)
          trap      #1
          addq.l    #6,sp
          move.l    d0,PILE  
          endm
USER      macro
          move.l    PILE,-(sp)
          move.w    #$20,-(sp) 
          trap      #1
          addq.l    #6,sp
          endm
; FIN DES MACROS...

	SUPER		    ; EN SUPERVISEUR

	DC.W $A00A          ; PLUS DE SOURIS 

	MOVE	#15754,D0   ; L'ECRAN FAIT 63020 OCTETS: 63020/4-1=15754
	
* METTRE VOS ADRESSES ICI ET LA DESSOUS:


 LEA	$78000,A0   ; ADRESSE DESTINATION(METTEZ LA VOTRE)
 LEA	$68000,A2   ; SINON CA MARCHE PAS... (IL BLOQUE EN FOND DE RAM)

	LEA	PICTURE+34,A1  ; L'IMAGE EST 34 OCT APRES LE DEBUT DU
			       ; FICHIER *.KID

AFF1	MOVE.L	(A1),(A0)+
	MOVE.L	(A1)+,(A2)+
	DBF	D0,AFF1
	
	*COULEURS:
	
	MOVEM.L	PICTURE+2,D0-D7
	MOVEM.L	D0-D7,$FF8240
	
	MOVE.L	#$78000,BASE	*INIT ADR ECR
	MOVE.B	#7,$FF8201
	USER




	PEA	ROUTINE
	MOVE.W	#$26,-(A7)
	TRAP	#14
	ADDQ.L	#6,A7

	TERM

;	
; ROUTINE A EXECUTER EN SUPERVISEUR:
;
 
ROUTINE	DC.W	$A00A
	LEA	$FFFFFA13.W,A6
	MOVE.B	(A6),D7
	MOVE.B	2(A6),D6
	CLR.B	(A6)
	CLR.B	2(A6)
	LEA	$FFFF8209.W,A0
	LEA	$57(A0),A1
	LEA	1(A0),A2
	MOVE.B	(A1),D5
	CLR.B	D0
	MOVEQ	#2,D1
	LEA	$70.W,A5
	MOVEA.L	(A5),A4
	LEA	K4D4,A3
	MOVE.L	A3,(A5)
	MOVE.B	#$39,D4
	LEA	$FFFFFC02.W,A3
K4C4	CMP.B	(A3),D4
	BNE.S	K4C4
	MOVE.L	A4,(A5)
	MOVE.B	D5,(A1)
	MOVE.B	D6,2(A6)
	MOVE.B	D7,(A6)
	RTS
K4D4	MOVE.W	#$59B,D2
K4D8	DBF	D2,K4D8
	MOVE.B	#$10,D2
	MOVE.B	D0,(A2)
	MOVEQ	#1,D3
K4E4	DBF	D3,K4E4
	MOVE.B	D1,(A2)
K4EA	MOVE.B	(A0),D3
	BEQ.S	K4EA
	SUB.B	D3,D2
	LSL.B	D2,D3
	MOVE.W	#$E2,D2
	MOVEQ	#$1E,D3
K4F8	DBF	D3,K4F8
K4FC	NOP
	MOVE.B	D1,(A1)
	MOVE.B	D0,(A1)
	MOVEQ	#$1C,D3
K504	DBF	D3,K504
	MOVE.B	D0,(A2)
	MOVE.B	D1,(A2)
	MOVE.W	#2,D3
K510	DBF	D3,K510
	NOP
	MOVE.B	D1,(A1)
	NOP
	MOVE.B	D0,(A1)
	MOVE.W	#1,D3
K520	DBF	D3,K520
	DBF	D2,K4FC
	MOVE.B	D1,(A1)
	MOVE.B	D0,(A1)
	MOVEQ	#$1C,D3
K52E	DBF	D3,K52E
	MOVE.B	D0,(A2)
	MOVE.B	D1,(A2)
	MOVE.W	#$2C,D2
	MOVEQ	#2,D3
K53C	DBF	D3,K53C
	MOVE.B	D1,(A1)
	NOP
	MOVE.B	D0,(A1)
	MOVE.B	D0,(A2)
	MOVE.W	#1,D3
K54C	DBF	D3,K54C
	MOVE.B	D1,(A2)
K552	MOVE.B	D1,(A1)
	MOVE.B	D0,(A1)
	MOVEQ	#$1C,D3
K558	DBF	D3,K558
	MOVE.B	D0,(A2)
	MOVE.B	D1,(A2)
	MOVE.W	#2,D3
K564	DBF	D3,K564
	NOP
	MOVE.B	D1,(A1)
	NOP
	MOVE.B	D0,(A1)
	MOVE.W	#1,D3
K574	DBF	D3,K574
	NOP
	DBF	D2,K552
	RTE



	SECTION DATA
	
PICTURE	INCBIN	"B:\KIDOS.KID"
	
	SECTION BSS

BASE	DS.L	1
	EVEN
	DS.L	200
PILE	DS.L	2






