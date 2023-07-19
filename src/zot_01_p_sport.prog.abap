*&---------------------------------------------------------------------*
*& Report zot_01_p_sport
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_sport.

TYPES: BEGIN OF gty_team,
         team_name    TYPE char40,
         team_country TYPE char2,
         torba        TYPE i,
       END OF gty_team,
       tt_grup TYPE STANDARD TABLE OF gty_team.

DATA: lt_torbalar TYPE TABLE OF gty_team,
      lt_kalanlar TYPE TABLE OF gty_team,
      lt_grup1    TYPE TABLE OF gty_team,
      lt_grup2    TYPE TABLE OF gty_team,
      lt_grup3    TYPE TABLE OF gty_team,
      lt_grup4    TYPE TABLE OF gty_team,
      ls_team     TYPE gty_team,
      ls_grup     TYPE gty_team,
      ls_kalan    TYPE gty_team.

CLASS lcl_kalanlar DEFINITION.
  PUBLIC SECTION.
    METHODS : kalani_yerlestir CHANGING cv_g_size  TYPE i
                                        cv_g1_size TYPE i
                                        cv_g2_size TYPE i
                                        cv_g3_size TYPE i
                                        cv_g4_size TYPE i
                                        ct_grup    TYPE tt_grup.
ENDCLASS.
CLASS lcl_kalanlar IMPLEMENTATION.
  METHOD kalani_yerlestir.
* dolu olan gruplardan degisim yapilacak
    DATA(lv_change) = 0.
*    eger cv_g_size 4 ise bu gruptan takim cikarabiliriz
    IF cv_g_size = 4.
      LOOP AT ct_grup INTO ls_grup.
        IF ls_grup-team_country = ls_kalan-team_country AND ls_grup-torba NE ls_kalan-torba.
*            bu grupdan degistiremeyiz cunku ayni ulkeden iki tane olur
*            torbasida ayni olmamali cunku degistirecegimiz takimla ayni ulke olursa problem olmaz
          lv_change = 1.
        ENDIF.
      ENDLOOP.
      IF lv_change = 0.
*    ls_kalani grup1 e koy. ls_grupu ls_kalanin koyulamadigi grupa koy.
        READ TABLE ct_grup INTO ls_grup WITH KEY torba = ls_kalan-torba.
        IF cv_g1_size < 4.
          APPEND ls_grup TO lt_grup1.
          DELETE ct_grup WHERE torba = ls_kalan-torba.
          APPEND ls_kalan TO ct_grup.
          cv_g1_size = lines( lt_grup1 ).
        ENDIF.
        IF cv_g2_size < 4.
          APPEND ls_grup TO lt_grup2.
          DELETE ct_grup WHERE torba = ls_kalan-torba.
          APPEND ls_kalan TO ct_grup.
          cv_g2_size = lines( lt_grup2 ).
        ENDIF.
        IF cv_g3_size < 4.
          APPEND ls_grup TO lt_grup3.
          DELETE ct_grup WHERE torba = ls_kalan-torba.
          APPEND ls_kalan TO ct_grup.
          cv_g3_size = lines( lt_grup3 ).
        ENDIF.
        IF cv_g4_size < 4.
          APPEND ls_grup TO lt_grup4.
          DELETE ct_grup WHERE torba = ls_kalan-torba.
          APPEND ls_kalan TO ct_grup.
          cv_g4_size = lines( lt_grup4 ).
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  ls_team-team_name    = 'Liverpool'.
  ls_team-team_country  = 'EN'.
  ls_team-torba  = 1.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'Bayern Munih'.
  ls_team-team_country  = 'DE'.
  ls_team-torba  = 1.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'Inter'.
  ls_team-team_country  = 'IT'.
  ls_team-torba  = 1.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'PSG'.
  ls_team-team_country  = 'FR'.
  ls_team-torba  = 1.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'Mande City'.
  ls_team-team_country  = 'EN'.
  ls_team-torba  = 2.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'PSV'.
  ls_team-team_country  = 'NE'.
  ls_team-torba  = 2.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'Porto'.
  ls_team-team_country  = 'PO'.
  ls_team-torba  = 2.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'Real Madrid'.
  ls_team-team_country  = 'ES'.
  ls_team-torba  = 2.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'Dortmund'.
  ls_team-team_country  = 'DE'.
  ls_team-torba  = 3.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'Galatasaray'.
  ls_team-team_country  = 'TR'.
  ls_team-torba  = 3.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'Marsilya'.
  ls_team-team_country  = 'FR'.
  ls_team-torba  = 3.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'Ajax'.
  ls_team-team_country  = 'NE'.
  ls_team-torba  = 3.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'AEK'.
  ls_team-team_country  = 'GR'.
  ls_team-torba  = 4.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'Roma'.
  ls_team-team_country  = 'IT'.
  ls_team-torba  = 4.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'Stabukres'.
  ls_team-team_country  = 'RO'.
  ls_team-torba  = 4.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

  ls_team-team_name    = 'Atletico Madrid'.
  ls_team-team_country  = 'ES'.
  ls_team-torba  = 4.
  INSERT ls_team INTO TABLE lt_torbalar.
  CLEAR ls_team.

*break otaezdesir.

*butun takimlari gezip rastgele bir gruba koy
*her grupta torbadan sadece bi takim olacak
*her grupta ayni ulkeden iki takim olamaz
  DATA lv_rand TYPE i.
  DATA(lv_count)  = 16.

  WHILE lv_count > 0.
    CALL FUNCTION 'RANDOM_I4'
      EXPORTING
        rnd_min   = 1
        rnd_max   = lv_count
      IMPORTING
        rnd_value = lv_rand.
    READ TABLE lt_torbalar INTO ls_team INDEX lv_rand.
    IF sy-subrc = 0.
      "successful read
      DELETE lt_torbalar INDEX lv_rand.
*    her grupta ayni ulkeden iki takim olamaz
      READ TABLE lt_grup1 INTO ls_grup WITH KEY team_country = ls_team-team_country.
      IF sy-subrc = 0.
*        ayni ulkeden iki takim var
      ELSE.
*        ayni ayni ulkeden iki takim yok
        READ TABLE lt_grup1 INTO ls_grup WITH KEY torba = ls_team-torba.
        IF sy-subrc NE 0.
*      her grupta ayni torbadan iki takim olamaz
          APPEND ls_team TO lt_grup1.
          lv_count -= 1.
          CLEAR ls_team.
          CLEAR ls_grup.
          CONTINUE.
        ENDIF.
      ENDIF.
      READ TABLE lt_grup2 INTO ls_grup WITH KEY team_country = ls_team-team_country.
      IF sy-subrc = 0.
*        ayni ulkeden iki takim var
      ELSE.
*        ayni ayni ulkeden iki takim yok
        READ TABLE lt_grup2 INTO ls_grup WITH KEY torba = ls_team-torba.
        IF sy-subrc NE 0.
*      her grupta ayni torbadan iki takim olamaz
          APPEND ls_team TO lt_grup2.
          lv_count -= 1.
          CLEAR ls_team.
          CLEAR ls_grup.
          CONTINUE.
        ENDIF.
      ENDIF.
      READ TABLE lt_grup3 INTO ls_grup WITH KEY team_country = ls_team-team_country.
      IF sy-subrc = 0.
*        ayni ulkeden iki takim var
      ELSE.
*        ayni ayni ulkeden iki takim yok
        READ TABLE lt_grup3 INTO ls_grup WITH KEY torba = ls_team-torba.
        IF sy-subrc NE 0.
*      her grupta ayni torbadan iki takim olamaz
          APPEND ls_team TO lt_grup3.
          lv_count -= 1.
          CLEAR ls_team.
          CLEAR ls_grup.
          CONTINUE.
        ENDIF.
      ENDIF.
      READ TABLE lt_grup4 INTO ls_grup WITH KEY team_country = ls_team-team_country.
      IF sy-subrc = 0.
*        ayni ulkeden iki takim var
      ELSE.
*        ayni ayni ulkeden iki takim yok
        READ TABLE lt_grup4 INTO ls_grup WITH KEY torba = ls_team-torba.
        IF sy-subrc NE 0.
*      her grupta ayni torbadan iki takim olamaz
          APPEND ls_team TO lt_grup4.
          lv_count -= 1.
          CLEAR ls_team.
          CLEAR ls_grup.
          CONTINUE.
        ENDIF.
      ENDIF.
    ELSE.
      "Failed read
    ENDIF.
    lv_count -= 1.
    IF ls_team IS NOT INITIAL.
*    structure temizlenmemis, yani hic bi gruba girememis.
      APPEND ls_team TO lt_kalanlar.
    ENDIF.
    CLEAR ls_team.
    CLEAR ls_grup.
  ENDWHILE.

  DATA(lv_g1_size) = lines( lt_grup1 ).
  DATA(lv_g2_size) = lines( lt_grup2 ).
  DATA(lv_g3_size) = lines( lt_grup3 ).
  DATA(lv_g4_size) = lines( lt_grup4 ).


  LOOP AT lt_kalanlar INTO ls_kalan.
* dolu olan gruplardan degisim yapilacak
    DATA(lv_change) = 0.
    DATA: lo_kalan TYPE REF TO lcl_kalanlar.
    CREATE OBJECT lo_kalan.
    lo_kalan->kalani_yerlestir(
      CHANGING
        cv_g_size  = lv_g1_size
        cv_g1_size = lv_g1_size
        cv_g2_size = lv_g2_size
        cv_g3_size = lv_g3_size
        cv_g4_size = lv_g4_size
        ct_grup    = lt_grup1
    ).
    lo_kalan->kalani_yerlestir(
      CHANGING
        cv_g_size  = lv_g2_size
        cv_g1_size = lv_g1_size
        cv_g2_size = lv_g2_size
        cv_g3_size = lv_g3_size
        cv_g4_size = lv_g4_size
        ct_grup    = lt_grup2
    ).
    lo_kalan->kalani_yerlestir(
      CHANGING
        cv_g_size  = lv_g3_size
        cv_g1_size = lv_g1_size
        cv_g2_size = lv_g2_size
        cv_g3_size = lv_g3_size
        cv_g4_size = lv_g4_size
        ct_grup    = lt_grup3
    ).
    lo_kalan->kalani_yerlestir(
      CHANGING
        cv_g_size  = lv_g4_size
        cv_g1_size = lv_g1_size
        cv_g2_size = lv_g2_size
        cv_g3_size = lv_g3_size
        cv_g4_size = lv_g4_size
        ct_grup    = lt_grup4
    ).

  ENDLOOP.

  cl_demo_output=>display_data( lt_grup1 ).
  cl_demo_output=>display_data( lt_grup2 ).
  cl_demo_output=>display_data( lt_grup3 ).
  cl_demo_output=>display_data( lt_grup4 ).

* dolu olan gruplardan degisim yapilacak
*  DATA(lv_change) = 0.
*  IF lv_g1_size = 4.
*    LOOP AT lt_grup1 INTO ls_grup.
*      IF ls_grup-team_country = ls_kalan-team_country AND ls_grup-torba NE ls_kalan-torba.
**            bu grupdan degistiremeyiz cunku ayni ulkeden iki tane olur
*        lv_change = 1.
*      ENDIF.
*    ENDLOOP.
*    IF lv_change = 0.
**    ls_kalani grup1 e koy. ls_grupu ls_kalanin koyulamadigi grupa koy.
*      READ TABLE lt_grup1 INTO ls_grup WITH KEY torba = ls_kalan-torba.
*      IF lv_g1_size < 4.
*        APPEND ls_grup TO lt_grup1.
*        DELETE lt_grup1 WHERE torba = ls_kalan-torba.
*        APPEND ls_kalan TO lt_grup1.
*        lv_g1_size = lines( lt_grup1 ).
*      ENDIF.
*      IF lv_g2_size < 4.
*        APPEND ls_grup TO lt_grup2.
*        DELETE lt_grup1 WHERE torba = ls_kalan-torba.
*        APPEND ls_kalan TO lt_grup1.
*        lv_g2_size = lines( lt_grup2 ).
*      ENDIF.
*      IF lv_g3_size < 4.
*        APPEND ls_grup TO lt_grup3.
*        DELETE lt_grup1 WHERE torba = ls_kalan-torba.
*        APPEND ls_kalan TO lt_grup1.
*        lv_g3_size = lines( lt_grup3 ).
*      ENDIF.
*      IF lv_g4_size < 4.
*        APPEND ls_grup TO lt_grup4.
*        DELETE lt_grup1 WHERE torba = ls_kalan-torba.
*        APPEND ls_kalan TO lt_grup1.
*        lv_g4_size = lines( lt_grup4 ).
*      ENDIF.
*    ENDIF.
*  ENDIF.
*
*    lv_change = 0.
*    IF lv_g2_size = 4.
*      LOOP AT lt_grup2 INTO ls_grup.
*        IF ls_grup-team_country = ls_kalan-team_country AND ls_grup-torba NE ls_kalan-torba.
**            bu grupdan degistiremeyiz cunku ayni ulkeden iki tane olur
*          lv_change = 1.
*        ENDIF.
*      ENDLOOP.
*      IF lv_change = 0.
**    ls_kalani grup1 e koy. ls_grupu ls_kalanin koyulamadigi grupa koy.
*        READ TABLE lt_grup2 INTO ls_grup WITH KEY torba = ls_kalan-torba.
*        IF lv_g1_size < 4.
*          APPEND ls_grup TO lt_grup1.
*          DELETE lt_grup2 WHERE torba = ls_kalan-torba.
*          APPEND ls_kalan TO lt_grup2.
*          lv_g1_size = lines( lt_grup1 ).
*        ENDIF.
*        IF lv_g2_size < 4.
*          APPEND ls_grup TO lt_grup2.
*          DELETE lt_grup2 WHERE torba = ls_kalan-torba.
*          APPEND ls_kalan TO lt_grup2.
*          lv_g2_size = lines( lt_grup2 ).
*        ENDIF.
*        IF lv_g3_size < 4.
*          APPEND ls_grup TO lt_grup3.
*          DELETE lt_grup2 WHERE torba = ls_kalan-torba.
*          APPEND ls_kalan TO lt_grup2.
*          lv_g3_size = lines( lt_grup3 ).
*        ENDIF.
*        IF lv_g4_size < 4.
*          APPEND ls_grup TO lt_grup4.
*          DELETE lt_grup2 WHERE torba = ls_kalan-torba.
*          APPEND ls_kalan TO lt_grup2.
*          lv_g4_size = lines( lt_grup4 ).
*        ENDIF.
*      ENDIF.
*    ENDIF.
*
*    lv_change = 0.
*    IF lv_g3_size = 4.
*      LOOP AT lt_grup3 INTO ls_grup.
*        IF ls_grup-team_country = ls_kalan-team_country AND ls_grup-torba NE ls_kalan-torba.
**            bu grupdan degistiremeyiz cunku ayni ulkeden iki tane olur
*          lv_change = 1.
*        ENDIF.
*      ENDLOOP.
*      IF lv_change = 0.
**    ls_kalani grup1 e koy. ls_grupu ls_kalanin koyulamadigi grupa koy.
*        READ TABLE lt_grup3 INTO ls_grup WITH KEY torba = ls_kalan-torba.
*        IF lv_g1_size < 4.
*          APPEND ls_grup TO lt_grup1.
*          DELETE lt_grup3 WHERE torba = ls_kalan-torba.
*          APPEND ls_kalan TO lt_grup3.
*          lv_g1_size = lines( lt_grup1 ).
*        ENDIF.
*        IF lv_g2_size < 4.
*          APPEND ls_grup TO lt_grup2.
*          DELETE lt_grup3 WHERE torba = ls_kalan-torba.
*          APPEND ls_kalan TO lt_grup3.
*          lv_g2_size = lines( lt_grup2 ).
*        ENDIF.
*        IF lv_g3_size < 4.
*          APPEND ls_grup TO lt_grup3.
*          DELETE lt_grup3 WHERE torba = ls_kalan-torba.
*          APPEND ls_kalan TO lt_grup3.
*          lv_g3_size = lines( lt_grup3 ).
*        ENDIF.
*        IF lv_g4_size < 4.
*          APPEND ls_grup TO lt_grup4.
*          DELETE lt_grup3 WHERE torba = ls_kalan-torba.
*          APPEND ls_kalan TO lt_grup3.
*          lv_g4_size = lines( lt_grup4 ).
*        ENDIF.
*      ENDIF.
*    ENDIF.
