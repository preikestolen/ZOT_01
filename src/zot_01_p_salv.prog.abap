*&---------------------------------------------------------------------*
*& Report zot_01_p_salv
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_salv.

DATA: go_alv    TYPE REF TO cl_salv_table,
      gv_ucomm  TYPE sy-ucomm,
      gv_okcode TYPE sy-ucomm.


START-OF-SELECTION.

  SELECT
    FROM mara
    FIELDS *
      INTO TABLE @DATA(lt_itab)
    UP TO 100 ROWS.

  cl_salv_table=>factory(
    EXPORTING
      list_display = ''
    IMPORTING
      r_salv_table = go_alv
    CHANGING
      t_table      = lt_itab ).

  go_alv->display( ).
