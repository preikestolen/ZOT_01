*&---------------------------------------------------------------------*
*& Include zot_01_p_class_alv_2_pai
*&---------------------------------------------------------------------*

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'YAZDIR'.
      MESSAGE 'Belge Yazdırılıyor!' TYPE 'I'.
  ENDCASE.

ENDMODULE.
