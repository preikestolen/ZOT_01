*&---------------------------------------------------------------------*
*& Report zot_01_abap_dict
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_abap_dict.

TYPES: BEGIN OF lty_personel,
         id        TYPE zot_01_e_id,
         ad        TYPE zot_01_e_ad,
         yas       TYPE zot_01_e_yas,
         departman TYPE zot_01_e_departman,
         unvan     TYPE zot_01_e_unvan,
       END OF lty_personel.
"suan type tanimini yaptik ortada hala structure yok structure i tanimladik sadece

DATA: ls_personel1 TYPE lty_personel,
      "yukardaki local structure tanimladik sadece burada kullanilabilir
      ls_personel  TYPE zot_01_s_personel,
      "abap dict ile structure olusturduk. bu structure tanimi her yerde kullanilabilir. bu local bi type degil
      lt_personel  TYPE TABLE OF zot_01_s_personel,
      "structure ile table olusturma
      "table ve table type ayni sey degil.
      lt_personel2 TYPE zot_01_tt_personel,
      "bu da table type ile table olusturma.
      "lt_personel yi lt_personel2 e append edebiliriz.
      lt_personel3 TYPE TABLE OF zot_01_tt_personel.
      "check table ile database table daki her hangi bi field a rastgele veri girilmesini engelleyebiliriz
      " mesela departman field ina asdadasd yazilmamali.




DATA(lt_ekip) = VALUE zot_01_tt_ekip( ( id = 1 ad = 'Alper Birinci' ) ).

lt_personel = VALUE #(
(
id = 1
ad = 'Ahmet Ezdesir'
yas = 18
departman = 'ABAP'
unvan = 'Stajyer'
ekip = lt_ekip ) ).

BREAK otaezdesir.
