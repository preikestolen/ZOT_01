*&---------------------------------------------------------------------*
*& Report zot_01_p_sip_kirilim
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_sip_kirilim.

TABLES: vbak, vbap.

FORM order_details USING p_ucomm TYPE sy-ucomm
*                         selfield kolon ve satir bilgilerini tutuyor.
                         ps_selfield TYPE slis_selfield.

  CASE p_ucomm.
    WHEN '&IC1'.
*      sy-ucomm da &ic1 cift tiklandi demek
*      MESSAGE 'Double clicked. Thanks...' TYPE 'I'.
      CONCATENATE ps_selfield-fieldname ' EQ '  '''' ps_selfield-value '''' INTO DATA(lv_sql_str).
      SELECT vbak~vbeln, vbak~kunnr, vbak~bname, vbak~auart, vbak~autlf, vbak~audat,
      vbap~posnr, vbap~matnr, vbap~arktx, vbap~netwr, vbap~waerk, vbap~charg
      FROM vbak JOIN vbap ON vbak~vbeln = vbap~vbeln
      INTO TABLE @DATA(lt_order_details)
      WHERE (lv_sql_str).
  ENDCASE.
  cl_demo_output=>display( lt_order_details ).
ENDFORM.

INCLUDE zot_01_i_sip_kirilim_sel.
INCLUDE zot_01_i_sip_kirilim_cls.

*Declare a structure of type lvc_s_fcat.
*Declare an internal table of type lvc_t_fcat  (The line type of this internal table is  lvc_s_fcat).
DATA: gs_dyn_fcat TYPE lvc_s_fcat,
      gt_dyn_fcat TYPE lvc_t_fcat,
      gv_pos      TYPE i.
DATA: go_main     TYPE REF TO lcl_main_alv.

START-OF-SELECTION.

  DATA(lv_num_buttons) = 0.

  IF p_tur = 'X'.
    lv_num_buttons += 1.
*    keeps the column position
    gv_pos = gv_pos + 1.
*   adding column to field catalog
*   the type of the fieldname comes from the tabname field of the structure
*   in this example, we create field called auart for our table
*   we dont say its data element or anything
*   when we define tabname, it searches vbak table for field auart.
*   and it gets its type for your defined field.
    gs_dyn_fcat-fieldname = 'AUART'. " Field Name
    gs_dyn_fcat-outputlen = 30. " Output Length
    gs_dyn_fcat-tabname   = 'VBAK'. " Internal Table Name
    gs_dyn_fcat-coltext   = 'AUART'. " Header text for the column
    gs_dyn_fcat-col_pos   = gv_pos. " Column position
    gs_dyn_fcat-key = 'X'. " Key attribute is set for the field vend.
    APPEND gs_dyn_fcat TO gt_dyn_fcat.
    CLEAR gs_dyn_fcat.
  ENDIF.
  IF p_no = 'X'.
    lv_num_buttons += 1.
*    keeps the column position
    gv_pos = gv_pos + 1.
*   adding column to field catalog
    gs_dyn_fcat-fieldname = 'MATNR'. " Field Name
    gs_dyn_fcat-outputlen = 30. " Output Length
    gs_dyn_fcat-tabname   = 'VBAP'. " Internal Table Name
    gs_dyn_fcat-coltext   = 'MATNR'. " Header text for the column
    gs_dyn_fcat-col_pos   = gv_pos. " Column position
    gs_dyn_fcat-key = 'X'. " Key attribute is set for the field vend.
    APPEND gs_dyn_fcat TO gt_dyn_fcat.
    CLEAR gs_dyn_fcat.
  ENDIF.
  IF p_ver = 'X'.
    lv_num_buttons += 1.
*    keeps the column position
    gv_pos = gv_pos + 1.
*   adding column to field catalog
    gs_dyn_fcat-fieldname = 'KUNNR'. " Field Name
    gs_dyn_fcat-outputlen = 30. " Output Length
    gs_dyn_fcat-tabname   = 'VBAK'. " Internal Table Name
    gs_dyn_fcat-coltext   = 'KUNNR'. " Header text for the column
    gs_dyn_fcat-col_pos   = gv_pos. " Column position
    gs_dyn_fcat-key = 'X'. " Key attribute is set for the field vend.
    APPEND gs_dyn_fcat TO gt_dyn_fcat.
    CLEAR gs_dyn_fcat.
  ENDIF.
  IF p_grup = 'X'.
    lv_num_buttons += 1.
*    keeps the column position
    gv_pos = gv_pos + 1.
*   adding column to field catalog
    gs_dyn_fcat-fieldname = 'MATKL'. " Field Name
    gs_dyn_fcat-outputlen = 30. " Output Length
    gs_dyn_fcat-tabname   = 'VBAP'. " Internal Table Name
    gs_dyn_fcat-coltext   = 'MATKL'. " Header text for the column
    gs_dyn_fcat-col_pos   = gv_pos. " Column position
    gs_dyn_fcat-key = 'X'. " Key attribute is set for the field vend.
    APPEND gs_dyn_fcat TO gt_dyn_fcat.
    CLEAR gs_dyn_fcat.
  ENDIF.
  IF p_part = 'X'.
    lv_num_buttons += 1.
*    keeps the column position
    gv_pos = gv_pos + 1.
*   adding column to field catalog
    gs_dyn_fcat-fieldname = 'CHARG'. " Field Name
    gs_dyn_fcat-outputlen = 30. " Output Length
    gs_dyn_fcat-tabname   = 'VBAP'. " Internal Table Name
    gs_dyn_fcat-coltext   = 'CHARG'. " Header text for the column
    gs_dyn_fcat-col_pos   = gv_pos. " Column position
    gs_dyn_fcat-key = 'X'. " Key attribute is set for the field vend.
    APPEND gs_dyn_fcat TO gt_dyn_fcat.
    CLEAR gs_dyn_fcat.
  ENDIF.

  IF lv_num_buttons NE 2.
    EXIT.
  ENDIF.

  gv_pos = gv_pos + 1.
*   adding column to field catalog
  gs_dyn_fcat-fieldname = 'NETWR'. " Field Name
*  gs_dyn_fcat-outputlen = 30. " Output Length
  gs_dyn_fcat-tabname   = 'VBAP'. " Internal Table Name
  gs_dyn_fcat-coltext   = 'NETWR'. " Header text for the column
  gs_dyn_fcat-col_pos   = gv_pos. " Column position
  gs_dyn_fcat-datatype   = 'CURR'. " data type
*   gs_dyn_fcat-key = 'X'. " Key attribute is set for the field vend.
* for other fields I said they are key and for this i said this is not key
* because below i am using collect statement, and it works similar to group by
* but it only works if all non key fields in the table are numeric.
  APPEND gs_dyn_fcat TO gt_dyn_fcat.
  CLEAR gs_dyn_fcat.

*Dynamic internal tables can be created using method CREATE_DYNAMIC_TABLE in class CL_ALV_TABLE_CREATE.
*
*Importing parameter is the field catalog created in step 1 and the exporting parameter is the dynamic table.
*The dynamic table must have been declared as dynamic data using data reference.

*Difference between field symbol and data reference
*
*Field symbol is a placeholder for data object to which it is assigned
*and points to the content of data object hence it can be used at any operand position (no need to dereference it)
*and works with the content of the referenced memory area (value semantics).
*
*Data references are pointers to data objects and it contains the memory address of data object (reference semantics).
*Data reference cannot be used at operand position directly; it should be dereferenced first.

  DATA: gt_dyn_table TYPE REF TO data,

        gw_line      TYPE REF TO data,
        gw_line1     TYPE REF TO data.

* Create a dynamic internal table with this structure.

  CALL METHOD cl_alv_table_create=>create_dynamic_table
    EXPORTING
*    i_style_table parameter is optional.
*    it is related to the style of the table.
*    if it is given, your table will have extra field named xyz...
*    if we have this extra field, then we can not do collect in sql
*    since collect only works when all non key fields are numeric.
*    we dont want this extra field, so we dont give this parameter.
*     i_style_table             = 'X'
      it_fieldcatalog           = gt_dyn_fcat
    IMPORTING
      ep_table                  = gt_dyn_table
    EXCEPTIONS
      generate_subpool_dir_full = 1
      OTHERS                    = 2.

*Now we have the dynamic table gt_dyn_table.
*To access the data, we use field symbols because gt_dyn_table is pointer
*we cant access pointer's content unless we dereference it.
  FIELD-SYMBOLS: <gfs_line>      TYPE any,
                 <gfs_line1>     TYPE any,
                 <gfs_dyn_table> TYPE STANDARD TABLE,
                 <fs1>           TYPE any.


* Assign the new table to field symbol
* gt_dyn_table is data reference (pointer).
* gt_dyn_table->* dereferences it (accessing its content).
* in this code below, i assign this pointer's content (dynamic table)
*into field symbol that also keeps dynamic table now.
  ASSIGN gt_dyn_table->* TO <gfs_dyn_table>.
* we cant assign it to a normal internal table because we dont know its fields.

* Create dynamic work area (like local structure for loop) for the dynamic table
  CREATE DATA gw_line LIKE LINE OF <gfs_dyn_table>.
  CREATE DATA gw_line1 LIKE LINE OF <gfs_dyn_table>.
  ASSIGN gw_line->* TO <gfs_line>.
  ASSIGN gw_line1->* TO <gfs_line1>.
* The CREATE DATA statement creates an anonymous data object
* and assigns the reference to the data object of the dref reference variables.
* By default, the data object is created in the internal session of the current program
* and remains there for as long as it is required.
* If it is no longer referenced by reference variables, it is deleted by the garbage collector.
* The data object can be created as a shared object using the addition area_handle.

*  BREAK otaezdesir.

  SELECT vbak~vbeln, vbak~kunnr, vbak~auart, vbak~audat,
  vbap~matnr, vbap~werks, vbap~pstyv, vbap~charg, vbap~netwr, vbap~waerk
  FROM vbap JOIN vbak ON vbap~vbeln = vbak~vbeln INTO TABLE @DATA(lt_vbap_vbak).

* The collect command can only be used in a table
*if all of its non key fields are numeric type (I, INT8, P, F, DECFLOAT16, DECFLOAT34)
  LOOP AT lt_vbap_vbak INTO DATA(ls_vbap_vbak).
    MOVE-CORRESPONDING ls_vbap_vbak TO <gfs_line>.
    COLLECT <gfs_line> INTO <gfs_dyn_table>.
*    APPEND <gfs_line> TO <gfs_dyn_table>.
    CLEAR <gfs_line>.
  ENDLOOP.

  CREATE OBJECT: go_main.

* when i try to give field symbol as importing parameter
* and use it in REUSE_ALV_GRID_DISPLAY_LVC, it gives overwriting protected area error
* when i changed to changing parameter, problem is solved.
  go_main->display_alv(
    CHANGING
      iv_fcat   = gt_dyn_fcat
      iv_alv_fs = <gfs_dyn_table>
  ).


*  BREAK otaezdesir.
