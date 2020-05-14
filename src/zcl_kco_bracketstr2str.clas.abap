class ZCL_KCO_BRACKETSTR2STR definition
  public
  final
  create public .

public section.

  class-methods CONVERT_BRACKETSTRING
    importing
      !IV_VALUE type STRING
    returning
      value(RV_VALUE) type STRING .
protected section.
private section.
ENDCLASS.



CLASS ZCL_KCO_BRACKETSTR2STR IMPLEMENTATION.


  METHOD convert_bracketstring.
    DATA:
      lv_match        TYPE string,
      lv_repeat_times TYPE string,
      lv_repeat_value TYPE string,
      lv_value        TYPE string.

    rv_value = iv_value.

    DO.
      lv_match = match( val = rv_value regex = '(\d{0,})\[([^\[\]]+)\]' ).
      IF lv_match IS INITIAL.
        EXIT.
      ENDIF.
      lv_repeat_times = substring_before( val = lv_match sub = '[' ).
      lv_repeat_value = substring_before( val = substring_after( val = lv_match sub = '[' ) sub = ']' ).
      lv_value = repeat( val = lv_repeat_value occ = lv_repeat_times ).
      rv_value = replace( val = rv_value regex = '(\d{0,})\[([^\[\]]+)\]' with = lv_value ).
    ENDDO.

  ENDMETHOD.
ENDCLASS.
