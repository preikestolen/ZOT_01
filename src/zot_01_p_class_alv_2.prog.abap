*&---------------------------------------------------------------------*
*& Report zot_01_p_class_alv_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_class_alv_2.

DATA: go_grid      TYPE REF TO cl_gui_alv_grid,
      go_container TYPE REF TO cl_gui_custom_container.

DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat.

TYPES: BEGIN OF lty_itab,
         matnr TYPE matnr,
       END OF lty_itab.

DATA: lt_itab TYPE TABLE OF lty_itab.

INCLUDE zot_00_p_class_alv_2_pbo.

START-OF-SELECTION.



  SELECT
    FROM mara
    FIELDS matnr
      INTO TABLE @lt_itab
    UP TO 100 ROWS.

  IF sy-subrc EQ 0.
    CALL SCREEN 100.
  ELSE.
    MESSAGE 'Kayıt yok' TYPE 'E'.
  ENDIF.

INCLUDE zot_01_p_class_alv_2_pai.
