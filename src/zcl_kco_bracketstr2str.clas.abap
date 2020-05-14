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
      lv_repeat_times      TYPE i,
      lv_repeat_value      TYPE string,
      lv_rest_value_offset TYPE i,
      lv_value             TYPE string,
      lv_rest_value        TYPE string,
      lv_after_offset      TYPE i,
      lv_after_length      TYPE i,
      lv_finished          TYPE char1.

    DATA:
      lr_finding  TYPE REF TO match_result,
      lr_submatch TYPE REF TO submatch_result.

    DATA:
      lt_findings   TYPE match_result_tab.

    rv_value = lv_value = iv_value.
    WHILE lv_finished EQ ''.
      FIND ALL OCCURRENCES OF REGEX '(\d{0,})\[([^\[\]]+)\]' IN lv_value RESULTS lt_findings.
      LOOP AT lt_findings REFERENCE INTO lr_finding.
        IF sy-tabix EQ 1.
          rv_value = lv_value(lr_finding->offset).
        ELSE.
          lv_after_length = lr_finding->offset - lv_after_offset.
          CONCATENATE rv_value lv_value+lv_after_offset(lv_after_length) INTO rv_value.
        ENDIF.
        LOOP AT lr_finding->submatches REFERENCE INTO lr_submatch FROM 1 TO 2.
          CASE sy-tabix.
            WHEN 1.
              lv_repeat_times = lv_value+lr_submatch->offset(lr_submatch->length).
            WHEN 2.
              lv_repeat_value = lv_value+lr_submatch->offset(lr_submatch->length).
          ENDCASE.
        ENDLOOP.
        DO lv_repeat_times TIMES.
          CONCATENATE rv_value lv_repeat_value INTO rv_value.
        ENDDO.
        lv_after_offset = lr_finding->offset + lr_finding->length.
      ENDLOOP.
      IF sy-subrc NE 0.
        lv_finished = 'X'.
      ELSE.
        lv_rest_value_offset = lr_finding->offset + lr_finding->length.
        lv_rest_value = lv_value+lv_rest_value_offset.
        CONCATENATE rv_value lv_rest_value INTO lv_value.
      ENDIF.
    ENDWHILE.
  ENDMETHOD.
ENDCLASS.
