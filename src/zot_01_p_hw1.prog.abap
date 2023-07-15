*&---------------------------------------------------------------------*
*& Report zot_01_p_hw1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_hw1.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p1_max(3) TYPE n OBLIGATORY,
              p2_kir(1) TYPE n OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

DATA(lv_count) = 1.

START-OF-SELECTION.
  DO p1_max TIMES.
    IF p2_kir = 0.
        EXIT.
    ENDIF.
    IF lv_count MOD p2_kir = 1 .
      WRITE: / lv_count.
    ELSE.
      WRITE: lv_count.
    ENDIF.
    lv_count = lv_count + 1.
  ENDDO.
