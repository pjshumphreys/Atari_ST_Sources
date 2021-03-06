; REMBRANDT 3.0 - �  Dbug II
;
; Module de gestion des fichiers. (1.9)
;
; Cette version permet de charger des fichiers au format:
; - *.ART (Art Director, � MirrorSoft Ltd)
; - *.BMP (Windows Bitmap, � Microsoft)
; - *.CA1 (Crack Art compact� et non compact�)
; - *.GIF (Graphic Interchange Format, � CompuServ)
; - *.IIM (Inshape IMage,� ???)
; - *.IFF (Interchange File Format, compact� ou non, avec rasters ou non)
; - *.JPG (Joint Photographic Expert Group)
; - *.KID (FullShow, � Killer D/FMC-CNX)
; - *.NEO (Neochrome, � Dave Staugas)
; - *.PC1 (Degas basse r�solution compact�, � Tom Hudson)
; + *.PCX (PC Paint Brush,� Z-Soft & Microsoft Corp)
; - *.PI1 (Degas basse r�solution non compact�, � Tom Hudson)
; - *.PNT (Prism Paint, � Lexicor Software)
; - *.SD0 (Dali basse r�solution) [� tester]
; - *.SPC (Spectrum 512 compact�, � TRIO Inc) 
; - *.SPU (Spectrum 512 non compact�, � TRIO Inc)
; - *.TCP (Rembrandt True Color Picture, � Dbug II/NeXT)
; - *.TG1 (COKE format)
; - *.TGA (Targa Bit Image)
; - *.TPI (True Paint, � HiSoft)
; - *.XGA (XGA Show)
;
;  Am�liorations de la version 1.2:
;   - Le chargement fait appel � de l'allocation m�moire temporaire.
;     d'ou un gain de m�moire pour les op�rations graphiques de type bloc !
;   - La petite taille de la BSS fait que si l'on ne charge rien, il ne
;     prends quasiment pas de place. D'ou de la place pour acc�der aux
;     accessoires ou aux utilitaires r�sidents (Je ne parle pas de MultiTOS
;     parce que je ne pense pas qu'il sera utilisable avec !)
; 
;  Am�liorations de la version 1.5:
;   - La routine de d�packing RLE (PackBits) fonctionne quelque soit le
;     nombre de lignes, de colonnes, et de plans...
; 
;  Am�liorations de la version 1.6:
;   - La routine de chargement IFF est quasi termin�e. Elle fonctionne
;     quel que soit la taille de l'image [?] et le nombre de plans. Les
;     images HAM sont parfaitement charg�es (sauf les premiers pixels �
;     gauche de l'�cran...
;
;  Am�liorations de la version 1.7:
;   - Possibilit� de sp�cifier le type de format de l'image. Donc, la 
;     d�tection ne se fait plus sur l'extension. Il devient possible de
;     charger une image Degas portant l'extension .PIC... Le titre du
;     s�lecteur d'objet change selon la fonction choisie.
;
;  Am�liorations de la version 1.8:
;   - Possibilit� de sauvegarder au format COKE TrueColor (TG1)
;   - Impl�mentation du format TCP (type 1 non compact�)
;   - Limitation des plantages intempestifs de part l'utilisation de tests
;     sur la m�moire occup�e aux divers stades du travail.
;
;  Am�liorations de la version 1.9:
;   - Le format IFF est charg� en mode 64 et 256 couleurs.
;   - Impl�mentation du format JPEG.
;   - Impl�mentation du format BMP.
;   - [Impl�mentation du format PCX].
;   - [Gestion des fichiers RIM].	-> Pipe
;   - Impl�mentation des images InShape (IIM).
;
; A rajouter: Le RAW, et le DIS g�n�r�s par POV.
;

 ifeq _main_part
 <pREMB_xxx.S>q doit �tre assembl� !!!
 END
 endc

version_tcp=1

 TEXT

; Pour quitter:
; BRA FIN_OP�RATION_DISK -> Uniquement si les buffers ont �t� touch�s,
;                           et qu'un formulaire a �t� utilis�.
; BRA FERME_FORMULAIRE   -> Les autres cas
;

;
; On arrive ici en mode chargement automatique
;
charge_image_automatique
 st flag_format_pic
 move.l #txt_chargement_par_nom,adresse_txt_chargement
 bra.s charge_image

;
; On arrive ici en mode chargement selon le type
;
charge_image_s�lection
 sf flag_format_pic
  
charge_image
 tst.b flag_sauv�e			Si l'image n'a pas �t� modifi�e
 bne .charge_image			(flag=-1), pas de message
 boite_alerte #1,#alert_image_pas_sauv�e
 cmp #1,int_out
 bne ferme_formulaire
.charge_image

 clr.b nom_fichier			Efface le nom du fichier.
 lea nom_image,a0			R�installe le nom ant�rieur de
 lea nom_fichier,a1			chargement s'est bien pass�, on
.recopie_nom
 move.b (a0)+,(a1)+			m�morise le nom de l'image.
 bne.s .recopie_nom

; Selon le flag, on charge directement l'image, avec une reconnaissance
; automatique du format, ou alors on commence par s�lectionner le type
; de fichier dans le s�lecteur de drivers.
;
 tst.b flag_format_pic
 bne.s .appelle_s�lecteur_fichiers

 bsr gere_chargement_s�lection
 bmi fin_op�rations_disk
 
.appelle_s�lecteur_fichiers
 fsel_exinput #chemin_fichier,#nom_fichier,adresse_txt_chargement
 tst int_out+2			Cas o� l'on a fait ANNULER...
 beq restaure_nom_fichier
 tst int_out			Cas o� ???
 beq restaure_nom_fichier
 
 graf_mouse #2			Une abeille pendant qu'on travaille !!!

 bsr analyse_chemin_fichier
 bsr positionne_chemin		Modifie le chemin d'acc�s au fichier
 bsr teste_existance_fichier
 bne fin_op�rations_disk	Si le fichier n'existe pas !

 tst.b flag_format_pic		Si on a le formulaire, on ne teste pas
 beq.s .effectue_chargement	l'extension du fichier...

.v�rifie_extension
 lea liste_formats_automatique,a0
 move.l extension,d0
.cherche_extension_chargement
 move.l (a0)+,d1
 cmp.l #-1,d1
 beq .extension_non_trouv�e
 cmp.l d0,d1
 beq .extension_trouv�e 
 addq #8,a0
 bra .cherche_extension_chargement

.extension_non_trouv�e
 boite_alerte #1,#alert_mauvaise_extension	Connais pas ce format
 jmp fin_op�rations_disk			d'image... Dommage.
  
.extension_trouv�e	
 move.l (a0)+,adresse_routine_chargement

 move.l (a0)+,a0			Change le format dans la boite
 move.l ptr_chargement_image,a1
 move.l a0,([ob_spec+objet_chargement_form*24,a1])

.effectue_chargement
 lea fichier,a0				On commence par faire de la place
 bsr lib�re_bloc			en m�moire. (Plus d'image)
   
 move.l taille_fichier,d0		Taille du fichier par FSFIRST.
 lea buffer_fichier,a0			Bloc de d�finition
 bsr r�serve_bloc			Zou ! On veut de la m�moire mec !
 beq .ok_charge_le_fichier		Il semblerait qu'il y eu un petit
 boite_alerte #1,#alert_m�moire_chargement	probl�me de place !!!
 jmp fin_op�rations_disk
 
.ok_charge_le_fichier   
 moveq #0,d0
 bsr affiche_formulaire_chargement
 bsr charge_fichier			On charge le fichier en m�moire
 bsr ferme_formulaire
 tst d0					si il n'y a pas d'erreur, on le
 bne fin_op�rations_disk		convertie, sinon Bye bye...

 bsr nettoye_avant_chargement
 clr nombre_couleurs			Pour d�tecter les images TrueColor
 
 jsr ([adresse_routine_chargement])	Ex�cute la routine de conversion
 bmi fin_op�rations_disk

 bsr copie_palette_image		Recopie la palette �ventuellement

 lea nom_fichier,a0			Lorsque l'on est sur que le 
 lea nom_image,a1			chargement s'est bien pass�, on
.recopie_nom_image
 move.b (a0)+,(a1)+			m�morise le nom de l'image.
 bne.s .recopie_nom_image

 bsr compose_infos_fenetre		Met � jour la ligne d'infos !
    
fin_op�rations_disk
 lea buffer_fichier,a0			Bloc de d�finition
 bsr lib�re_bloc			Zou ! On lib�re (Qu'il exista ou non !)
 lea buffer_d�packing,a0		Bloc de d�finition
 bsr lib�re_bloc			Zou ! On lib�re (Qu'il exista ou non !)
 bsr teste_image_pas_d�faut
 bsr ferme_formulaire
 graf_mouse #0				On remet la fl�che...
 rts

;
; On aboutit ici chaque fois qu'un chargement �choue mais avant que l'on
; ai commenc� de charger le bloc : L'image ant�rieure est toujours l�,
; donc on la maintient en entier !
;
restaure_nom_fichier
 lea nom_image,a0			Lorsque l'on est sur que le 
 lea nom_fichier,a1			chargement s'est bien pass�, on
.recopie_nom
 move.b (a0)+,(a1)+			m�morise le nom de l'image.
 bne.s .recopie_nom

 lea buffer_d�packing,a0		Bloc de d�finition
 bsr lib�re_bloc			Zou ! On lib�re (Qu'il exista ou non !)

 bsr ferme_formulaire
 graf_mouse #0				On remet la fl�che...
 rts
 
; Si pour une raison o� une autre, il se trouve que le chargement �choue,
; il faut forcer la cr�ation d'une image vide.
;
;
teste_image_pas_d�faut
 tst.l fichier
 bne.s .image_ok
 move #640,largeur_image	On attribue par d�faut une image 320x200
 move #200,hauteur_image
 bsr.l pr�pare_buffer_image
.image_ok
 rts 
 

; Dans D0, on � le num�ro du titre � inscrire:
; 0-> Chargement
; 1-> D�compactage
; 2-> Transformation
; 3-> Sauvegarde
;
affiche_formulaire_chargement
 movem.l d0-a6,-(sp)
 move.l ptr_chargement_image,a0
 move.l a0,adresse_formulaire

 move.l #txt_sauve_image,d1
 cmp #3,d0
 beq.s .inscrit_chaine
 move.l #txt_convertie_image,d1
 cmp #2,d0
 beq.s .inscrit_chaine
 move.l #txt_d�packe_image,d1
 cmp #1,d0
 beq.s .inscrit_chaine
 move.l #txt_charge_image,d1

.inscrit_chaine
 move.l d1,([ob_spec+objet_chargement_quoi*24,a0])
 move.l #nom_fichier,([ob_spec+objet_chargement_nom*24,a0])

 bsr affiche_formulaire
 movem.l (sp)+,d0-a6
 rts





gere_format_sauvegarde
 move.l ptr_format_sauve,adresse_formulaire

 move.l adresse_formulaire,a0
 move format_d�faut_sauvegarde,d0
 mulu #24,d0
 bset #state_selected,ob_state+1(a0,d0.w)
 
 bsr affiche_formulaire
 bsr gere_formulaire
 move objet_exit,d0
 cmp #objet_sauve_annule,d0
 beq .annule_sauvegarde
 cmp #objet_sauve_confirme,d0
 bne .prends_format_choisi
 move format_d�faut_sauvegarde,d0	Si c'est CONFIRME, on prends le meme type !
.prends_format_choisi

; Si on arrive ici, c'est que l'on a choisi un des types de fichier
; propos� dans la ressource. Il faut donc acceder � la routine qui
; correspond.
 move d0,format_d�faut_sauvegarde
 
 lea liste_formats_sauvegarde,a0
.teste_format_suivant
 cmp 4(a0),d0
 beq.s .format_trouv�
 lea 14(a0),a0
 bra.s .teste_format_suivant

.format_trouv� 
 move.l (a0)+,extension
 addq #2,a0
 move.l (a0)+,adresse_routine_sauvegarde
 
 move.l (a0),a0			Chaine de caract�res correspondant
 lea txt_sauvegarde_choisie,a1	Message du fileselect
.recopie_texte
 move.b (a0)+,(a1)+
 bne.s .recopie_texte
   
.confirme_format_image  
 bsr ferme_formulaire
 moveq #0,d0
 rts

.annule_sauvegarde
 bsr ferme_formulaire
 moveq #-1,d0
 rts

  
nettoye_avant_chargement
 lea allocation_palettes,a0		R�initialise les pointeurs sur les
 lea fin_allocation_palettes,a1		diverses palettes (NeoMaster).
.efface_palettes
 clr.l (a0)+
 cmpa.l a1,a0
 blt.s .efface_palettes

 clr.b nom_image			Efface le nom de l'image
 clr.b infos_texte_1			ainsi que les commentaires qui
 clr.b infos_texte_2			l'accompagnent.
 clr.b infos_texte_3
 clr.b infos_texte_4
 rts




m�morise_chemin_disk
 move #$19,-(sp)		DGetDrv
 trap #1
 addq #2,sp
 add #'A',d0			On � la lettre qui correspond au lecteur
 lea chemin_fichier,a6		courant...
 move.b d0,(a6)+		�crit le caract�re
 move.b #':',(a6)+		Puis le ':' qui suit le drive.
 
 clr -(sp)
 pea (a6)		*repertoire
 move #$47,-(sp)		DGetPath
 trap #1			On inscrit le r�pertoire � la suite.
 addq #8,sp

.cherche_fin_r�pertoire
 tst.b (a6)+
 bne.s .cherche_fin_r�pertoire
 move.b #'\',-1(a6)		On met un '\' � la fin du r�pertoire. 
 clr.b (a6)			Ne pas oublier le z�ro final !!!
 rts


 
positionne_chemin
 moveq #0,d0
 move.b repertoire,d0
 sub #'A',d0
 move d0,-(sp)		Il faut aussi changer le drive par d�faut...
 move #$e,-(sp)
 trap #1
 addq #4,sp

 pea repertoire		Change le r�pertoire courant
 move #$3b,-(sp)	pour que les acc�s suivants se fasse
 trap #1		dans le meme r�pertoire
 addq #6,sp
 tst d0
 bmi erreur_fichier_absent
 rts






sauve_image_directe
sauve_image
 bsr gere_format_sauvegarde
 bmi fin_op�rations_disk
 jsr ([adresse_routine_sauvegarde])	Ex�cute la routine de conversion
 bmi fin_op�rations_disk

 lea nom_image,a0		R�installe le nom ant�rieur de
 lea nom_fichier,a1		l'image pour pouvoir la sauver.
 moveq #8-1,d0			Le nom fait 8 caract�res au maximum.
.recopie_nom
 move.b (a0)+,d0
 beq.s .met_extension
 cmp.b #'.',d0
 beq.s .met_extension
 move.b d0,(a1)+
 dbra d0,.recopie_nom
.met_extension
 move.l extension,(a1)+
 clr.b (a1)+ 
 
 fsel_exinput #chemin_fichier,#nom_fichier,#txt_sauvegarde_image
 tst int_out+2
 beq fin_op�rations_disk
 tst int_out
 beq fin_op�rations_disk

 bsr analyse_chemin_fichier
 bsr positionne_chemin			Modifie le chemin d'acc�s au fichier

 bsr teste_place_disque
 bmi fin_op�rations_disk
  
 moveq #3,d0
 bsr affiche_formulaire_chargement
 bsr sauve_fichier			On charge le fichier en m�moire
 bsr ferme_formulaire

 st flag_sauv�e
 sf flag_chang�e
 jmp fin_op�rations_disk		puis on retourne au programme.


analyse_chemin_fichier   
 lea chemin_fichier,a0	On recherche le chemin d'acc�s au fichier
 lea repertoire,a1	mais sans le nom du fichier lui meme
.recopie
 move.b (a0)+,(a1)+
 bne .recopie
.ote_extension
 move.b -(a1),d0
 cmp.b #"\",d0
 beq .fin_recherche
 cmp.b #":",d0
 beq .fin_recherche
 cmp.l #repertoire,a1
 bne .ote_extension   
.fin_recherche 
 clr.b 1(a1)
 rts



; Pour savoir si le fichier tiendra sur le disque que l'on � s�lectionn�,
; il suffit de faire un calcul simple:
; - On prend la m�moire libre avec DFREE
; - On teste l'existance d'un fichier portant le meme nom. Si on en trouve
;   un, on rajoute la place occup�e par ce fichier � la place libre.
; - On compare la place libre que l'on a trouv� � la taille de notre
;   fichier... C'est simple non ?
;
teste_place_disque
 clr -(sp)			Lecteur courant
 pea disk_infos			Buffer pour les informations
 move #$36,-(sp)
 trap #1
 addq #8,sp

 move.l taille_fichier,-(sp)
 bsr teste_existance_fichier
 bmi.s .fichier_inexistant
 move.l taille_fichier,d0
 move.l taille_secteur,d1
 divu.l d1,d0				-> Nombre de secteurs
 move.l secteurs_par_cluster,d1
 divu.l d1,d0				-> Nombre de clusters
 add.l d0,clusters_libres		Rajoute aux clusters libres !
.fichier_inexistant
 move.l (sp)+,taille_fichier  

 move.l taille_fichier,d0
 move.l taille_secteur,d1
 divu.l d1,d0				-> Nombre de secteurs
 move.l secteurs_par_cluster,d1
 divu.l d1,d0				-> Nombre de clusters
 cmp.l clusters_libres,d0
 ble.s .m�moire_suffisante
.m�moire_insuffisante 
 boite_alerte #1,#alert_disk_plein
 moveq #1,d0 
 rts

.m�moire_suffisante 
 moveq #0,d0 
 rts

 
teste_existance_fichier 
 clr -(sp)			Fichier normal
 pea nom_fichier		Nom du fichier
 move #$4e,-(sp)		> FSFIRST
 trap #1
 addq #8,sp
 tst d0
 beq.s .continue_analyse
 moveq #-1,d0
 rts
 
.continue_analyse
 lea my_dta+30,a0		On stocke l'extension du fichier pour 
.cherche_fin_chemin
 cmp.b #".",(a0)+		v�rifier si le format est connu.	
 bne .cherche_fin_chemin
 move.l -1(a0),extension	M�morise l'extension du fichier

 move.l my_dta+26,taille_fichier	C'est utile pour la suite
 moveq #0,d0
 rts
 
charge_fichier 
 move #1,-(sp)			Ouvre en lecture
 pea nom_fichier		Nom du fichier
 move #$3d,-(sp)		> FOPEN
 trap #1
 addq #8,sp
 tst d0
 bmi erreur_ouverture_impossible
 move d0,handle

 move.l buffer_fichier,-(sp)		Adresse du buffer
 move.l taille_fichier,-(sp)		Longueur du fichier
 move handle,-(sp)
 move #$3f,-(sp)		> FREAD
 trap #1
 lea 12(sp),sp
 tst.l d0
 bmi erreur_durant_lecture

 move handle,-(sp)		On ferme le fichier
 move #$3e,-(sp)		> FCLOSE
 trap #1
 addq #4,sp
 tst d0
 bmi erreur_fermeture_impossible

 moveq #0,d0			Pas d'erreur. Fichier charg� !
 rts


sauve_fichier 
 clr -(sp)			Ouvre en �criture
 pea nom_fichier		Nom du fichier
 move #$3c,-(sp)		> FCREATE
 trap #1
 addq #8,sp
 tst d0
 bmi erreur_ouverture_impossible
 move d0,handle

 move.l buffer_fichier,-(sp)	Adresse du buffer
 move.l taille_fichier,-(sp)	Longueur du fichier
 move handle,-(sp)
 move #$40,-(sp)		> WRITE
 trap #1
 lea 12(sp),sp
 tst.l d0
 bmi erreur_durant_lecture

 move handle,-(sp)		On ferme le fichier
 move #$3e,-(sp)		> FCLOSE
 trap #1
 addq #4,sp
 tst d0
 bmi erreur_fermeture_impossible

 moveq #0,d0			Pas d'erreur. Fichier charg� !
 rts


sauve_dta_syst�me
 move #$2f,-(sp)
 trap #1
 addq #2,sp
 move.l d0,sauve_dta

 pea my_dta
 move #$1a,-(sp)
 trap #1
 addq #6,sp
 rts

restore_dta_syst�me
 move.l sauve_dta,-(sp)
 move #$1a,-(sp)
 trap #1
 addq #6,sp
 rts


erreur_m�moire_chargement
 boite_alerte #1,#alert_m�moire_chargement	Pr�vient l'utilisateur
 moveq #-1,d0					Code d'erreur
 rts

erreur_m�moire_sauvegarde
 boite_alerte #1,#alert_m�moire_sauvegarde	Pr�vient l'utilisateur
 moveq #-1,d0					Code d'erreur
 rts

erreur_fichier_absent
 boite_alerte #1,#alert_fichier_non_trouve
 moveq #-1,d0
 rts

erreur_ouverture_impossible
 boite_alerte #1,#alert_ouverture_impossible
 moveq #-1,d0
 rts

erreur_durant_�criture
erreur_durant_lecture
 boite_alerte #1,#alert_durant_lecture
 moveq #-1,d0
 rts

erreur_fermeture_impossible 
 boite_alerte #1,#alert_fermeture_impossible
 moveq #-1,d0
 rts

erreur_m�moire_d�packing
 boite_alerte #1,#alert_m�moire_d�packing
 moveq #-1,d0
 rts
 
erreur_format_chargement
 boite_alerte #1,#alert_format_chargement
 moveq #-1,d0
 rts


*****************************
*
* Le s�lecteur de driver d'image
*
*****************************

gere_chargement_s�lection
 move.l ptr_choix_driver,adresse_formulaire
 clr premier_objet
 
 bsr mise_�_jour_s�lecteur
  
 bsr.l affiche_formulaire

.boucle_g�re_formulaire
 bsr.l gere_formulaire

 cmp #objet_confirme_rim,objet_exit -> On � appuy� sur la touche CONFIRMER
 beq .boucle_g�re_formulaire		.confirme_choix_driver
 cmp #objet_annuler_rim,objet_exit
 beq .quitte_formulaire

 cmp #objet_rim_monte,objet_exit
 bne.s .pas_fl�che_haut
 tst.b flag_scroll_haut
 beq.s .boucle_g�re_formulaire
 subq #1,position_s�lection_rim
 bra.s .fin_g�re_fl�ches
.pas_fl�che_haut

 cmp #objet_rim_descend,objet_exit
 bne.s .s�lection_driver		*pas_fl�che_bas
 tst.b flag_scroll_bas
 beq.s .boucle_g�re_formulaire
 addq #1,position_s�lection_rim
.pas_fl�che_bas

.fin_g�re_fl�ches
 bsr mise_�_jour_s�lecteur
 bsr r�affiche_liste_drivers
 bra .boucle_g�re_formulaire


.quitte_formulaire
 bsr.l ferme_formulaire
 moveq #-1,d0
 rts

.s�lection_driver
 move position_s�lection_rim,d0
 add objet_exit,d0
 sub #objet_titre_rim_1,d0		Num�ro de la ligne choisie
 move d0,num�ro_driver_courant
 lea liste_drivers_internes,a0
 mulu #40,d0
 add d0,a0
 move.l 32(a0),adresse_routine_chargement

 move.l #txt_chargement_par_type,adresse_txt_chargement

 move.l 36(a0),a0			Chaine de caract�res correspondant
 move.l ptr_chargement_image,a1
 move.l a0,([ob_spec+objet_chargement_form*24,a1])
 
 lea txt_type_choisi,a1		Message du fileselect
.recopie_texte
 move.b (a0)+,(a1)+
 bne.s .recopie_texte

 bsr.l ferme_formulaire
 moveq #0,d0
 rts
  

r�affiche_liste_drivers
 objc_draw ptr_choix_driver,#objet_rim_monte,#0,x_form,y_form,l_form,h_form
 lea liste_titres_rim,a2
 moveq #14-1,d7			; 9-1
.�crit_ligne_suivante
 move (a2)+,d6
 move d7,-(sp)
 pea (a2)
 objc_draw ptr_choix_driver,d6,#0,x_form,y_form,l_form,h_form
 move.l (sp)+,a2
 move (sp)+,d7
 dbra d7,.�crit_ligne_suivante
 objc_draw ptr_choix_driver,#objet_rim_descend,#0,x_form,y_form,l_form,h_form
 rts


 
mise_�_jour_s�lecteur
 tst position_s�lection_rim
 sne flag_scroll_haut

 move nombre_drivers,d6
 sub position_s�lection_rim,d6
 sub #14+1,d6
 spl flag_scroll_bas

* move.l adresse_drivers_rim,a0
 move position_s�lection_rim,d5
; mulu #50,d0
; add d0,a0

 move.l ptr_choix_driver,a1			Pointeur sur le formulaire

 move.l #ligne_quedal,([ob_spec+objet_rim_monte*24,a1])
 tst.b flag_scroll_haut
 beq.s .pas_scroll_haut
 move.l #ligne_monte,([ob_spec+objet_rim_monte*24,a1])
.pas_scroll_haut

 move nombre_drivers,d6
 moveq #14,d7
 cmp d7,d6
 bpl.s .ok_nombre_rim
 move d6,d7
.ok_nombre_rim
 subq #1,d7
 lea liste_titres_rim,a2
.�crit_ligne_suivante
 move (a2)+,d0					Num�ro de l'objet
 mulu #24,d0
 
 lea liste_drivers_internes,a0
 move d5,d4
 mulu #40,d4
 add d4,a0
 move.l a0,([ob_spec,a1,d0.w])			Adresse du texte RIM

 addq #1,d5					Driver suivant
 dbra d7,.�crit_ligne_suivante

 move.l #ligne_quedal,([ob_spec+objet_rim_descend*24,a1])
 tst.b flag_scroll_bas
 beq.s .pas_scroll_bas
 move.l #ligne_descend,([ob_spec+objet_rim_descend*24,a1])
.pas_scroll_bas
 rts

  

*****************************

 include FICHIERS.INC\DISQUE\_MACROS.S

;
; Les diff�rents drivers internes pour le chargement et la sauvegarde.
;
 include FICHIERS.INC\DISQUE\ART.S
 include FICHIERS.INC\DISQUE\BMP.S
 include FICHIERS.INC\DISQUE\CRACKART.S
 include FICHIERS.INC\DISQUE\DEGAS.S
 include FICHIERS.INC\DISQUE\DELUXE.S
 include FICHIERS.INC\DISQUE\FULLSHOW.S
 include FICHIERS.INC\DISQUE\GIF.S
 include FICHIERS.INC\DISQUE\INSHAPE.S
 include FICHIERS.INC\DISQUE\JPEG.S
 include FICHIERS.INC\DISQUE\NEO.S
 include FICHIERS.INC\DISQUE\PRISM.S
 include FICHIERS.INC\DISQUE\PCX.S
 include FICHIERS.INC\DISQUE\SPECTRUM.S
 include FICHIERS.INC\DISQUE\TCP.S
 include FICHIERS.INC\DISQUE\TGA.S
 include FICHIERS.INC\DISQUE\TG1.S
 include FICHIERS.INC\DISQUE\XGA.S


 DATA

 even
 	
*
* .L - Extension g�n�rale affect�e.
* .L - Adresse de la routine de chargement par type
* .L - Adresse de la routine de chargement par extension
* .L - Adresse du chaine de caract�res donnant le nom en ASCII
*
liste_formats_automatique
 dc.b ".PI1"
 dc.l charge_image_degas
 dc.l txt_format_degas

 dc.b ".PC1"
 dc.l charge_image_degas_pack�e
 dc.l txt_format_degas

 dc.b ".IIM"
 dc.l charge_image_inshape
 dc.l txt_format_inshape
 
 dc.b ".IFF"
 dc.l charge_image_iff
 dc.l txt_format_iff

 dc.b ".LBM"
 dc.l charge_image_iff
 dc.l txt_format_iff

 dc.b ".NEO"
 dc.l charge_image_neo
 dc.l txt_format_neochrome

 dc.b ".SPU"
 dc.l charge_image_spectrum_normale
 dc.l txt_format_spectrum

 dc.b ".SPC"
 dc.l charge_image_spectrum_compress�e
 dc.l txt_format_spectrum

 dc.b ".CA1"
 dc.l charge_image_crackart
 dc.l txt_format_crackart

 dc.b ".SD0"
 dc.l charge_image_dali
 dc.l txt_format_dali

 dc.b ".TGA"
 dc.l charge_image_tga
 dc.l txt_format_tga

 dc.b ".KID"
 dc.l charge_image_kid
 dc.l txt_format_fullshow

 dc.b ".GIF"
 dc.l charge_image_gif
 dc.l txt_format_gif

 dc.b ".JPG"
 dc.l charge_image_jpeg
 dc.l txt_format_jpeg

 dc.b ".BMP"
 dc.l charge_image_windows
 dc.l txt_format_windows
  
 dc.b ".TCP"
 dc.l charge_image_tcp
 dc.l txt_format_tcp

 dc.b ".XGA"
 dc.l charge_image_xga
 dc.l txt_format_xga

 dc.b ".TG1"
 dc.l charge_image_coke
 dc.l txt_format_coke

 dc.b ".ART"
 dc.l charge_image_art_director
 dc.l txt_format_art

 dc.b ".PNT"
 dc.l charge_image_prism_paint
 dc.l txt_format_pnt

 dc.b ".PCX"
 dc.l charge_image_pcx
 dc.l txt_format_pcx
  
 dc.b ".TPI"
 dc.l charge_image_true_paint
 dc.l txt_format_tpi
 
 dc.l -1				Plus d'autre fichiers


liste_formats_sauvegarde
 dc.b ".TGA"
 dc.w objet_sauve_tga_16bit
 dc.l sauve_image_tga_16bit	TGA
 dc.l txt_format_tga_16bit
 dc.b ".TGA"
 dc.w objet_sauve_tga_24bit
 dc.l sauve_image_tga_24bit	TGA
 dc.l txt_format_tga_24bit
 dc.b ".TCP"
 dc.w objet_sauve_tcp
 dc.l sauve_image_tcp		TCP
 dc.l txt_format_tcp
 dc.b ".TG1"
 dc.w objet_sauve_coke
 dc.l sauve_image_coke		TG1
 dc.l txt_format_coke

  
txt_chargement_par_nom	dc.b "CHARGER SELON L'EXTENSION",0
txt_chargement_par_type	dc.b "CHARGER UNE IMAGE "
txt_type_choisi		dc.b ".........................",0
txt_sauvegarde_image	dc.b "SAUVER UNE IMAGE "
txt_sauvegarde_choisie	dc.b ".........................",0
 
txt_format_art		dc.b "ART DIRECTOR",0
txt_format_crackart	dc.b "CRACK ART",0
txt_format_dali		dc.b "DALI",0
txt_format_degas	dc.b "DEGAS",0
txt_format_iff		dc.b "DELUXE PAINT",0
txt_format_fullshow	dc.b "FULLSHOW",0
txt_format_gif		dc.b "GIF",0
txt_format_inshape	dc.b "INSHAPE",0
txt_format_jpeg		dc.b "JPEG",0
txt_format_pcx		dc.b "PAINT BRUSH",0
txt_format_pnt		dc.b "PRISM PAINT",0
txt_format_neochrome	dc.b "NEOCHROME",0
txt_format_tcp		dc.b "REMBRANDT",0
txt_format_spectrum	dc.b "SPECTRUM",0
txt_format_tga		dc.b "TGA",0
txt_format_tga_16bit	dc.b "TGA 16bits",0
txt_format_tga_24bit	dc.b "TGA 24bits",0
txt_format_coke		dc.b "TRUE COLOR",0
txt_format_tpi		dc.b "TRUE PAINT",0
txt_format_windows	dc.b "WINDOWS BMP",0
txt_format_xga		dc.b "XGA",0

txt_format_rim		dc.b "DRIVER RIM",0

txt_charge_image	dc.b "CHARGEMENT DE:",0
txt_d�packe_image	dc.b "D�COMPACTAGE DE:",0
txt_convertie_image	dc.b "CONVERTION DE:",0
txt_sauve_image		dc.b "SAUVEGARDE DE:",0

nom_image		dc.b "SANS_NOM",0
			dcb.b 20,0		Par suret�...

nom_fichier		dc.b "SANS_NOM",0
			dcb.b 20,0		Par suret�...


liste_titres_rim
 dc objet_titre_rim_1
 dc objet_titre_rim_2
 dc objet_titre_rim_3
 dc objet_titre_rim_4
 dc objet_titre_rim_5
 dc objet_titre_rim_6
 dc objet_titre_rim_7
 dc objet_titre_rim_8
 dc objet_titre_rim_9
 dc objet_titre_rim_10
 dc objet_titre_rim_11
 dc objet_titre_rim_12
 dc objet_titre_rim_13
 dc objet_titre_rim_14


ligne_quedal
 dc.b '',0,0
 
ligne_monte
 dc.b '    ',0,0

ligne_descend
 dc.b '    ',0,0

*
* Les Formats internes � Rembrandt...
*
*dc.b "123456789012345678901234567890"
nombre_drivers_internes dc.w 18

liste_drivers_internes
 dc.b "Art Director             [ART]",0,0
 dc.l charge_image_art_director
 dc.l txt_format_art

 dc.b "Coke TRUE COLOR          [TG1]",0,0
 dc.l charge_image_coke
 dc.l txt_format_coke

 dc.b "CompuServ                [GIF]",0,0
 dc.l charge_image_gif
 dc.l txt_format_gif

 dc.b "Crack Art                [CA1]",0,0
 dc.l charge_image_crackart
 dc.l txt_format_crackart

 dc.b "Dali                     [SD0]",0,0
 dc.l charge_image_dali
 dc.l txt_format_dali

 dc.b "Degas/Degas Elite    [PI1/PC1]",0,0
 dc.l teste_image_degas
 dc.l txt_format_degas

 dc.b "Deluxe Paint         [IFF/LBM]",0,0
 dc.l charge_image_iff
 dc.l txt_format_iff

 dc.b "Fullshow                 [KID]",0,0
 dc.l charge_image_kid
 dc.l txt_format_fullshow

 dc.b "InShape                  [IIM]",0,0
 dc.l charge_image_inshape
 dc.l txt_format_inshape

 dc.b "JPEG                     [JPG]",0,0
 dc.l charge_image_jpeg
 dc.l txt_format_jpeg

 dc.b "NeoChrome                [NEO]",0,0
 dc.l charge_image_neo
 dc.l txt_format_neochrome

 dc.b "PC PaintBrush            [PCX]",0,0
 dc.l charge_image_pcx
 dc.l txt_format_pcx
  
 dc.b "Prism Paint              [PNT]",0,0
 dc.l charge_image_prism_paint
 dc.l txt_format_pnt

 dc.b "Rembrandt                [TCP]",0,0
 dc.l charge_image_tcp
 dc.l txt_format_tcp

 dc.b "Spectrum 512         [SPC/SPU]",0,0
 dc.l teste_image_spectrum
 dc.l txt_format_spectrum

 dc.b "TGA                      [TGA]",0,0
 dc.l charge_image_tga
 dc.l txt_format_tga

 dc.b "True Paint               [TPI]",0,0
 dc.l charge_image_true_paint
 dc.l txt_format_tpi

 dc.b "Windows Bitmap           [BMP]",0,0
 dc.l charge_image_windows
 dc.l txt_format_windows

 dc.b "XGA                      [XGA]",0,0
 dc.l charge_image_xga
 dc.l txt_format_xga
 
	BSS

 even

flag_scroll_haut	ds.w 1
flag_scroll_bas		ds.w 1

repertoire			ds.b taille_chemin
chemin_param�trage		ds.b taille_chemin
chemin_fichier			ds.b taille_chemin

my_dta				ds.b 44	DTA de Rembrandt, utilis�e par FsFirst/Next
tampon_dta			ds.l 1	Adresse de la nouvelle DTA allou�e par Rembrandt
sauve_dta			ds.l 1	Adresse de la DTA syst�me
extension			ds.l 1	Ex: �.GIF�

disk_infos
clusters_libres			ds.l 1
total_clusters			ds.l 1
taille_secteur			ds.l 1
secteurs_par_cluster		ds.l 1

nombre_couleurs			ds.w 1
nombre_plans			ds.w 1
nombre_lignes			ds.w 1
nombre_colonnes			ds.w 1
largeur_plan			ds.w 1	Pour le PackBit/Pour la MFDB (Rim)
largeur_ligne			ds.w 1

format_d�faut_chargement	ds.w 1
format_d�faut_sauvegarde	ds.w 1

adresse_routine_chargement	ds.l 1
adresse_routine_sauvegarde	ds.l 1
adresse_txt_chargement		ds.l 1

adresse_image			ds.l 1
taille_fichier			ds.l 1

buffer_fichier			ds.l 1
buffer_d�packing		ds.l 1

flag_packed			ds.w 1
buffer_ligne			ds.l 1000	Pour le d�packing IFF/PC1/PNT
allocation_palettes		
adresse_palette			ds.l 1		Par d�faut, c'est une palette !!!
				ds.l 1000	Pour la conversion ST  True Color av� l� rasters !
fin_allocation_palettes
