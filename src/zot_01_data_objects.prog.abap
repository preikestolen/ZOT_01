*&---------------------------------------------------------------------*
*& Report zot_01_data_objects
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zot_01_data_objects.

"SAP deki hersey tablolarda tutuluyor.

"cl_demo_output=>write( 'Hello SAP!' ).

"cl_demo_output=>display( ).

"cl_demo_output=>line( ).

DATA: gv_student_name    TYPE c LENGTH 10, "this is predefined data type, length 10
      gv_student_name2   TYPE char10, "this is data element
      gv_student_surname TYPE char12, "data element
      gv_year            TYPE sy-datum, " system variable like sy-index, sy-langu, sy-mandt, sy-subrc
      gv_student_no(10)      TYPE p DECIMALS 2.
* data definition lara breakpoint koyamam.
gv_student_name = 'Ahmet'.
gv_student_surname = 'Ezdesir'.
gv_year = sy-datum.

*break otaezdesir.
"break-point te bu programi calistiran herkes debug a duser. tehlikeli, kullanma.


*cl_demo_output sap nin olusturdugu bi class.
cl_demo_output=>write( gv_student_name ).
cl_demo_output=>write( gv_student_surname ).
cl_demo_output=>write(
  EXPORTING
    data    = gv_year
*    name    =
*    exclude =
*    include =
).
cl_demo_output=>write( |Student name: { gv_student_name }, Student surname: { gv_student_surname }| ).

TYPES: gty_char TYPE c LENGTH 50.

DATA: gv_new TYPE gty_char.

"if
DATA: gv_langu TYPE sy-langu.
      gv_langu = sy-langu.

      if gv_langu = 'T'.
        cl_demo_output=>write( 'Merhaba' ).
      ELSEIF gv_langu = 'E'.
        cl_demo_output=>write( 'Hello' ).
      else.
        cl_demo_output=>write( 'I dont know your language' ).
      endif.

"case
*case gv_langu.
*  when 'T'.
*  cl_demo_output=>write( 'Merhaba' ).
*  WHEN 'E'.
*  cl_demo_output=>write( 'Hello' ).
*  when others.
*  cl_demo_output=>write( 'I dont know your language' ).
*
*endcase.
*
*DATA: gv_text1 TYPE char12.
*DATA(gv_num) = strlen( gv_text1 ).
*
*"while
*WHILE gv_num > 0.
*    cl_demo_output=>write( sy-index ).
*    gv_num = gv_num - 1.
*ENDWHILE.
*
*"do
*
*DO 2 times.
*    gv_text1 = 'Hello SAP!'.
*    DATA(gv_text2) = 'Hello World'.
*    "gv_text2 length ne ise o kadar alir.
*    gv_text2 = 'Hello Worldddddddddd'.
*enddo.

*DATA: lv_number1 TYPE i VALUE 10,
*      lv_number2 TYPE i VALUE 5.
*
*DATA(lv_add) = lv_number1 + lv_number2.
*DATA(lv_sub) = lv_number1 - lv_number2.
*DATA(lv_mul) = lv_number1 * lv_number2.
*DATA(lv_div) = lv_number1 / lv_number2.
*
*cl_demo_output=>write( lv_add ).
*cl_demo_output=>write( lv_sub ).
*cl_demo_output=>write( lv_mul ).
*cl_demo_output=>write( lv_div ).
*
*
*cl_demo_output=>write( |clear islemi oncesi bolem: { lv_div }| ).
*CLEAR lv_div.
*cl_demo_output=>write( |clear islemi sonrasi bolem: { lv_div }| ).
*
*try.
*    lv_div = lv_number1 / lv_number2.
*  catch cx_sy_zerodivide.
*    cl_demo_output=>write( 'zero divide exception' ).
*
*endtry.

* functions are function modules in abap.
*function group is like package for functions (function modules)

DATA: lv_number1 TYPE i VALUE 10,
      lv_number2 TYPE i VALUE 5,
*      lv_res TYPE i,
      lv_op TYPE c VALUE '+'.

*call FUNCTION 'ZOT_01_DO_MATH_OPS'
*  EXPORTING
*    iv_num1      = lv_number1
*    iv_num2      = lv_number2
*    iv_operation = lv_op
*  IMPORTING
*    ev_res       = lv_res.
**  CATCH cx_sy_zerodivide
**CATCH cx_sy_assign_cast_error
*
*cl_demo_output=>write( |res: { lv_res }| ).

DATA(lo_math_op) = new zcl_ot_01_math_ops( ).
*lo_math_op=> is for static methods
lo_math_op->calculate_res(
  EXPORTING
    iv_num1      = lv_number1
    iv_num2      = lv_number2
    iv_operation = lv_op
  IMPORTING
    ev_res       = DATA(lv_res)
).


*structure yapisi variable lardan olusur.

types: BEGIN OF gty_complex,
       alan1 TYPE c LENGTH 10,
       alan2 TYPE c LENGTH 20,
       alan3 TYPE i,
       END OF gty_complex.

TYPES: BEGIN OF gty_student,
       name TYPE c LENGTH 10,
       age TYPE i,
       id TYPE c LENGTH 10,
       bolum TYPE c LENGTH 20,
       END OF GTY_STUDENT.

DATA: gv_alan1 TYPE gty_complex-alan1,
      gs_complex TYPE gty_complex,
      gv_alan2 TYPE gty_complex-alan2,
      gt_complex TYPE TABLE OF gty_complex.

gs_complex-alan1 = 'One'.
gs_complex-alan2 = 'Talent'.
gs_complex-alan3 = 13.




cl_demo_output=>display( ).
