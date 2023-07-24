*&---------------------------------------------------------------------*
*& Include zot_01_i_sip_kirilim_sel
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_vbeln FOR vbak-vbeln, " siparis no
                  s_kunnr FOR vbak-kunnr, " siparis veren
                  s_auart FOR vbak-auart, " siparis turu
                  s_audat FOR vbak-audat. " belge tarihi
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  SELECT-OPTIONS: s_matnr FOR vbap-matnr, " malzeme no
                  s_werks FOR vbap-werks, " uretim yeri
                  s_pstyv FOR vbap-pstyv, " kalem tipi
                  s_matkl FOR vbap-matkl, " mal grubu
                  s_charg FOR vbap-charg. " parti
SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 10(20) TEXT-003.
PARAMETERS p_tur AS CHECKBOX.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 10(20) TEXT-004.
PARAMETERS p_no AS CHECKBOX.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 10(20) TEXT-005.
PARAMETERS p_ver AS CHECKBOX.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 10(20) TEXT-006.
PARAMETERS p_grup AS CHECKBOX.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 10(20) TEXT-007.
PARAMETERS p_part AS CHECKBOX.
SELECTION-SCREEN END OF LINE.
