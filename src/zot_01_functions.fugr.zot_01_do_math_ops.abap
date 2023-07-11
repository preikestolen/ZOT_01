FUNCTION zot_01_do_math_ops.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NUM1) TYPE  I
*"     VALUE(IV_NUM2) TYPE  I
*"     VALUE(IV_OPERATION) TYPE  C
*"  EXPORTING
*"     REFERENCE(EV_RES) TYPE  I
*"  RAISING
*"      CX_SY_ZERODIVIDE
*"     RESUMABLE(CX_SY_ASSIGN_CAST_ERROR)
*"----------------------------------------------------------------------
CASE iv_operation.
    when '+'.
        ev_res = iv_num1 + iv_num2.

ENDCASE.


ENDFUNCTION.
