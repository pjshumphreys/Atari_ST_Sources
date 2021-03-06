(*
   Die folgende Prozedur dient dazu, den P�tsch-Bereich von M2-Programmen zu
   erweitern, die mit dem originalen TDI-Linker gelinkt werden. Nat�rlich
   sind die neuen Informationen (StaticHeapSize, SpecialFlags, Version) nur
   n�tzlich, wenn die Library sie verarbeiten kann... Die Erweiterung erfolgt
   im Anschlu� an StackSize, also ab Position 12 hinter dem ProgramHeader.
   Die Methode funktioniert NICHT mit dem MS-XLinker! In seinem Fall kann man
   aber HeapSize & Flags noch nutzen, indem man den Jump 4EF9H an Position
   1CH durch ein Branch 600EH ersetzt und die drei NOPse 4E71H �berschreibt.
*)

PROCEDURE PatxArea;    (* Mu� vor allen anderen Prozeduren in GEMX stehen! *)
 (* Aufrufen, damit sie nicht wegoptimiert wird! (Z.B. hinterm Terminator).*)
 CONST HIHEAP = 0; M2FLAX = 0; HIMAG = 4D32H(*="M2"*);
       LOHEAP = 0; M2VERS = 0; LOMAG = 5058H(*="PX"*);                (*$P-*)
 BEGIN CODE (HIHEAP,LOHEAP, M2FLAX,M2VERS, HIMAG,LOMAG) END PatxArea; (*$P+*)
