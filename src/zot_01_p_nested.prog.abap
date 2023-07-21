*&---------------------------------------------------------------------*
*& Report zot_01_p_nested
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_nested.

DATA: lt_ogr_not TYPE zot_01_tt_ogr_not,
      ls_ogr_not TYPE zot_01_s_ogr_not,
      ls_ogr_notlar TYPE zot_01_s_not.

ls_ogr_not-ogrenci_id = '1'.
ls_ogr_not-ogrenci_ad = 'ali'.
ls_ogr_not-dogum_tarih = '01012001'.
ls_ogr_not-bolum = 'bilgisayar'.

ls_ogr_notlar-vize_1 = '20'.
ls_ogr_notlar-vize_2 = '30'.
ls_ogr_notlar-final = '70'.
ls_ogr_notlar-butunleme = '45'.

ls_ogr_not-notlar-notlar_1-ders_1 = ls_ogr_notlar.
*1 sinif 1. ders notlari
ls_ogr_not-notlar-notlar_1-ders_2 = ls_ogr_notlar.
*1 sinif 2. ders notlari
APPEND ls_ogr_not TO lt_ogr_not.
cl_demo_output=>display( lt_ogr_not ).
