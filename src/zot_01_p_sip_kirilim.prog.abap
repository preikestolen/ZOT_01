*&---------------------------------------------------------------------*
*& Report zot_01_p_sip_kirilim
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_sip_kirilim.

TABLES: vbak, vbap.

INCLUDE zot_01_i_sip_kirilim_sel.



START-OF-SELECTION.

  DATA(lv_num_buttons) = 0.

  IF p_tur = 'X'.
    lv_num_buttons += 1.
  ENDIF.
  IF p_no = 'X'.
    lv_num_buttons += 1.
  ENDIF.
  IF p_ver = 'X'.
    lv_num_buttons += 1.
  ENDIF.
  IF p_grup = 'X'.
    lv_num_buttons += 1.
  ENDIF.
  IF p_part = 'X'.
    lv_num_buttons += 1.
  ENDIF.

  IF lv_num_buttons NE 2.
    EXIT.
  ENDIF.

  TYPES: BEGIN OF gty_table,
           vbeln TYPE vbeln_va,
           kunnr TYPE kunag,
           auart TYPE auart,
           audat TYPE audat,
           matnr TYPE matnr,
           werks TYPE werks_ext,
           pstyv TYPE pstyv,
           charg TYPE charg_d,
           netwr TYPE netwr_ap,
           waerk TYPE waerk,
         END OF gty_table.

  DATA lt_table TYPE TABLE OF gty_table.
  SELECT vbak~vbeln, vbak~kunnr, vbak~auart, vbak~audat,
  vbap~matnr, vbap~werks, vbap~pstyv, vbap~charg, vbap~netwr, vbap~waerk
  FROM vbap JOIN vbak ON vbap~vbeln = vbak~vbeln INTO TABLE @lt_table.


*SELECT t1~matnr, t2~kunnr, sum( t1~netwr ) as deger
*FROM vbak AS t2 JOIN vbap AS t1 ON t2~vbeln = t1~vbeln
*GROUP BY t1~matnr, t2~kunnr INTO TABLE @DATA(lt_table_2).
  FIELD-SYMBOLS: <lt_table_2> TYPE STANDARD TABLE.

  IF p_tur = 'X' AND p_no = 'X'.
    TYPES: BEGIN OF lty_1,
             auart TYPE auart,
             matnr TYPE matnr,
             netwr TYPE netwr_ap,
           END OF lty_1.
    DATA lt_tur_no TYPE TABLE OF lty_1.
    ASSIGN lt_tur_no TO <lt_table_2>.
    SELECT t2~auart, t1~matnr, SUM( t1~netwr ) AS deger
    FROM vbak AS t2 JOIN vbap AS t1 ON t2~vbeln = t1~vbeln
    WHERE t2~vbeln IN @s_vbeln AND t2~kunnr IN @s_kunnr
    AND t2~auart IN @s_auart AND t2~audat IN @s_audat
    AND t1~matnr IN @s_matnr AND t1~werks IN @s_werks
    AND t1~pstyv IN @s_pstyv AND t1~matkl IN @s_matkl AND t1~charg IN @s_charg
    GROUP BY t1~matnr, t2~auart INTO TABLE @<lt_table_2>.
  ENDIF.
  IF p_tur = 'X' AND p_ver = 'X'.
    TYPES: BEGIN OF lty_2,
             auart TYPE auart,
             kunnr TYPE kunag,
             netwr TYPE netwr_ap,
           END OF lty_2.
    DATA lt_tur_ver TYPE TABLE OF lty_2.
    ASSIGN lt_tur_ver TO <lt_table_2>.
    SELECT t2~auart, t2~kunnr, SUM( t1~netwr ) AS deger
    FROM vbak AS t2 JOIN vbap AS t1 ON t2~vbeln = t1~vbeln
    WHERE t2~vbeln IN @s_vbeln AND t2~kunnr IN @s_kunnr
    AND t2~auart IN @s_auart AND t2~audat IN @s_audat
    AND t1~matnr IN @s_matnr AND t1~werks IN @s_werks
    AND t1~pstyv IN @s_pstyv AND t1~matkl IN @s_matkl AND t1~charg IN @s_charg
    GROUP BY t2~kunnr, t2~auart INTO TABLE @<lt_table_2>.
  ENDIF.
  IF p_tur = 'X' AND p_grup = 'X'.
    TYPES: BEGIN OF lty_3,
             auart TYPE auart,
             matkl TYPE matkl,
             netwr TYPE netwr_ap,
           END OF lty_3.
    DATA lt_tur_grup TYPE TABLE OF lty_3.
    ASSIGN lt_tur_grup TO <lt_table_2>.
    SELECT t2~auart, t1~matkl, SUM( t1~netwr ) AS deger
    FROM vbak AS t2 JOIN vbap AS t1 ON t2~vbeln = t1~vbeln
    WHERE t2~vbeln IN @s_vbeln AND t2~kunnr IN @s_kunnr
    AND t2~auart IN @s_auart AND t2~audat IN @s_audat
    AND t1~matnr IN @s_matnr AND t1~werks IN @s_werks
    AND t1~pstyv IN @s_pstyv AND t1~matkl IN @s_matkl AND t1~charg IN @s_charg
    GROUP BY t1~matkl, t2~auart INTO TABLE @<lt_table_2>.
  ENDIF.
  IF p_tur = 'X' AND p_part = 'X'.
    TYPES: BEGIN OF lty_4,
             auart TYPE auart,
             matkl TYPE matkl,
             netwr TYPE netwr_ap,
           END OF lty_4.
    DATA lt_tur_part TYPE TABLE OF lty_4.
    ASSIGN lt_tur_part TO <lt_table_2>.
    SELECT t2~auart, t1~charg, SUM( t1~netwr ) AS deger
    FROM vbak AS t2 JOIN vbap AS t1 ON t2~vbeln = t1~vbeln
    WHERE t2~vbeln IN @s_vbeln AND t2~kunnr IN @s_kunnr
    AND t2~auart IN @s_auart AND t2~audat IN @s_audat
    AND t1~matnr IN @s_matnr AND t1~werks IN @s_werks
    AND t1~pstyv IN @s_pstyv AND t1~matkl IN @s_matkl AND t1~charg IN @s_charg
    GROUP BY t1~charg, t2~auart INTO TABLE @<lt_table_2>.
  ENDIF.
  IF p_no = 'X' AND p_ver = 'X'.
    TYPES: BEGIN OF lty_5,
             matnr TYPE matnr,
             kunnr TYPE kunag,
             netwr TYPE netwr_ap,
           END OF lty_5.
    DATA lt_no_ver TYPE TABLE OF lty_5.
    ASSIGN lt_no_ver TO <lt_table_2>.
    SELECT t2~kunnr, t1~matnr, SUM( t1~netwr ) AS deger
    FROM vbak AS t2 JOIN vbap AS t1 ON t2~vbeln = t1~vbeln
    WHERE t2~vbeln IN @s_vbeln AND t2~kunnr IN @s_kunnr
    AND t2~auart IN @s_auart AND t2~audat IN @s_audat
    AND t1~matnr IN @s_matnr AND t1~werks IN @s_werks
    AND t1~pstyv IN @s_pstyv AND t1~matkl IN @s_matkl AND t1~charg IN @s_charg
    GROUP BY t1~matnr, t2~kunnr INTO TABLE @<lt_table_2>.
  ENDIF.
  IF p_no = 'X' AND p_grup = 'X'.
    TYPES: BEGIN OF lty_6,
             matnr TYPE matnr,
             matkl TYPE matkl,
             netwr TYPE netwr_ap,
           END OF lty_6.
    DATA lt_no_grup TYPE TABLE OF lty_6.
    ASSIGN lt_no_grup TO <lt_table_2>.
    SELECT t1~matkl, t1~matnr, SUM( t1~netwr ) AS deger
    FROM vbak AS t2 JOIN vbap AS t1 ON t2~vbeln = t1~vbeln
    WHERE t2~vbeln IN @s_vbeln AND t2~kunnr IN @s_kunnr
    AND t2~auart IN @s_auart AND t2~audat IN @s_audat
    AND t1~matnr IN @s_matnr AND t1~werks IN @s_werks
    AND t1~pstyv IN @s_pstyv AND t1~matkl IN @s_matkl AND t1~charg IN @s_charg
    GROUP BY t1~matkl, t1~matnr INTO TABLE @<lt_table_2>.
  ENDIF.
  IF p_no = 'X' AND p_part = 'X'.
    TYPES: BEGIN OF lty_7,
             matnr TYPE matnr,
             charg TYPE charg_d,
             netwr TYPE netwr_ap,
           END OF lty_7.
    DATA lt_no_part TYPE TABLE OF lty_7.
    ASSIGN lt_no_part TO <lt_table_2>.
    SELECT t1~charg, t1~matnr, SUM( t1~netwr ) AS deger
    FROM vbak AS t2 JOIN vbap AS t1 ON t2~vbeln = t1~vbeln
    WHERE t2~vbeln IN @s_vbeln AND t2~kunnr IN @s_kunnr
    AND t2~auart IN @s_auart AND t2~audat IN @s_audat
    AND t1~matnr IN @s_matnr AND t1~werks IN @s_werks
    AND t1~pstyv IN @s_pstyv AND t1~matkl IN @s_matkl AND t1~charg IN @s_charg
    GROUP BY t1~charg, t1~matnr INTO TABLE @<lt_table_2>.
  ENDIF.
  IF p_ver = 'X' AND p_grup = 'X'.
    TYPES: BEGIN OF lty_8,
             kunnr TYPE kunag,
             matkl TYPE matkl,
             netwr TYPE netwr_ap,
           END OF lty_8.
    DATA lt_ver_grup TYPE TABLE OF lty_8.
    ASSIGN lt_ver_grup TO <lt_table_2>.
    SELECT t2~kunnr, t1~matkl, SUM( t1~netwr ) AS deger
    FROM vbak AS t2 JOIN vbap AS t1 ON t2~vbeln = t1~vbeln
    WHERE t2~vbeln IN @s_vbeln AND t2~kunnr IN @s_kunnr
    AND t2~auart IN @s_auart AND t2~audat IN @s_audat
    AND t1~matnr IN @s_matnr AND t1~werks IN @s_werks
    AND t1~pstyv IN @s_pstyv AND t1~matkl IN @s_matkl AND t1~charg IN @s_charg
    GROUP BY t1~matkl, t2~kunnr INTO TABLE @<lt_table_2>.
  ENDIF.
  IF p_ver = 'X' AND p_part = 'X'.
    TYPES: BEGIN OF lty_9,
             kunnr TYPE kunag,
             charg TYPE charg_d,
             netwr TYPE netwr_ap,
           END OF lty_9.
    DATA lt_ver_part TYPE TABLE OF lty_9.
    ASSIGN lt_ver_part TO <lt_table_2>.
    SELECT t2~kunnr, t1~charg, SUM( t1~netwr ) AS deger
    FROM vbak AS t2 JOIN vbap AS t1 ON t2~vbeln = t1~vbeln
    WHERE t2~vbeln IN @s_vbeln AND t2~kunnr IN @s_kunnr
    AND t2~auart IN @s_auart AND t2~audat IN @s_audat
    AND t1~matnr IN @s_matnr AND t1~werks IN @s_werks
    AND t1~pstyv IN @s_pstyv AND t1~matkl IN @s_matkl AND t1~charg IN @s_charg
    GROUP BY t1~charg, t2~kunnr INTO TABLE @<lt_table_2>.
  ENDIF.
  IF p_grup = 'X' AND p_part = 'X'.
    TYPES: BEGIN OF lty_10,
             matkl TYPE matkl,
             charg TYPE charg_d,
             netwr TYPE netwr_ap,
           END OF lty_10.
    DATA lt_grup_part TYPE TABLE OF lty_10.
    ASSIGN lt_grup_part TO <lt_table_2>.
    SELECT t1~matkl, t1~charg, SUM( t1~netwr ) AS deger
    FROM vbak AS t2 JOIN vbap AS t1 ON t2~vbeln = t1~vbeln
    WHERE t2~vbeln IN @s_vbeln AND t2~kunnr IN @s_kunnr
    AND t2~auart IN @s_auart AND t2~audat IN @s_audat
    AND t1~matnr IN @s_matnr AND t1~werks IN @s_werks
    AND t1~pstyv IN @s_pstyv AND t1~matkl IN @s_matkl AND t1~charg IN @s_charg
    GROUP BY t1~matkl, t1~charg INTO TABLE @<lt_table_2>.
  ENDIF.



  cl_demo_output=>display( <lt_table_2> ).
