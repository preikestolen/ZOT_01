*&---------------------------------------------------------------------*
*& Report zot_01_p_hw2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_hw2.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p1_max(5) TYPE n OBLIGATORY,
              p2_kir(1) TYPE n OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

DATA: lv_count      TYPE int4,
      lv_new_count  TYPE int4,
      lv_next_count TYPE int4.
DATA(gv_count) = 1.
DATA lv_newline TYPE i.

START-OF-SELECTION.
  lv_count = 0.
  lv_new_count = 1.
  lv_next_count = 1.
  WHILE lv_next_count < p1_max.
    IF gv_count MOD p2_kir = 1 .
      WRITE: / lv_next_count.
    ELSE.
      WRITE: lv_next_count.
    ENDIF.
    lv_count = lv_new_count.
    lv_new_count = lv_next_count.
    lv_next_count = lv_count + lv_new_count.
    gv_count = gv_count + 1.
  ENDWHILE.
