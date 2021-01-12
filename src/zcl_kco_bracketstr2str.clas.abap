CLASS zcl_kco_bracketstr2str DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS convert_bracketstring
      IMPORTING
        !iv_value       TYPE string
      RETURNING
        VALUE(rv_value) TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_kco_bracketstr2str IMPLEMENTATION.


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
