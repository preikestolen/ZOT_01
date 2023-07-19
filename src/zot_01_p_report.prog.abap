*&---------------------------------------------------------------------*
*& Report zot_01_p_report
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_report.

INCLUDE zot_01_i_report_hw_top.
INCLUDE zot_01_i_report_hw_sel.
INCLUDE zot_01_i_report_hw_cls.
INCLUDE zot_01_i_report_hw_mdl.

INITIALIZATION.
  go_main = lcl_main_controller=>get_instance( ).

* bundan sonra data cekecegim yerler. mara malzeme verilerini tuttugumuz tablo,
START-OF-SELECTION.
  CASE 'X'.
    WHEN r_sat.
      SELECT eban~banfn, eban~bnfpo, eban~bsart, eban~matnr, eban~menge, eban~meins
       FROM eban JOIN ekpo  ON eban~banfn = ekpo~banfn AND eban~bnfpo = ekpo~bnfpo
       WHERE eban~banfn IN @s_sat_no
        INTO TABLE @lt_sat_report.
    WHEN r_sas.
      SELECT ekpo~ebeln, ekpo~ebelp, ekpo~matnr, ekpo~menge, ekpo~meins
       FROM ekpo JOIN eban  ON eban~banfn = ekpo~banfn AND eban~bnfpo = ekpo~bnfpo
       WHERE ekpo~ebeln IN @s_sas_no
        INTO TABLE @lt_sas_report.
  ENDCASE.

*  BREAK otaezdesir.

  CASE 'X'.
    WHEN r_sat.

      LOOP AT lt_sat_report INTO ls_sat_report.
        IF ls_sat_report-menge > 10.
          ls_sat_report-color = 'C510'.
          MODIFY lt_sat_report FROM ls_sat_report.
        ENDIF.
        CLEAR ls_sat_report.
      ENDLOOP.
* sas icin sy_subrc 4 aliyor yani hic record bulamiyor.
    WHEN r_sas.
      LOOP AT lt_sas_report INTO ls_sas_report.
        IF ls_sas_report-menge > 10.
          ls_sas_report-color = 'C510'.
          MODIFY lt_sas_report FROM ls_sas_report.
        ENDIF.
        CLEAR ls_sas_report.
      ENDLOOP.
  ENDCASE.

END-OF-SELECTION.
  go_main->display_grid( ).
