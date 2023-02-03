---
layout: post
title: My unit test local class templates
date: 2020-04-01 07:00
author: Johan Wigert
tags: [ABAP, Unit testing]
permalink: /2020-04-01-my-unit-test-local-class-templates/
---

I try to write unit tests for as much of my code as I think makes sense. To speed up the creation of my unit tests, I've set up two ABAP templates in eclipse which I want to share with you in this post.
<!--more-->

## The local test helper class

I try to adhere to the recommendation of the SAP style guide for Clean ABAP of [putting help methods in help classes](https://github.com/SAP/styleguides/blob/master/clean-abap/CleanABAP.md#put-help-methods-in-help-classes). I typically create several local test classes for the same class under test to avoid making one huge local test class. These local test classes can then share the common help methods which I've put into the local test helper class. I typically make the help methods available to the local test classes through inheritance.

Some examples of when I create help methods are:
- I want to do asserts for several attributes of a complex object.
- I want to create a complex object. In the test methods, I then change the specific attribute which I'm interested in testing by using a set method.

My template for the local test helper class looks like this:

```abap
CLASS lth_unit_tests DEFINITION ABSTRACT.
  PROTECTED SECTION.
    METHODS assert_complex_entity
      IMPORTING
        act TYPE REF TO zcl_complex_entity
        exp TYPE REF TO zcl_complex_entity.
    METHODS create_mock_complex_entity
      RETURNING
        VALUE(result) TYPE REF TO zcl_complex_entity.
ENDCLASS.

CLASS lth_unit_tests IMPLEMENTATION.

  METHOD assert_complex_entity.
    cl_abap_unit_assert=>assert_equals( act = act->get_description( )
                                        exp = exp->get_description( ) ).
    cl_abap_unit_assert=>assert_equals( act = act->get_start_date( )
                                        exp = exp->get_start_date( ) ).
  ENDMETHOD.

  METHOD create_mock_complex_entity.
    result = zcl_complex_factory=>create_complex_entity(
        	   description = `My test description`
        	   start_date  = '20200330' ).
  ENDMETHOD.

ENDCLASS.
```

## The local test class

In the local test classes, I put the actual tests. To be able to access the helper methods of the local test helper class, I let the local test classes inherit `lth_unit_tests`.

Depending on if I use the factory pattern, the `setup` method might call a factory to instantiate `cut` instead of directly using the `NEW` keyword. I rarely use `class_setup`, `class_teardown` or `teardown` so I often end up deleting these three methods from the local test classes.

```abap
CLASS ltc_unit_tests DEFINITION INHERITING FROM lth_unit_tests FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zif_my_interface.

    CLASS-METHODS:
      class_setup,
      class_teardown.

    METHODS:
      setup,
      teardown,
      first_test FOR TESTING.
ENDCLASS.

CLASS ltc_unit_tests IMPLEMENTATION.

  METHOD class_setup.

  ENDMETHOD.

  METHOD setup.
    cut = NEW zcl_my_class( ).
  ENDMETHOD.

  METHOD teardown.

  ENDMETHOD.

  METHOD class_teardown.

  ENDMETHOD.

  METHOD first_test.
    " given

    " when

    " then
    cl_abap_unit_assert=>fail( msg = 'Implement the first test here' ).
  ENDMETHOD.

ENDCLASS.
```

I'm curious to hear what feedback you have on the templates above, and if you have suggestions for improvement.

Happy testing!

_If you would like to comment on this post, please head over to [SAP Community](https://blogs.sap.com/2020/04/01/my-unit-test-local-class-templates/)._