CLASS lcl_test DEFINITION FOR TESTING
  "#AU Duration Medium
  "#AU Risk_Level Harmless
.
  PRIVATE SECTION.
    METHODS:
      test_get_value_normal FOR TESTING,
      test_get_value_nested FOR TESTING,
      test_get_value_deepnested FOR TESTING.
ENDCLASS.       "lcl_Test

CLASS lcl_test IMPLEMENTATION.

  METHOD test_get_value_normal.
    DATA:
      lv_value TYPE string.

    lv_value = zcl_kco_bracketstr2str=>convert_bracketstring( '1[a]2[b]3[c]4[d]' ).
    cl_aunit_assert=>assert_equals( act = lv_value
                                    exp = 'abbcccdddd' ).
  ENDMETHOD.                    "test_get_value_normal

  METHOD test_get_value_nested.
    DATA:
      lv_value TYPE string.

    lv_value = zcl_kco_bracketstr2str=>convert_bracketstring( '2[3[a]b]' ).
    cl_aunit_assert=>assert_equals( act = lv_value
                                    exp = 'aaabaaab' ).
  ENDMETHOD.                    "test_get_value_nested

  METHOD test_get_value_deepnested.
    DATA:
      lv_value TYPE string.

    lv_value = zcl_kco_bracketstr2str=>convert_bracketstring( '1[2[3[c]a]4[a]b]' ).
    cl_aunit_assert=>assert_equals( act = lv_value
                                    exp = 'cccacccaaaaab' ).
  ENDMETHOD.                    "test_get_value_deepnested

ENDCLASS.                    "lcl_test IMPLEMENTATION
