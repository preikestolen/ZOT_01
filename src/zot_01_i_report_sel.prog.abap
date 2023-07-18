*&---------------------------------------------------------------------*
*& Include zot_01_i_report_sel
*&---------------------------------------------------------------------*

TABLES: ekko, ekpo, likp.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_matnr FOR ekpo-matnr,
                  s_matkl FOR ekpo-matkl.
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  PARAMETERS: p_alv  TYPE char1 RADIOBUTTON GROUP gr1,
              p_salv TYPE char1 RADIOBUTTON GROUP gr1,
              p_grid TYPE char1 RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK b2.


SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_bukrs TYPE bukrs." NO-DISPLAY.
  PARAMETERS: p_file  LIKE rlgrap-filename DEFAULT 'c:\'.
SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN: BEGIN OF LINE,
PUSHBUTTON 2(30)  down_exc USER-COMMAND down_exc VISIBLE LENGTH 25.
SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
PUSHBUTTON 2(30)  maint USER-COMMAND maint VISIBLE LENGTH 25.
SELECTION-SCREEN: END OF LINE.

SELECTION-SCREEN: BEGIN OF LINE,
PUSHBUTTON 2(30)  report USER-COMMAND report VISIBLE LENGTH 25.
SELECTION-SCREEN: END OF LINE.
