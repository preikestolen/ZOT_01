*&---------------------------------------------------------------------*
*& Report zot_01_p_hw3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_hw3.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p1_first(5) TYPE n OBLIGATORY,
              p2_secon(5) TYPE n OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

DATA:  lv_prime TYPE i.

START-OF-SELECTION.

  IF p1_first <= p2_secon.
    lv_prime = p1_first.
    DO p2_secon - p1_first TIMES.
      DATA(num) = 2.
      DATA(check) = 0.
      WHILE num < lv_prime.
        IF lv_prime MOD num = 0.
          check = 1.
          EXIT.
        ENDIF.
        num = num + 1.
      ENDWHILE.
      IF check = 0.
        WRITE: / lv_prime.
      ENDIF.
      lv_prime = lv_prime + 1.
    ENDDO.
  ELSE.
    WRITE: / 'error'.
  ENDIF.
