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
    rv_value = iv_value.
    DO.
      DATA(lv_match) = match( val = rv_value regex = '(\d{0,})\[([^\[\]]+)\]' ).
      IF lv_match IS INITIAL.
        EXIT.
      ENDIF.
      DATA(lv_repeat_times) = substring_before( val = lv_match sub = '[' ).
      rv_value = replace( val = rv_value
                          regex = '(\d{0,})\[([^\[\]]+)\]'
                          with = repeat( val = substring_before( val = substring_after( val = lv_match
                                                                                        sub = '[' )
                                                                 sub = ']' )
                                         occ = CONV i( substring_before( val = lv_match
                                                                         sub = '[' ) ) ) ).
    ENDDO.
  ENDMETHOD.
ENDCLASS.
