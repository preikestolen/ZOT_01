CLASS zcl_ot_01_zmn DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: final_seconds(10),
          final_days(10),

          res_hours(10),
          res_mins(10),
          res_secs(10),

          res_years(10),
          res_mons(10),
          res_days(10),

          oneday TYPE sy-uzeit VALUE '240000'.

    TYPES: BEGIN OF ty_st_diff,
             date_index(10) TYPE c,
             years(10) TYPE c,
             mons(10)  TYPE c,
             days(10)  TYPE c,
             hours(10) TYPE c,
             mins(10)  TYPE c,
             secs(10)  TYPE c,
           END OF ty_st_diff.

    METHODS calculate_diff
      IMPORTING iv_date_index TYPE char10
                iv_strdate TYPE sy-datum
                iv_enddate TYPE sy-datum
                iv_strtime TYPE sy-uzeit
                iv_endtime TYPE sy-uzeit
      EXPORTING ev_diff    TYPE ty_st_diff.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_ot_01_zmn IMPLEMENTATION.
  METHOD calculate_diff.
    IF iv_enddate < iv_strdate.
*    exit the program with warning msg.
*    baslangic tarihi bitis tarihinden daha buyuk olamaz.
      WRITE: / 'Baslangic tarihi bitis tarihinden daha buyuk olamaz'.
      RETURN.
    ENDIF.


    "tarihler ayni ise
    IF iv_enddate = iv_strdate.
*   tarihler ayni iken baslangic saati daha buyuk olamaz.
      IF iv_endtime >= iv_strtime.
        final_days = 0.
        final_seconds = iv_endtime - iv_strtime. "saniye olarak tutulur
      ELSE.
*    exit the program with warning msg.
        WRITE: / 'Tarihler ayni iken baslangic saati daha buyuk olamaz'.
        RETURN.
      ENDIF.
    ENDIF.
    "tarihler farkli ise
    IF iv_enddate NE iv_strdate.
*    suanda bitis tarihinin baslangic tarihinden buyuk oldugunu biliyorum.
*    baslangic ve bitis saatini kontrol edebilirim.
*    eger baslangic saati bitis saatinden buyukse, o zaman -1 gun yapilmali.
*    ve o gundeki 24 saat time farki yapilirken eklenmeli.
      final_days = iv_enddate - iv_strdate. "gun olarak tutulur.
      IF iv_strtime > iv_endtime.
        final_days -= 1.
        final_seconds = oneday - iv_strtime + iv_endtime.
      ELSE.
        final_seconds = iv_endtime - iv_strtime.
      ENDIF.
    ENDIF.

*    WRITE: / final_days.
*    WRITE: / final_seconds.

    res_years = final_days DIV 365.
    res_mons = ( final_days MOD 365 ) DIV 30.
    res_days = ( final_days MOD 365 ) MOD 30.

    res_hours = final_seconds DIV 3600.
    res_mins = ( final_seconds MOD 3600 ) DIV 60.
    res_secs = ( final_seconds MOD 3600 ) MOD 60.

    ev_diff-years = res_years.
    ev_diff-mons = res_mons.
    ev_diff-days = res_days.
    ev_diff-hours = res_hours.
    ev_diff-mins = res_mins.
    ev_diff-secs = res_secs.
    ev_diff-date_index = iv_date_index.
*    WRITE: / res_years, ' years'.
*    WRITE: / res_mons, ' mons'.
*    WRITE: / res_days, ' days'.
*
*    WRITE: / res_hours, ' hours'.
*    WRITE: / res_mins, ' mins'.
*    WRITE: / res_secs, ' seconds'.
  ENDMETHOD.

ENDCLASS.
