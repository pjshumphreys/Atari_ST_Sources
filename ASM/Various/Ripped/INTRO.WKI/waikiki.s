*************************************
*   THESE INTRO WAS CONVERTED TO    *
*       SOURCE BY ~Pervert~         *
*                                   *
* If you want to contact me for any *
*            reason :               *
* QUESTIONS,DONATIONS,DEMO-SWAPPING *
*   then write to address below     *
*************************************
*             ~Pervert~             *
*        ul.Apteczna 4/6 m.40       *
*           04-367  WARSAW          *
*            P O L A N D            *
*************************************

	dc.l	$a000a00a
	move.w	#4,-(a7)
	trap	#14
	move.w	d0,resol
	move.w	#3,-(a7)
	trap	#14
	move.l	d0,screen
	clr.w	-(a7)
	pea	-1.w
	pea	-1.w
	move.w	#5,-(a7)
	trap	#14
	lea	12(a7),a7
	pea	$400.w
	move.w	#32,-(a7)
	trap	#1
	move.w	#$2700,sr
	move.l	d0,super
	clr.b	$484.w
	movem.l	$ffff8240.w,d0-d7
	movem.l	d0-d7,TPAL
	movem.l	MCOL,d0-d7
	movem.l	d0-d7,$ffff8240.w
	lea	$54000,a0
	move.w	#$57ff,d0
	moveq	#0,d1
TEFF	move.l	d1,(a0)+
	move.l	d1,(a0)+
	dbf	d0,TEFF
	lea	(DESS+34),a2
	lea	$76180,a1
	jsr	ECRAN
	lea	$6B180,a1
	jsr	ECRAN
	lea	$60180,a1
	jsr	ECRAN
	lea	$55180,a1
	jsr	ECRAN
	movem.l	DESS,d0-d7
	movem.l	d0-d7,$ffff8240.w
	lea	$fffffa06.w,a0
	lea	SAVI(pc),a1
	moveq	#6,d0
PEEE	move.l	(a0)+,(a1)+
	dbf	d0,PEEE
	moveq	#1,d0
	clr.b	$fffffa1b.w
	clr.b	$fffffa09.w
	clr.b	$fffffa15.w
	move.b	d0,$fffffa07.w
	move.b	d0,$fffffa13.w
	move.l	$120.w,save120
	move.l	#THBL,$120.w
	move.l	$70.w,save70
	move.l	#TVBL,$70.w
	clr.l	$6C.w
	moveq	#0,d5
	jsr	MUS
	move.w	#$2300,sr
TSTCLA	move.b	$fffffc02.w,d5
	cmp.b	#$39,d5
	beq.s	END
	cmp.b	#$3B,d5
	beq.s	END
	cmp.b	#$3C,d5
	beq.s	END
	cmp.b	#$3D,d5
	beq.s	END
	cmp.b	#$3E,d5
	beq.s	END
	moveq	#0,d5
TSTCL2	tst.w	d5
	beq.s	TSTCL2
	bsr	MAXI
	bra.s	TSTCLA
END	move.w	#$2700,sr
	ext.w	d5
	subi.w	#$3B,d5
	lsl.l	#2,d5
	move.w	d5,$6E.w
	movem.l	MCOL,d0-d7
	movem.l	d0-d7,$ffff8240.w
	lea	$fffffa06.w,a0
	lea	SAVI(pc),a1
	moveq	#6,d0
PFFF	move.l	(a1)+,(a0)+
	dbf	d0,PFFF
TENV	move.l	save70(pc),$70.w
	move.l	save120(pc),$120.w
	move.w	#$2300,sr
TJJJ	clr.w	-(a7)
JEFF	pea	$78000
	move.l	(a7),-(a7)
	move.w	#5,-(a7)
	trap	#14
	lea	12(a7),a7
	move.b	#7,$484.w
	movem.l	TPAL,d0-d7
	movem.l	d0-d7,$ffff8240.w
	move.l	#$8080000,$ffff8800.w
	move.l	#$9090000,$ffff8800.w
	move.l	#$a0a0000,$ffff8800.w
REMU	pea	$80000
	move.w	#32,-(a7)
	trap	#1
	addq.l	#6,a7
	dc.w	$a009
	clr.w	-(a7)
	trap	#1
	illegal
SAVI	ds.l	8
MCOL	ds.l	8
THBL	
	bclr	#0,$fffffa0f.w
	movem.l	d0-d7,-(a7)
	movem.l	DESS,d0-d7
	movem.l	d0-d7,$ffff8240.w
	movem.l	(a7)+,d0-d7
	rte
THBL2	movem.l	d0-d7/a0,-(a7)
	lea	$ffff8209.w,a0
	move.b	(a0),d1
MZZ	move.b	d1,d0
	sub.b	(a0),d0
	beq.s	MZZ
	neg.b	d0
	moveq	#$10,d1
	sub.w	d0,d1
	lsl.w	d1,d0
	rept	18
	nop
	endr
	movem.l	TLTL(PC),d0-d7
	movem.l	d0-d7,$ffff8240.w
	movem.l	(a7)+,d0-d7/a0
	bclr	#0,$fffffa0f.w
	move.b	#0,$ffff820a.w
	nop
	nop
	nop
	nop
	move.b	#2,$ffff820a.w
	rte
TVBL	move.w	#$2700,sr
	movem.l	TLTL(PC),d0-d7
	lea	$ffff8240.w,a3
	movem.l	d0-d7,(a3)
	lea	$ffff820a.w,a0
	lea	$ffff8260.w,a1
	lea	$ffff8209.w,a2
	clr.b	$fffffa1B.w
	move.l	#THBL,$120.w
	move.b	#$1A,$fffffa21.w
	move.b	#8,$fffffa1B.w
	move.w	#$581,d5
Mbouc	dbf	d5,Mbouc
	move.b	#0,$ffff820a.w
	rept	10
	nop
	endr
	move.b	#2,$ffff820a.w
	rte
MAXI	move	sr,-(a7)
	bsr	(MUS+8)
	stop	#$2500
	clr.b	$fffffa1b.w
	move.l	#THBL2,$120.w
	move.b	#$CA,$fffffa21.w
	move.b	#8,$fffffa1b.w
	movea.l	TADRLET(PC),a6
	move.w	TCMPTR(PC),d7
	cmp.w	#$10,d7
	bne.s	TNONEW
	clr.w	TCMPTR
	moveq	#0,d7
	eori.w	#8,PLUSL
	bne.s	TNONEW
	moveq	#0,d6
	move.b	(a6)+,d6
	bge.s	TNINSC
	lea	TSCROLL(PC),a6
	move.b	(a6)+,d6
TNINSC	move.w	d6,TCAR
TNONEW	move.l	a6,TADRLET
	lea	TABSCR,a1
	move.l	(a1,d7.w),$ffff8200.w
	lea	TABBUf(PC),a6
	movea.l	(a6,d7.w),a6
	lea	8(a6),a4
	move.w	TCAR,d6
	subi.w	#$20,d6
	lsl.w	#1,d6
	lea	TAB,a6
	movea.w	0(a6,d6.w),a6
	adda.l	#(TLTL+34),a6
	adda.w	PLUSL(PC),a6
	lea	TSAUV,a5
	move.w	a7,$6E.w
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#12,d3
	sub.w	TCMPTR(PC),d3
	movem.w	0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$a0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$140(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$1E0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$280(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$320(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$3C0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$460(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$500(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$5a0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$640(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$6E0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$780(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$820(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$8C0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$960(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$a00(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$Aa0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$B40(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$be0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$C80(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$d20(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$dc0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$E60(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR(PC),d3
	movem.w	$f00(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movea.l	$6C.w,a7
	movea.l	TADRLE2(PC),a6
	move.w	TCMPTR2(PC),d7
	cmp.w	#$10,d7
	bne.s	TNONE2
	clr.w	TCMPTR2
	moveq	#0,d7
	eori.w	#8,PLUSL2
	bne.s	TNONE2
	moveq	#0,d6
	move.b	(a6)+,d6
	bge.s	TNINS2
	lea	TSCROL2(PC),a6
	move.b	(a6)+,d6
TNINS2	move.w	d6,TCAR2
TNONE2	move.l	a6,TADRLE2
	lea	TABBUf2(PC),a6
	movea.l	0(a6,d7.w),a6
	lea	8(a6),a4
	move.w	TCAR2,d6
	subi.w	#$20,d6
	lsl.w	#1,d6
	lea	TAB,a6
	movea.w	(a6,d6.w),a6
	adda.l	#(TLTL+34),a6
	adda.w	PLUSL2(PC),a6
	lea	TSAUV2,a5
	move.w	a7,$6E.w
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$a0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$140(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$1E0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$280(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$320(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$3C0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$460(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$500(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$5a0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$640(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$6E0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$780(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$820(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$8C0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$960(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$a00(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$Aa0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$B40(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$be0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$C80(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$d20(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$dc0(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$E60(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movem.l	(a4)+,d0-d7/a0-a3
	movem.l	d0-d7/a0-a3,-$38(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.l	(a4)+,d0-d7/a0-a3/a7
	movem.l	d0-d7/a0-a3/a7,-$3C(a4)
	movem.w	(a5)+,d0-d3
	moveq	#4,d4
	lsl.w	d4,d0
	lsl.w	d4,d1
	lsl.w	d4,d2
	lsl.w	d4,d3
	swap	d3
	move.w	#$C,d3
	sub.w	TCMPTR2(PC),d3
	movem.w	$f00(a6),d4-d7
	lsr.w	d3,d4
	lsr.w	d3,d5
	lsr.w	d3,d6
	lsr.w	d3,d7
	swap	d3
	or.w	d4,d0
	or.w	d5,d1
	or.w	d6,d2
	or.w	d7,d3
	movem.w	d0-d3,-8(a4)
	movem.w	d0-d3,-8(a5)
	addq.l	#8,a4
	movea.l	$6C.w,a7
	addq.w	#4,TCMPTR
	addq.w	#4,TCMPTR2
	rte
ECRAN	movea.l	a2,a0
	move.w	#1999,d7
ECRAM	movem.l	(a0)+,d0-d3
	movem.l	d0-d3,(a1)
	lea	16(a1),a1
	dbf	d7,ECRAM
	rts
save70	ds.l	1
save120	ds.l	1
screen	ds.l	1
resol	ds.l	1
super	ds.l	1
TABBUf	dc.l	$7e100,$73100
	dc.l	$68100,$5d100
TABBUf2	dc.l	$75000,$6a000
	dc.l	$5f000,$54000
	dc.l	TSCROLL,TSCROL2
TABSCR	dc.w	7,80,6,160,5,240,5,64,0
TADRLET	dc.l	TSCROLL
TADRLE2	dc.l	TSCROL2
PLUSL	dc.w	8
PLUSL2	dc.w	8
TCAR	ds.w	1
TCAR2	ds.w	1
TCMPTR	dc.w	16
TCMPTR2	dc.w	16
TSCROLL	dc.b	'   UPPER SCROLLER!!!            ',0
TSCROL2	dc.b	'   LOWER SCROLLER!!!            ',0
	even
TPAL	ds.w	16
TAB	incbin	\tab.wki
MUS	incbin	\music.wki
TLTL	incbin	\tltl.wki
DESS	incbin	\dess.wki
TSAUV	ds.b	$300
TSAUV2	ds.l	40