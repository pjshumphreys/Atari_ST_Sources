 movea.l 4(sp),a0       ; a0 = adresse buffer caractere
 movea.l 8(sp),a1       ; a1 = ecran travail
 move.l 12(sp),d0
 bsr scroll
 bsr scroll
 bsr scroll
 bsr scroll
 rts
scroll:
 move.w d0,d1           ; 15 lignes
 move.l a0,a2
 move.l a1,a3
scroll1:
 roxl.w (a2)+           ;scroll datas...
 roxl 152(a3)
 roxl 144(a3)
 roxl 136(a3)
 roxl 128(a3)
 roxl 120(a3)
 roxl 112(a3)
 roxl 104(a3)           ;scrolle tous les 1ers
 roxl 96(a3)            ;plans d'une ligne !
 roxl 88(a3)
 roxl 80(a3)
 roxl 72(a3)
 roxl 64(a3)
 roxl 56(a3)
 roxl 48(a3)
 roxl 40(a3)
 roxl 32(a3)
 roxl 24(a3)
 roxl 16(a3)
 roxl 8(a3)
 roxl (a3)
 adda.l #160,a3         ;ligne suivante ...
 dbra d1,scroll1
 rts
 end

 