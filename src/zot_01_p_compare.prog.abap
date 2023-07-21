*&---------------------------------------------------------------------*
*& Report zot_01_p_compare
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_compare.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_text1(5) TYPE c OBLIGATORY,
              p_text2(5) TYPE c OBLIGATORY,
              p_text3(5) TYPE c OBLIGATORY,
              p_text4(5) TYPE c OBLIGATORY,
              p_text5(5) TYPE c OBLIGATORY.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  TYPES: BEGIN OF gty_word,
           text TYPE c LENGTH 5,
         END OF gty_word.

  DATA ls_word TYPE gty_word.
  DATA ls_word_2 TYPE gty_word.
  DATA lt_words TYPE TABLE OF gty_word.
  DATA lt_contains TYPE TABLE OF gty_word.

  ls_word-text = p_text1.
  APPEND ls_word TO lt_words.
  CLEAR ls_word.

  ls_word-text = p_text2.
  APPEND ls_word TO lt_words.
  CLEAR ls_word.

  ls_word-text = p_text3.
  APPEND ls_word TO lt_words.
  CLEAR ls_word.

  ls_word-text = p_text4.
  APPEND ls_word TO lt_words.
  CLEAR ls_word.

  ls_word-text = p_text5.
  APPEND ls_word TO lt_words.
  CLEAR ls_word.

  LOOP AT lt_words INTO ls_word.
    DATA(index_1) = sy-tabix.
    LOOP AT lt_words INTO ls_word_2.
      DATA(index_2) = sy-tabix.
      IF ls_word-text CO ls_word_2-text AND index_1 LT index_2.
        WRITE: ls_word, ' - ', ls_word_2, /.
        INSERT ls_word INTO TABLE lt_contains.
        INSERT ls_word_2 INTO TABLE lt_contains.
      ENDIF.
    ENDLOOP.
  ENDLOOP.

* compare two it and give the non existing one in two tables at the same time.
  LOOP AT lt_words INTO ls_word.
    READ TABLE lt_contains INTO ls_word_2 WITH KEY text = ls_word-text.
    IF sy-subrc NE 0.
      WRITE: / , ls_word-text.
    ENDIF.
  ENDLOOP.
