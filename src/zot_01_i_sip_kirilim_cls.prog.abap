*&---------------------------------------------------------------------*
*& Include zot_01_i_sip_kirilim_cls
*&---------------------------------------------------------------------*



CLASS lcl_main_alv DEFINITION.
  PUBLIC SECTION.
    CONSTANTS:
      "! Error message type
      mc_msgty_error   TYPE sy-msgty VALUE 'E',
      "! Success message type
      mc_msgty_success TYPE sy-msgty VALUE 'S'.

    METHODS:
      "! Display report
      display_alv CHANGING
                    iv_fcat   TYPE lvc_t_fcat
                    iv_alv_fs TYPE STANDARD TABLE.

  PRIVATE SECTION.
    METHODS:
      set_handler_for_main.
ENDCLASS.

CLASS lcl_main_alv IMPLEMENTATION.

  METHOD display_alv.
    DATA: lv_title TYPE lvc_title,
          lv_lines TYPE num10.

    FIELD-SYMBOLS: <lt_data> TYPE STANDARD TABLE,
*                hangi tabloyu assign edersem onun tipinde olusacak bi table
                   <ls_data> TYPE any.

    ASSIGN iv_alv_fs TO <lt_data>.
    CHECK sy-subrc IS INITIAL.

*   layout burasi
    DATA(ls_layo) = VALUE lvc_s_layo( zebra      = abap_true
                                      cwidth_opt = abap_true
                                      sel_mode   = 'A'
                                      info_fname = 'COLOR' ).
    DATA(ls_vari) = VALUE disvariant( report = sy-repid
                                      username = sy-uname ).

    DATA(lt_fcat_main) = iv_fcat.

    DESCRIBE TABLE <lt_data> LINES lv_lines.
    SHIFT lv_lines LEFT DELETING LEADING '0'.

    CONCATENATE 'Rapor' lv_lines 'Kayıt' INTO lv_title SEPARATED BY space.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        i_grid_title       = lv_title
        is_layout_lvc      = ls_layo
        it_fieldcat_lvc    = lt_fcat_main
        i_save             = 'A'
        is_variant         = ls_vari
        i_callback_user_command = 'ORDER_DETAILS'
      TABLES
        t_outtab           = <lt_data>
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.
    IF sy-subrc IS NOT INITIAL.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.

  METHOD set_handler_for_main.
*    SET HANDLER data_changed         FOR me->mo_main_grid.
*    SET HANDLER handle_user_command  FOR me->mo_main_grid.
*    SET HANDLER handle_hotspot_click FOR me->mo_main_grid.
*    SET HANDLER double_click         FOR me->mo_main_grid.
  ENDMETHOD.

ENDCLASS.
