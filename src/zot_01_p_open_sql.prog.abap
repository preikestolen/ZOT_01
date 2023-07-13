*&---------------------------------------------------------------------*
*& Report zot_01_p_open_sql
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_open_sql.

DATA gv_banfn TYPE eban-banfn.

DATA gs_banfn TYPE eban. " Eban standard bir tablodur.

DATA gt_eban TYPE TABLE OF eban.

START-OF-SELECTION.

  SELECT SINGLE banfn " select single her zaman ilk satiri getirir.
      FROM eban
      WHERE bsart EQ 'NB'
      INTO @gv_banfn.

  SELECT SINGLE bsart
     FROM eban
     WHERE banfn EQ '0010000023'
     AND bnfpo = '00020'
     INTO @DATA(lv_loekz).
  "bu inline declaration. bu variable a assign ettik cikan sonucu

  WRITE: / lv_loekz.

  SELECT SINGLE banfn, bsart, bnfpo
  "it gets only these columns.
   FROM eban
   WHERE banfn EQ '0010000023'
   AND bnfpo = '00020'
   INTO CORRESPONDING FIELDS OF @gs_banfn.

*  SELECT SINGLE banfn, bsart, bnfpo
   "it gets only these columns.
*   FROM eban
*   WHERE banfn EQ '0010000023'
*   AND bnfpo = '00020'
*   INTO  @DATA(ls_banfn).
  "3 alanli yeni bi structure oldu ls_banfn

*  SELECT SINGLE *
*   FROM eban
*   WHERE banfn EQ '0010000023'
*   AND bnfpo = '00020'
*   INTO @gs_banfn.

"select single yerine up to kullanilabilir
*  SELECT *
*    FROM eban
*    WHERE banfn EQ '0010000023'
*    AND bnfpo = '00020'
*    INTO @gs_banfn
*    UP TO 1 ROWS.

  "tercihimiz keylerle gitmek.

*  SELECT *
*   FROM eban
*   WHERE banfn EQ '0010000023'
*   INTO TABLE @gt_eban.
    "iki structure i olan bi internal table oldu. gt_eban a assign edildi.

*    SELECT banfn, bnfpo
*     FROM eban
*     WHERE banfn EQ '0010000023'
*     INTO TABLE @DATA(lt_eban).
      "suan 2 alanli yeni bi table oldu.

*  SELECT *
*   FROM zot_01_t_p_etur
*   WHERE egitim_kodu = 01
*   INTO TABLE @DATA(lt_egt_kod).
      " bu da z li tablodan yani kendi olusturdugum tablo ile sql komutlari.

*      SELECT *
*       FROM zot_01_t_p_etur
*       WHERE egitim_kodu = 02
*       INTO TABLE @DATA(lt_egt_kod).

*range of daki range bir internal table. icine range degerlerini append ediyoruz
*sonra where id IN @lr_id

*update te satir varsa update eder. modify da satir varsa update eder yoksa yeni satir ekler.


*      SELECT *
*       FROM zot_01_t_p_etur
*       WHERE egitim_kodu = 02
*       INTO TABLE @DATA(lt_egt_kod).



        "sy_subrc != 0 error var demek
        BREAK otaezdesir.
