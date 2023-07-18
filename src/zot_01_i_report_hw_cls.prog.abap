*&---------------------------------------------------------------------*
*& Include zot_01_i_report_hw_cls
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
      "! Get report data
      "! Display report
      display_grid,
      free.

  PRIVATE SECTION.
    CLASS-DATA:
      "! Singleton object
      mo_instance              TYPE REF TO lcl_main_controller,
      "! ALV List
      mt_alv_list              TYPE TABLE OF gty_sat,
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

*  METHOD get_data.
**    SELECT * FROM mara INTO TABLE me->mt_alv_list.
*    IF r_sat = 'X'.
*      me->mt_alv_list = lt_sat_report.
*    ENDIF.
*  ENDMETHOD.

  METHOD display_grid.

    DATA: lv_title TYPE lvc_title,
          lv_lines TYPE num10,
          lv_report_name TYPE char20.


    FIELD-SYMBOLS: <lt_data> TYPE STANDARD TABLE,
*                hangi tabloyu assign edersem onun tipinde olusacak bi table
                   <ls_data> TYPE any.

*    ASSIGN me->mt_alv_list TO <lt_data>.
    IF r_sat = 'X'.
      ASSIGN lt_sat_report TO <lt_data>.
      lv_report_name = 'SAT report'.
    ENDIF.
    IF r_sas = 'X'.
      ASSIGN lt_sas_report TO <lt_data>.
      lv_report_name = 'SAS report'.
    ENDIF.
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

    CONCATENATE lv_report_name sy-uname sy-datum sy-uzeit INTO lv_title SEPARATED BY space.

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

  METHOD fill_main_fieldcat.
    DATA: lv_fname  TYPE lvc_fname,
          lv_offset TYPE i.
    IF r_sat = 'X'.
      CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
        EXPORTING
          i_structure_name       = 'ls_sat_report'
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
    ENDIF.
    IF r_sas = 'X'.
      CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
        EXPORTING
          i_structure_name       = 'ls_sas_report'
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

ENDCLASS.


DATA:
  "! Main controller global object
  go_main TYPE REF TO lcl_main_controller.
