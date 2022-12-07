        IDENTIFICATION Division.
            PROGRAM-ID.     Aoc2022Day7Part2.
            AUTHOR          "GDWR"
            DATE-WRITTEN    "07-12-22"

        ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.

            SELECT DATA-FILE ASSIGN TO "./data"
                ORGANIZATION IS LINE SEQUENTIAL.

        DATA DIVISION.
        FILE SECTION.
        FD DATA-FILE.
        01 IN-RECORD.
            02 OPPONENT-CHOICE PIC X(1).
            02 SPACER          PIC X(1).
            02 MY-CHOICE       PIC X(1).

        WORKING-STORAGE SECTION.
        01 END-OF-FILE  PIC Z(1).
        01 COUNTER      PIC 9(4) VALUE 0.
        01 SCORE        PIC 9(10) VALUE 0.

        PROCEDURE DIVISION.
        BEGIN.
            OPEN INPUT DATA-FILE.

            PERFORM UNTIL END-OF-FILE = 1
                READ DATA-FILE
                    AT END MOVE 1 TO END-OF-FILE
                    NOT AT END
                        COMPUTE COUNTER = COUNTER + 1

                        EVALUATE OPPONENT-CHOICE
                            WHEN "A"
                                EVALUATE MY-CHOICE
                                    WHEN "X"
                                        COMPUTE SCORE = SCORE + 3 + 0
                                    WHEN "Y"
                                        COMPUTE SCORE = SCORE + 1 + 3
                                    WHEN "Z"
                                        COMPUTE SCORE = SCORE + 2 + 6
                                    WHEN OTHER
                                        DISPLAY "Invalid"
                            WHEN "B"
                                EVALUATE MY-CHOICE
                                    WHEN "X"
                                        COMPUTE SCORE = SCORE + 1 + 0
                                    WHEN "Y"
                                        COMPUTE SCORE = SCORE + 2 + 3
                                    WHEN "Z"
                                        COMPUTE SCORE = SCORE + 3 + 6
                                    WHEN OTHER
                                        DISPLAY "Invalid"
                            WHEN "C"
                                EVALUATE MY-CHOICE
                                    WHEN "X"
                                        COMPUTE SCORE = SCORE + 2 + 0
                                    WHEN "Y"
                                        COMPUTE SCORE = SCORE + 3 + 3
                                    WHEN "Z"
                                        COMPUTE SCORE = SCORE + 1 + 6
                                    WHEN OTHER
                                        DISPLAY "Invalid"
                            WHEN OTHER
                                DISPLAY "Invalid"
                END-READ
          END-PERFORM

          DISPLAY "Score >>> " SCORE
          DISPLAY "Lines >>> " COUNTER

          CLOSE DATA-FILE
       STOP RUN.
