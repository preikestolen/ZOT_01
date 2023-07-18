*&---------------------------------------------------------------------*
*& Include zot_01_i_report_hw_sel
*&---------------------------------------------------------------------*

TABLES: eban, ekpo.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS s_sat_no FOR eban-banfn.
  PARAMETERS: p_sat_tu TYPE eban-bsart.
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  SELECT-OPTIONS s_sas_no FOR ekpo-ebeln.
  PARAMETERS: p_sas_tu TYPE ekpo-matkl.
SELECTION-SCREEN END OF BLOCK b2.


SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
    PARAMETERS: r_sat RADIOBUTTON GROUP gr1,
                r_sas RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK b3.
