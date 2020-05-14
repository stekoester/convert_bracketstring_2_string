CLASS lcl_test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
.
*?﻿<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">
*?<asx:values>
*?<TESTCLASS_OPTIONS>
*?<TEST_CLASS>lcl_Test
*?</TEST_CLASS>
*?<TEST_MEMBER>f_Cut
*?</TEST_MEMBER>
*?<OBJECT_UNDER_TEST>ZCL_KCO_BRACKETSTR2STR
*?</OBJECT_UNDER_TEST>
*?<OBJECT_IS_LOCAL/>
*?<GENERATE_FIXTURE/>
*?<GENERATE_CLASS_FIXTURE/>
*?<GENERATE_INVOCATION/>
*?<GENERATE_ASSERT_EQUAL>X
*?</GENERATE_ASSERT_EQUAL>
*?</TESTCLASS_OPTIONS>
*?</asx:values>
*?</asx:abap>
  PRIVATE SECTION.
    METHODS:
      test_get_value_normal FOR TESTING,
      test_get_value_nested FOR TESTING,
      test_get_value_deepnested FOR TESTING.
ENDCLASS.       "lcl_Test


CLASS lcl_test IMPLEMENTATION.

  METHOD test_get_value_normal.
    cl_abap_unit_assert=>assert_equals( act = zcl_kco_bracketstr2str=>convert_bracketstring( '1[a]2[b]3[c]4[d]' )
    exp = 'abbcccdddd' ).
  ENDMETHOD.

  METHOD test_get_value_nested.
    cl_abap_unit_assert=>assert_equals( act = zcl_kco_bracketstr2str=>convert_bracketstring( '2[3[a]b]' )
    exp = 'aaabaaab' ).
  ENDMETHOD.

  METHOD test_get_value_deepnested.
    cl_abap_unit_assert=>assert_equals( act = zcl_kco_bracketstr2str=>convert_bracketstring( '1[2[3[c]a]4[a]b]' )
    exp = 'cccacccaaaaab' ).
  ENDMETHOD.

ENDCLASS.
