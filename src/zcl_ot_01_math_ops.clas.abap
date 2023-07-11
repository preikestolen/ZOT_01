CLASS zcl_ot_01_math_ops DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS calculate_res
    IMPORTING iv_num1 TYPE i
              iv_num2 TYPE i
              iv_operation TYPE c
    EXPORTING ev_res TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ot_01_math_ops IMPLEMENTATION.
  METHOD calculate_res.
    CASE iv_operation.
    WHEN '+'.
        ev_res = iv_num1 + iv_num2.
    WHEN '-'.
        ev_res = iv_num1 - iv_num2.
    WHEN '/'.
        ev_res = iv_num1 / iv_num2.
    WHEN '*'.
        ev_res = iv_num1 * iv_num2.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
