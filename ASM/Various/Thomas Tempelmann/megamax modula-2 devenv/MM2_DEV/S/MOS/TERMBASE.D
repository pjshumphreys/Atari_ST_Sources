DEFINITION MODULE TermBase;

(* Grundmodul f�r 'Terminal'.
 *
 * Enth�lt Treibervariablen f�r die Ein- und Ausgabe von Zeichen �ber
 * die Funktionen aus 'Terminal'.
 * Ein Grundtreiber ist bereits in dem Codeteil dieses Moduls enthalten
 * und wird standardm��ig verwendet.
 *)


FROM SYSTEM IMPORT LONGWORD;

TYPE  BoolProc = PROCEDURE (): BOOLEAN;
      WriteProc= PROCEDURE (REF ARRAY OF CHAR);
      CardProc = PROCEDURE (): CARDINAL;
      LWProc   = PROCEDURE (): LONGWORD;

VAR   DoGetGSX : LWProc;    (* kein Echo! *)
      DoBusy   : BoolProc;
      DoWrite  : WriteProc;
      DoWriteCt: WriteProc;
      DoGetRows: CardProc;
      DoGetCols: CardProc;

PROCEDURE InitDisplay;
PROCEDURE InitKeyboard;

END TermBase.
