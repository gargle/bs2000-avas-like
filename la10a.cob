       IDENTIFICATION DIVISION.
       PROGRAM-ID. LA10A.
      *
      *    A program to ask for a name, say hello world, and show the contents
      *    of a file.
      *
      *    To compile, type make, or use
      *
      *    cobc -x -Wall la10a.cob abend.cob -T la10a.lst -Xref
      *
      *    To show a file in hexadecimal, use
      *
      *    od -A x -t x1z -v la10a.fil
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           CONSOLE IS TERM.
       REPOSITORY.
           FUNCTION ALL INTRINSIC.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *    export DD_FILE_IN=./la10a.fil
           SELECT FILE_IN ASSIGN TO "DD_FILE_IN"
           ORGANIZATION IS LINE SEQUENTIAL
           FILE STATUS IS FILE_IN-STATUS.
       DATA DIVISION.
       FILE SECTION.
       FD  FILE_IN
           RECORD IS VARYING IN SIZE
           FROM 0 TO 32768 DEPENDING ON FILE_IN-SIZE.
       01  FILE_IN-RECORD.
           02  PIC X OCCURS 0 TO 32768 DEPENDING ON FILE_IN-SIZE.
       WORKING-STORAGE SECTION.
       01  FILE_IN-STATUS                         PIC XX.
           88  FILE_IN-OK                         VALUE "00".
           88  FILE_IN-EOF                        VALUE "10".
       01  FILE_IN-SIZE                           PIC 9(5).
       77  WS-NAME                                PIC X(64).
       PROCEDURE DIVISION.
       0000-MAIN.
           DISPLAY "WHAT'S YOUR NAME ?" UPON TERM.
           ACCEPT WS-NAME FROM TERM.
           IF WS-NAME = SPACES THEN
               DISPLAY "NO NAME GIVEN" UPON STDERR
               CALL "ABEND".
           DISPLAY "HELLO WORLD, " TRIM(WS-NAME) "!" UPON TERM.
       0010-FILE_IN.
           OPEN INPUT FILE_IN.
       0020-FILE_IN-READ.
           READ FILE_IN
               AT END GO TO 0030-FILE_IN-EOF.
           IF FILE_IN-OK THEN
               DISPLAY FILE_IN-RECORD UPON TERM
           ELSE
               DISPLAY "SOME ERROR OCCURED : " FILE_IN-STATUS
                   UPON STDERR
               CALL "ABEND".
           GO TO 0020-FILE_IN-READ.
       0030-FILE_IN-EOF.
           CLOSE FILE_IN.
       9999-EXIT.
           STOP RUN.
