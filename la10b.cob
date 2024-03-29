       IDENTIFICATION DIVISION.
       PROGRAM-ID. LA10B.
      *
      *    Resultaten per provincie, Cursus Cobol 85, pag. 78
      *
      *    To compile, type make, or use
      *
      *    cobc -x -Wall la10b.cob abend.cob -T la10b.lst -Xref
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           CONSOLE IS TERM.
       REPOSITORY.
           FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       77  K                                      PIC 9.
       77  L                                      PIC 9.
       77  M                                      PIC 9.
       77  N                                      PIC 99.
       77  SOM                                    PIC 99.
       77  GEM                                    PIC 99v9.
       77  KOP                                    PIC X(47) VALUE
           "  RESULTAAT GR FR DR YM OV GE UT NH ZH ZL NB LB".
       01  INVOER.
           02  PROV                               PIC 99.
           02  CIJFER                             PIC 99 OCCURS 6.
       01  UITVOER.
           02  TEKST-U                            PIC X(11).
           02  RUBRIEK                            OCCURS 12.
               03                                 PIC X.
               03  AANTAL-U                       PIC 99.
       01  TEKST-TABEL                            VALUE
           "GOED       VOLDOENDE  ONVOLDOENDESLECHT".
           02  TEKST-T                            PIC X(11) OCCURS 4.
       01  AANTAL-TABEL.
           02  RESULTAAT                          OCCURS 4.
               03  AANTAL-T                       PIC 99 OCCURS 12.
       PROCEDURE DIVISION.
       0000-MAIN.
           PERFORM INITIALISERING.
           PERFORM VERWERKING UNTIL PROV = 99.
           PERFORM AFDRUKKEN.
       9999-EXIT.
           STOP RUN.
       INITIALISERING.
           MOVE ZEROES TO AANTAL-TABEL.
           DISPLAY "TYP GEGEVENS" UPON TERM.
           ACCEPT INVOER FROM TERM.
       VERWERKING.
           MOVE ZEROES TO SOM.
           PERFORM WITH TEST BEFORE
               VARYING K FROM 1
                         BY 1
                         UNTIL K > 6
               ADD CIJFER(K) TO SOM
           END-PERFORM.
           DIVIDE 6 INTO SOM GIVING GEM.
           IF GEM >= 7.5 MOVE 1 TO L
           ELSE IF GEM >= 5.5 MOVE 2 TO L
                ELSE IF GEM >= 3 MOVE 3 TO L
                     ELSE MOVE 4 TO L
                     END-IF
                END-IF
           END-IF.
           ADD 1 TO AANTAL-T(L, PROV).
           DISPLAY "TYP GEGEVENS" UPON TERM.
           ACCEPT INVOER FROM TERM.
       AFDRUKKEN.
           DISPLAY KOP UPON TERM.
           DISPLAY SPACE UPON TERM.
           MOVE SPACES TO UITVOER.
           PERFORM WITH TEST BEFORE
               VARYING M FROM 1
                         BY 1
                         UNTIL M > 4
               MOVE TEKST-T(M) TO TEKST-U
               PERFORM WITH TEST BEFORE
                   VARYING N FROM 1
                             BY 1
                             UNTIL N > 12
                   MOVE AANTAL-T(M, N) TO AANTAL-U(N)
               END-PERFORM
               DISPLAY UITVOER UPON TERM
           END-PERFORM.
