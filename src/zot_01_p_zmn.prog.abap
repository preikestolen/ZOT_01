*&---------------------------------------------------------------------*
*& Report zot_01_p_zmn
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_p_zmn.

TABLES: zot_01_t_zmn.

TYPES: BEGIN OF ty_st_diff,
         date_index(10) TYPE c,
         years(10)      TYPE c,
         mons(10)       TYPE c,
         days(10)       TYPE c,
         hours(10)      TYPE c,
         mins(10)       TYPE c,
         secs(10)       TYPE c,
       END OF ty_st_diff.

DATA: ls_time_diff TYPE ty_st_diff,
      lo_time_diff TYPE REF TO zcl_ot_01_zmn,
      it_zmn       TYPE TABLE OF zot_01_t_zmn,
      it_res_diff  TYPE TABLE OF ty_st_diff,
      wa_zmn       TYPE zot_01_t_zmn,
      wa_res_diff  TYPE ty_st_diff.
*       zot_01_t_zmn represents table type since we say type table of
*       table is a data dictionary object in sap. table is of different types
*       1. database tables
*       2. internal tables
*       table type gives option for u to select different types of internal tables. they are
*       1. standard table
*       2. sorted table
*       3. hash table
*       Table type just contains the structure of the table
*       and it doesnt contains any records stored in it.
*       Whereas the table contains the records stored in it.
*       Tables are database tables having a structure ie fields and data in that.
*       Table types are structures with fields but no data.
*       We can define internal tables like those table types in our program.
*       Table types can also be created by writting codes in the program like
*       types : begin of structure,
*       ........
*       .........
*       end of structure.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS s_index FOR zot_01_t_zmn-date_index.
*  select options is used to get a range of values.
*  select-options <selection table name> for <field of a table>
*  when select-options is executed, an internal table (selection table)
*  containing 4 components (sign, option, low, high) is created.
*  These components correspond to the fields of a database table
*  or an internal field of the corresponding program.
*  if we put 1 and 3 to select options in the ui,
*  low and high fields of the selection table will be 1 and 3
  SELECT * FROM zot_01_t_zmn INTO TABLE it_zmn WHERE date_index IN s_index.
*  then, we get each row within these index range from database table into internal table.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.

  CREATE OBJECT lo_time_diff.

*LOOP AT is used to read more than one data record in an internal table.
*The Data record is assigned to a local work area or field symbol.
*LOOP statement reads line by line into the work area.
*LOOP statement can be used to read and process internal tables.
*In the functionality point of view there is no difference between the structure and workarea.
*But structure is defined in the data dictionary and can be used in both data dictionary
*as well as in program while workarea is restricted to program.
*workarea is also a type of structure .

  LOOP AT it_zmn INTO wa_zmn.
    lo_time_diff->calculate_diff(
      EXPORTING
        iv_date_index = wa_zmn-date_index
        iv_strdate    = wa_zmn-str_date
        iv_enddate    = wa_zmn-end_date
        iv_strtime    = wa_zmn-str_time
        iv_endtime    = wa_zmn-end_time
      IMPORTING
        ev_diff       = ls_time_diff
    ).
    APPEND ls_time_diff TO it_res_diff.
  ENDLOOP.

  LOOP AT it_res_diff INTO wa_res_diff.
    WRITE: wa_res_diff-date_index, '.index difference ->'.
    IF wa_res_diff-years NE 0.
      WRITE: wa_res_diff-years, 'years'.
    ENDIF.
    IF wa_res_diff-mons NE 0.
      WRITE: wa_res_diff-mons, 'months'.
    ENDIF.
    IF wa_res_diff-days NE 0.
      WRITE: wa_res_diff-days, 'days'.
    ENDIF.
    IF wa_res_diff-hours NE 0.
      WRITE: wa_res_diff-hours, 'hours'.
    ENDIF.
    IF wa_res_diff-mins NE 0.
      WRITE: wa_res_diff-mins, 'minutes'.
    ENDIF.
    IF wa_res_diff-secs NE 0.
      WRITE: wa_res_diff-secs, 'seconds'.
    ENDIF.
    WRITE: /.
  ENDLOOP.
