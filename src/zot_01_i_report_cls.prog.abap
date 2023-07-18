*&---------------------------------------------------------------------*
*& Include zot_01_i_report_cls
*&---------------------------------------------------------------------*

CLASS lcl_main_controller DEFINITION CREATE PRIVATE FINAL.
  PUBLIC SECTION.
    CONSTANTS:
      "! Error message type
      mc_msgty_error   TYPE sy-msgty VALUE 'E',
      "! Success message type
      mc_msgty_success TYPE sy-msgty VALUE 'S'.

    CLASS-METHODS:
      "! Main controller get singleton object
      get_instance
        RETURNING
          VALUE(ro_instance) TYPE REF TO lcl_main_controller.

    METHODS:
      "! Selection screen output event
      selscr_output,
      "! Selection screen input event
      selscr_input,
      "! Get report data
      get_data,
      "! Display report
      display_data,
      display_SALV,
      display_grid,
      select_file,
      init_0100,
      free.

  PRIVATE SECTION.
    CLASS-DATA:
      "! Singleton object
      mo_instance              TYPE REF TO lcl_main_controller,
      "! ALV List
      mt_alv_list              TYPE TABLE OF mara,
      "! Main custom container
      mo_main_custom_container TYPE REF TO cl_gui_custom_container,
      "! Main ALV grid
      mo_main_grid             TYPE REF TO cl_gui_alv_grid.

    METHODS:
      fill_main_fieldcat
        RETURNING
          VALUE(rt_fcat) TYPE lvc_t_fcat,
      fill_main_layout
        RETURNING
          VALUE(rs_layo) TYPE lvc_s_layo,
      set_handler_for_main,
      handle_user_command FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING
          e_ucomm,
      on_user_command_salv FOR EVENT added_function OF cl_salv_events
        IMPORTING e_salv_function.

ENDCLASS.

CLASS lcl_main_controller IMPLEMENTATION.
  METHOD get_instance.
    IF mo_instance IS INITIAL.
      mo_instance = NEW #( ).
    ENDIF.
    ro_instance = mo_instance.
  ENDMETHOD.

  METHOD selscr_output.
    CONCATENATE '@J2@' TEXT-003 INTO down_exc SEPARATED BY space.
    CONCATENATE '@DI@' TEXT-004 INTO maint  SEPARATED BY space.
    CONCATENATE '@QH@' TEXT-005 INTO report  SEPARATED BY space.
*    tirnak icindekiler belli bir ikona denk geliyor.
*    bunlar push buttonlarin ikonlari

*    IF p_doctyp EQ '1'.
*    loop ile ekrandaki elementleri gezer parameter mesela. ismi grubu vs gelir.
      LOOP AT SCREEN.
        IF screen-name CS 'S_MATNR'.
*        field name im s_matnr yi iceriyorsa demek CS. consist
*        field name i s_matnr iceriyorsa,
*         aktifligini sifira cek ve modify et yani guncelle
          screen-active = 0.
          MODIFY SCREEN.
        ENDIF.
      ENDLOOP.
*    ENDIF.
  ENDMETHOD.

  METHOD selscr_input.
*    IF sy-ucomm = 'MAINT'.
**      go_main->mainttenance_tables( ).
*    ELSEIF sy-ucomm = 'DOWN_EXC'.
**      go_main->crt_excl_template( ).
*    ELSEIF sy-ucomm = 'REPORT'.
**      go_main->call_log_report( ).
*    ENDIF.

*      IF p_doctyp = '2'.
*        p_bukrs = '1020'.
*      ELSEIF p_doctyp = '3'.
*        p_bukrs = '4040'.
*      ENDIF.

*    s matnr nin low alani dolu ise matkl alaninin lowunu set ettim.
    IF s_matnr-low IS NOT INITIAL.
      APPEND VALUE #( SIGN = 'I' OPTION = 'EQ' LOW = 'B001' ) TO s_matkl.
    ENDIF.

  ENDMETHOD.

  METHOD get_data.

    SELECT * FROM mara INTO TABLE me->mt_alv_list.

  ENDMETHOD.

  METHOD display_data.
    IF me->mt_alv_list IS INITIAL.
      MESSAGE 'Veri bulunamadı!' TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.
      CALL SCREEN 0100.
    ENDIF.
  ENDMETHOD.

  METHOD display_SALV.

    cl_salv_table=>factory(
      EXPORTING
        list_display = ''
      IMPORTING
        r_salv_table = go_alv
      CHANGING
        t_table      = me->mt_alv_list ).

    go_alv->set_screen_popup(
      start_column = 1
      end_column   = 150
      start_line   = 1
      end_line     = 20 ).

    go_alv->set_screen_status( pfstatus      = 'STANDARD'
                               report        = sy-repid
                               set_functions = go_alv->c_functions_all ).


    DATA(lr_selections) = go_alv->get_selections( ).
    lr_selections->set_selection_mode(
    if_salv_c_selection_mode=>row_column ).

    DATA(gr_events) = go_alv->get_event( ).
    SET HANDLER me->on_user_command_salv FOR gr_events.

    go_alv->display( ).
  ENDMETHOD.

  METHOD display_grid.



    DATA: lv_title TYPE lvc_title,
          lv_lines TYPE num10.

    FIELD-SYMBOLS: <lt_data> TYPE STANDARD TABLE,
*                hangi tabloyu assign edersem onun tipinde olusacak bi table
                   <ls_data> TYPE any.

    ASSIGN me->mt_alv_list TO <lt_data>.
    CHECK sy-subrc IS INITIAL.

*   layout burasi
    DATA(ls_layo) = VALUE lvc_s_layo( zebra      = abap_true
                                      cwidth_opt = abap_true
                                      sel_mode   = 'A'
                                      info_fname = 'COLOR' ).
    DATA(ls_vari) = VALUE disvariant( report = sy-repid
                                      username = sy-uname ).

    DATA(lt_fcat_main) = me->fill_main_fieldcat( ).

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

  METHOD init_0100.
    IF me->mo_main_custom_container IS INITIAL.
      me->mo_main_custom_container = NEW cl_gui_custom_container( container_name = 'CC_MAIN' ).
      me->mo_main_grid = NEW cl_gui_alv_grid( i_parent = me->mo_main_custom_container i_appl_events = abap_true ).

      FIELD-SYMBOLS <lt_data> TYPE STANDARD TABLE.
      ASSIGN me->mt_alv_list TO <lt_data>.

      DATA(ls_vari) = VALUE disvariant( report = sy-repid
                                        username = sy-uname ).

      me->set_handler_for_main( ).

      DATA(lt_fcat_main) = me->fill_main_fieldcat( ).

      me->mo_main_grid->set_table_for_first_display(
        EXPORTING
          i_bypassing_buffer            = abap_true
          is_variant                    = ls_vari
          i_save                        = 'A'
          is_layout                     = me->fill_main_layout( )
        CHANGING
          it_outtab                     = <lt_data>
          it_fieldcatalog               = lt_fcat_main
        EXCEPTIONS
          invalid_parameter_combination = 1
          program_error                 = 2
          too_many_lines                = 3
          OTHERS                        = 4
      ).
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                   WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
    ELSE.
      me->mo_main_grid->refresh_table_display( is_stable = VALUE #( col = abap_true row = abap_true ) ).
    ENDIF.
  ENDMETHOD.

  METHOD fill_main_fieldcat.
    DATA: lv_fname  TYPE lvc_fname,
          lv_offset TYPE i.

*   structure name i ver fc olussun.
*    structure name basacagimiz internal table in tipi mara yani
*   mara structure tipinde bir tablo. o yuzden structure name e mara dedim.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'MARA'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = rt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDMETHOD.

  METHOD fill_main_layout.
    rs_layo = VALUE lvc_s_layo( zebra = abap_true cwidth_opt = abap_true sel_mode = 'A' ).
  ENDMETHOD.

  METHOD set_handler_for_main.
*    SET HANDLER data_changed         FOR me->mo_main_grid.
*    SET HANDLER handle_user_command  FOR me->mo_main_grid.
*    SET HANDLER handle_hotspot_click FOR me->mo_main_grid.
*    SET HANDLER double_click         FOR me->mo_main_grid.
  ENDMETHOD.
  METHOD handle_user_command.

  ENDMETHOD.
  METHOD free.
    IF me->mo_main_custom_container IS NOT INITIAL.
      me->mo_main_grid->free( ).
      me->mo_main_custom_container->free( ).
      CLEAR: me->mo_main_grid,
             me->mo_main_custom_container.
    ENDIF.
    FREE mo_instance.
    CLEAR mo_instance.
  ENDMETHOD.

  METHOD on_user_command_salv.
  ENDMETHOD.

  METHOD select_file.
      DATA: lt_file  TYPE filetable,
          lv_rc    TYPE i,
          lv_title TYPE string.

    lv_title = TEXT-006.

    CALL METHOD cl_gui_frontend_services=>file_open_dialog
      EXPORTING
        window_title            = lv_title
      CHANGING
        file_table              = lt_file
        rc                      = lv_rc
      EXCEPTIONS
        file_open_dialog_failed = 1
        cntl_error              = 2
        error_no_gui            = 3
        not_supported_by_gui    = 4
        OTHERS                  = 5.
    IF sy-subrc = 0.
      p_file = VALUE #( lt_file[ 1 ]-filename OPTIONAL ).
    ELSE.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.
ENDCLASS.


DATA:
  "! Main controller global object
  go_main TYPE REF TO lcl_main_controller.
