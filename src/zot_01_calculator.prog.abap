*&---------------------------------------------------------------------*
*& Report zot_01_calculator
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_calculator.

TABLES sscrfields.
DATA: lv_res      TYPE decfloat16,
      lv_res_char TYPE char10.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_value1 TYPE decfloat16 OBLIGATORY,
              p_value2 TYPE decfloat16 OBLIGATORY,
              p_add    RADIOBUTTON GROUP g1,
              p_sub    RADIOBUTTON GROUP g1,
              p_mul    RADIOBUTTON GROUP g1,
              p_div    RADIOBUTTON GROUP g1.
  SELECTION-SCREEN PUSHBUTTON 40(10) but_cal USER-COMMAND cli1.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT (30) res_text MODIF ID cr.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b1.

AT SELECTION-SCREEN.
  CASE sscrfields.
    WHEN 'CLI1'.
      PERFORM calculation USING p_value1
                                p_value2.
      LOOP AT SCREEN.
        IF screen-group1 = 'CR'.
          lv_res_char = lv_res.
          CONCATENATE 'Your result is ' lv_res_char
                INTO res_text
                RESPECTING BLANKS.
        ENDIF.
        "MODIFY SCREEN.
      ENDLOOP.
  ENDCASE.

INITIALIZATION.
  but_cal = 'Calculate!'.

FORM calculation USING par1 TYPE decfloat16
                       par2 TYPE decfloat16.

  IF p_add = 'X'.
    lv_res = par1 + par2.
  ELSEIF p_sub = 'X'.
    lv_res = par1 - par2.
  ELSEIF p_mul = 'X'.
    lv_res = par1 * par2.
  ELSEIF p_div = 'X'.
    TRY.
        lv_res = par1 / par2.
      CATCH cx_sy_zerodivide.
        cl_demo_output=>write( 'Zero division error' ).
        cl_demo_output=>display( ).
    ENDTRY.
  ENDIF.
ENDFORM.
