*&---------------------------------------------------------------------*
*& Report zot_01_p_internal_tables
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_internal_tables.

TYPES: BEGIN OF lty_material,
         matkl TYPE matkl, "material group
         menge TYPE menge_d, "quantity
       END OF lty_material.

DATA: lt_material      TYPE TABLE OF zot_00_t_materia,
      lt_material_z    TYPE TABLE OF zot_00_t_materia,
      lt_material_comb TYPE TABLE OF zot_00_t_materia,
      lt_material_collect TYPE TABLE OF lty_material,
      ls_material      TYPE zot_00_t_materia,
      ls_material_z    TYPE zot_00_t_materia,
      ls_material_collect TYPE lty_material,
      lv_matnr         TYPE matnr,
      lv_max_matnr     TYPE matnr.

*ZOT 00 T MATERIA tablosundan veriler cekilir
SELECT * FROM zot_00_t_materia INTO TABLE lt_material_z.

SELECT MAX( matnr ) FROM zot_00_t_materia INTO lv_max_matnr.
*/Z'li tablodan cekilen malzeme numaralarina göre Siradan Malzeme Numaras1
*(matnr) verilir eklenen bütün malzemelerin malzeme kodu uniq olacak.
*Malzeme Grubu (matkl)"C" olan 5 tane daha kayd1 yeni bi internal table'a atacaksiniz.
DO 5 TIMES.
  lv_max_matnr += 1.
  ls_material-matnr = lv_max_matnr.
  IF sy-index = 1.
    ls_material-maktx = 'Çekiç'.
  ELSEIF sy-index = 2.
    ls_material-maktx = 'Çivi'.
  ELSEIF sy-index = 3.
    ls_material-maktx = 'Tornavida'.
  ELSEIF sy-index = 4.
    ls_material-maktx = 'Anahtar'.
  ELSEIF sy-index = 5.
    ls_material-maktx = 'Vida'.
  ENDIF.
  ls_material-matkl = 'C'.
  ls_material-menge = 5.
  ls_material-meins = 'ST'.

  APPEND ls_material TO lt_material.
  CLEAR: ls_material.
ENDDO.

*Z'li tablodan çekilen verilerin bulundugu internal table'daki satirlarin ölçü birimi
*Malzeme grubu C olan internal tabledaki herhangi bir verinin ölçü birimi ile
*eslesivorsa z'li tablodan cekilen internal tabledaki menge alanina 10 ekle.
LOOP AT lt_material_z INTO ls_material_z.
  READ TABLE lt_material INTO ls_material
  WITH KEY meins = ls_material_z-meins.
  IF sy-subrc = 0.
    ls_material_z-menge += 10.
    MODIFY TABLE lt_material_z FROM ls_material_z.
  ENDIF.
  CLEAR ls_material_z.
ENDLOOP.

*Z'li tablodan cekilen veriler ile yeni eklediginiz verileri yeni bi
*internal table'da birlestireceksiniz.
LOOP AT lt_material_z INTO ls_material_z.
  APPEND ls_material_z TO lt_material_comb.
ENDLOOP.

LOOP AT lt_material INTO ls_material.
  APPEND ls_material TO lt_material_comb.
ENDLOOP.

*Bir internal table yaratip Malzeme gruplarinin(matkl)
*menge alanlarinin toplamini bu internal table' ekleyeceksiniz.
LOOP AT lt_material_comb INTO ls_material.
  ls_material_collect-matkl = ls_material-matkl.
  ls_material_collect-menge = ls_material-menge.
  COLLECT ls_material_collect INTO lt_material_collect.
  CLEAR ls_material_collect.
ENDLOOP.

*BREAK otaezdesir.

*menge alani 10'dan küçük olan satirlar1 birlestirdigimiz internal table'dan silin.
DELETE lt_material_comb WHERE menge < 10.

*BREAK otaezdesir.

*Ekrana menge alan1 10'dan fazla olan kayitlari menge alani küçükten büyüge
SORT lt_material_comb ASCENDING BY menge.
*Malzeme gruplarini topladiginiz internal tablein menge alanini
* büyükten küçüge olacak sekilde ekrana yazdirin.
SORT lt_material_collect DESCENDING BY menge.

cl_demo_output=>display_data( lt_material_comb ).
cl_demo_output=>display_data( lt_material_collect ).
