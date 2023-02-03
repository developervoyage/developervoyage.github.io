---
layout: post
title: Pass by value or pass by reference?
date: 2021-02-18 07:00
author: Johan Wigert
tags: [ABAP]
permalink: /2021-02-18-pass-by-value-or-pass-by-reference/
---

When calling a method of an ABAP class, data can be passed from actual parameters to formal parameters either by value or by reference. In this blog post I'll discuss the difference and highlight some important scenarios.
<!--more-->

## Definitions

### Pass by value

The [ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_753_index_htm/7.53/en-US/index.htm?file=abenpass_by_value_glosry.htm) provides the following definition of pass by value:

> [...] In pass by value, a local data object is created as a copy of the actual parameter. Output parameters and return values are initialized when the procedure is called. Input parameters and input/output parameters are given the value of the actual parameter when they are called. Modified formal parameters are only passed to actual parameters if the procedure was concluded without errors, that is once the last statement is reached or if there is an exit using `RETURN` (or `EXIT` or `CHECK`).

### Pass by reference

The [ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_753_index_htm/7.53/en-US/index.htm?file=abenpass_by_reference_glosry.htm) provides the following definition of pass by reference:

> [...] Pass by reference does not create a local data object for the actual parameter. Instead a reference to the actual parameter is passed to the procedure when it is called and the procedure works with the actual parameter itself. Input parameters passed by reference cannot be modified in the procedure.

## Scenarios

To make the concepts easier to grasp, let us look at a few example scenarios.

### The IMPORTING scenario

In the `IMPORTING` section of the method signature, the keywords `VALUE` and `REFERENCE` are used to indicate how the data is passed. If none of these keywords are used, the parameter is passed by reference by default. It is not allowed to change an input parameter passed by reference in the method, whereas this is allowed in the pass by value scenario.

Example:

```abap
REPORT zre_test_pass_by_importing.

DATA gv_time TYPE t.

CLASS lcl_time_utility DEFINITION FINAL.

  PUBLIC SECTION.
    CLASS-METHODS display_time
      IMPORTING
        iv_time_by_reference_implicit            TYPE t
        REFERENCE(iv_time_by_reference_explicit) TYPE t
        VALUE(iv_time_by_value)                  TYPE t.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS lcl_time_utility IMPLEMENTATION.

  METHOD display_time.
    WRITE: / `Pass by reference (implicit):`.
    WRITE: / iv_time_by_reference_implicit.

    WRITE: / `Pass by reference (explicit):`.
    WRITE: / iv_time_by_reference_explicit.

    WRITE: / `Pass by value:`.
    WRITE: / iv_time_by_value.

    WAIT UP TO 2 SECONDS.
    gv_time = sy-uzeit.

    WRITE: / `Pass by reference (implicit) after 2 seconds wait:`.
    WRITE: / iv_time_by_reference_implicit.

    WRITE: / `Pass by reference (explicit) after 2 seconds wait:`.
    WRITE: / iv_time_by_reference_explicit.

    WRITE: / `Pass by value after 2 seconds wait:`.
    WRITE: / iv_time_by_value.

    iv_time_by_value = iv_time_by_value + 10.

    WRITE: / `Pass by value after adding 10 seconds to the input parameter:`.
    WRITE: / iv_time_by_value.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  gv_time = sy-uzeit.
  lcl_time_utility=>display_time(
      iv_time_by_reference_implicit = gv_time
      iv_time_by_reference_explicit = gv_time
      iv_time_by_value              = gv_time ).
```

The report generates the following output to the screen:

```output
Pass by reference (implicit):
132031
Pass by reference (explicit):
132031
Pass by value:
132031
Pass by reference (implicit) after 2 seconds wait:
132033
Pass by reference (explicit) after 2 seconds wait:
132033
Pass by value after 2 seconds wait:
132031
Pass by value after adding 10 seconds to the input parameter:
132041
```

### The EXPORTING scenario

In the `EXPORTING` section of the method signature, the keywords `VALUE` and `REFERENCE` are used to indicate how the data is passed. If none of these keywords are used, the parameter is passed by reference by default. When the parameter is passed by reference, the exporting parameter doesn't necessarily have an initial value as illustrated by the `do_nothing` method in the following example. When passing by value, the modified content of the parameter is assigned to the actual parameter only if the method is completed without errors. This is illustrated by the methods `get_time_120000_successfully` and `get_time_120000_with_exception`.

```abap
REPORT zre_test_pass_by_exporting.

DATA gv_time_by_reference_implicit TYPE t.
DATA gv_time_by_reference_explicit TYPE t.
DATA gv_time_by_value TYPE t.

CLASS lcl_time_utility DEFINITION FINAL.

  PUBLIC SECTION.
    CLASS-METHODS do_nothing
      EXPORTING
        ev_time_by_reference_implicit            TYPE t
        REFERENCE(ev_time_by_reference_explicit) TYPE t
        VALUE(ev_time_by_value)                  TYPE t.
    CLASS-METHODS get_time_120000_successfully
      EXPORTING
        ev_time_by_reference_implicit            TYPE t
        REFERENCE(ev_time_by_reference_explicit) TYPE t
        VALUE(ev_time_by_value)                  TYPE t.
    CLASS-METHODS get_time_120000_with_exception
      EXPORTING
        ev_time_by_reference_implicit            TYPE t
        REFERENCE(ev_time_by_reference_explicit) TYPE t
        VALUE(ev_time_by_value)                  TYPE t
      RAISING
        cx_abap_datfm_invalid_date.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS lcl_time_utility IMPLEMENTATION.

  METHOD do_nothing.

  ENDMETHOD.

  METHOD get_time_120000_successfully.
    ev_time_by_reference_implicit = '120000'.
    ev_time_by_reference_explicit = '120000'.
    ev_time_by_value = '120000'.
  ENDMETHOD.

  METHOD get_time_120000_with_exception.
    ev_time_by_reference_implicit = '120000'.
    ev_time_by_reference_explicit = '120000'.
    ev_time_by_value = '120000'.
    RAISE EXCEPTION TYPE cx_abap_datfm_invalid_date.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  gv_time_by_reference_implicit = sy-uzeit.
  gv_time_by_reference_explicit = sy-uzeit.
  gv_time_by_value = sy-uzeit.

  WRITE: / `Start time:`.
  WRITE: / gv_time_by_value.

  WRITE: / `Do nothing:`.

  lcl_time_utility=>do_nothing(
    IMPORTING
      ev_time_by_reference_implicit = gv_time_by_reference_implicit
      ev_time_by_reference_explicit = gv_time_by_reference_explicit
      ev_time_by_value              = gv_time_by_value ).

  WRITE: / `Pass by reference (implicit):`.
  WRITE: / gv_time_by_reference_implicit.

  WRITE: / `Pass by reference (explicit):`.
  WRITE: / gv_time_by_reference_explicit.

  WRITE: / `Pass by value:`.
  WRITE: / gv_time_by_value.

  WRITE: / `Method call successful:`.

  CLEAR: gv_time_by_reference_implicit, gv_time_by_reference_explicit, gv_time_by_value.

  lcl_time_utility=>get_time_120000_successfully(
    IMPORTING
      ev_time_by_reference_implicit = gv_time_by_reference_implicit
      ev_time_by_reference_explicit = gv_time_by_reference_explicit
      ev_time_by_value              = gv_time_by_value ).


  WRITE: / `Pass by reference (implicit):`.
  WRITE: / gv_time_by_reference_implicit.

  WRITE: / `Pass by reference (explicit):`.
  WRITE: / gv_time_by_reference_explicit.

  WRITE: / `Pass by value:`.
  WRITE: / gv_time_by_value.

  WRITE: / `Method call unsuccessful:`.

  CLEAR: gv_time_by_reference_implicit, gv_time_by_reference_explicit, gv_time_by_value.

  TRY.
      lcl_time_utility=>get_time_120000_with_exception(
        IMPORTING
          ev_time_by_reference_implicit = gv_time_by_reference_implicit
          ev_time_by_reference_explicit = gv_time_by_reference_explicit
          ev_time_by_value              = gv_time_by_value ).
    CATCH cx_abap_datfm_invalid_date.
      " do nothing
  ENDTRY.

  WRITE: / `Pass by reference (implicit):`.
  WRITE: / gv_time_by_reference_implicit.

  WRITE: / `Pass by reference (explicit):`.
  WRITE: / gv_time_by_reference_explicit.

  WRITE: / `Pass by value:`.
  WRITE: / gv_time_by_value.
```

The report generates the following output to the screen:

```output
Start time:
144905
Do nothing:
Pass by reference (implicit):
144905
Pass by reference (explicit):
144905
Pass by value:
000000
Method call successful:
Pass by reference (implicit):
120000
Pass by reference (explicit):
120000
Pass by value:
120000
Method call unsuccessful:
Pass by reference (implicit):
120000
Pass by reference (explicit):
120000
Pass by value:
000000
```

### The CHANGING scenario

In the `CHANGING` section of the method signature, the keywords `VALUE` and `REFERENCE` are used to indicate how the data is passed. If none of these keywords are used, the parameter is passed by reference by default. When passing by value, the modified content of the parameter is assigned to the actual parameter only if the method is completed without errors. This is illustrated in the following example:

```abap
REPORT zre_test_pass_by_changing.

DATA gv_time_by_reference_implicit TYPE t.
DATA gv_time_by_reference_explicit TYPE t.
DATA gv_time_by_value TYPE t.

CLASS lcl_time_utility DEFINITION FINAL.

  PUBLIC SECTION.
    CLASS-METHODS add_10_seconds_successfully
      CHANGING
        cv_time_by_reference_implicit            TYPE t
        REFERENCE(cv_time_by_reference_explicit) TYPE t
        VALUE(cv_time_by_value)                  TYPE t.
    CLASS-METHODS add_10_seconds_with_exception
      CHANGING
        cv_time_by_reference_implicit            TYPE t
        REFERENCE(cv_time_by_reference_explicit) TYPE t
        VALUE(cv_time_by_value)                  TYPE t
      RAISING
        cx_abap_datfm_invalid_date.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS lcl_time_utility IMPLEMENTATION.

  METHOD add_10_seconds_successfully.
    cv_time_by_reference_implicit = cv_time_by_reference_implicit + 10.
    cv_time_by_reference_explicit = cv_time_by_reference_explicit + 10.
    cv_time_by_value = cv_time_by_value + 10.
  ENDMETHOD.

  METHOD add_10_seconds_with_exception.
    cv_time_by_reference_implicit = cv_time_by_reference_implicit + 10.
    cv_time_by_reference_explicit = cv_time_by_reference_explicit + 10.
    cv_time_by_value = cv_time_by_value + 10.
    RAISE EXCEPTION TYPE cx_abap_datfm_invalid_date.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  gv_time_by_reference_implicit = sy-uzeit.
  gv_time_by_reference_explicit = sy-uzeit.
  gv_time_by_value = sy-uzeit.

  WRITE: / `Start time:`.
  WRITE: / gv_time_by_value.

  WRITE: / `Method call successful:`.

  lcl_time_utility=>add_10_seconds_successfully(
    CHANGING
      cv_time_by_reference_implicit = gv_time_by_reference_implicit
      cv_time_by_reference_explicit = gv_time_by_reference_explicit
      cv_time_by_value              = gv_time_by_value ).

  WRITE: / `Pass by reference (implicit):`.
  WRITE: / gv_time_by_reference_implicit.

  WRITE: / `Pass by reference (explicit):`.
  WRITE: / gv_time_by_reference_explicit.

  WRITE: / `Pass by value:`.
  WRITE: / gv_time_by_value.

  WRITE: / `Method call unsuccessful:`.

  TRY.
      lcl_time_utility=>add_10_seconds_with_exception(
        CHANGING
          cv_time_by_reference_implicit = gv_time_by_reference_implicit
          cv_time_by_reference_explicit = gv_time_by_reference_explicit
          cv_time_by_value              = gv_time_by_value ).
    CATCH cx_abap_datfm_invalid_date.
      " do nothing
  ENDTRY.

  WRITE: / `Pass by reference (implicit):`.
  WRITE: / gv_time_by_reference_implicit.

  WRITE: / `Pass by reference (explicit):`.
  WRITE: / gv_time_by_reference_explicit.

  WRITE: / `Pass by value:`.
  WRITE: / gv_time_by_value.
```

The report generates the following output to the screen:

```output
Start time:
142101
Method call successful:
Pass by reference (implicit):
142111
Pass by reference (explicit):
142111
Pass by value:
142111
Method call unsuccessful:
Pass by reference (implicit):
142121
Pass by reference (explicit):
142121
Pass by value:
142111
```

### The RETURNING scenario

In the `RETURNING` section of the method signature, the keyword `VALUE` must be used since pass by value is the only option. The modified content of the parameter is assigned to the actual parameter only if the method is completed without errors. This is illustrated in the following example:

```abap
REPORT zre_test_pass_by_returning.

DATA gv_time_by_value TYPE t.

CLASS lcl_time_utility DEFINITION FINAL.

  PUBLIC SECTION.
    CLASS-METHODS do_nothing
      RETURNING
        VALUE(result) TYPE t.
    CLASS-METHODS get_time_120000_successfully
      RETURNING
        VALUE(result) TYPE t.
    CLASS-METHODS get_time_120000_with_exception
      RETURNING
        VALUE(result) TYPE t
      RAISING
        cx_abap_datfm_invalid_date.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS lcl_time_utility IMPLEMENTATION.

  METHOD do_nothing.

  ENDMETHOD.

  METHOD get_time_120000_successfully.
    result = '120000'.
  ENDMETHOD.

  METHOD get_time_120000_with_exception.
    result = '120000'.
    RAISE EXCEPTION TYPE cx_abap_datfm_invalid_date.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  gv_time_by_value = sy-uzeit.

  WRITE: / `Start time:`.
  WRITE: / gv_time_by_value.

  WRITE: / `Do nothing:`.

  gv_time_by_value = lcl_time_utility=>do_nothing( ).

  WRITE: / `Pass by value:`.
  WRITE: / gv_time_by_value.

  WRITE: / `Method call successful:`.

  CLEAR gv_time_by_value.

  gv_time_by_value = lcl_time_utility=>get_time_120000_successfully( ).

  WRITE: / `Pass by value:`.
  WRITE: / gv_time_by_value.

  WRITE: / `Method call unsuccessful:`.

  CLEAR gv_time_by_value.

  TRY.
      gv_time_by_value = lcl_time_utility=>get_time_120000_with_exception( ).
    CATCH cx_abap_datfm_invalid_date.
      " do nothing
  ENDTRY.

  WRITE: / `Pass by value:`.
  WRITE: / gv_time_by_value.
```

The report generates the following output to the screen:

```output
Start time:
145858
Do nothing:
Pass by value:
000000
Method call successful:
Pass by value:
120000
Method call unsuccessful:
Pass by value:
000000
```

## The escape character !

The escape character `!` can be used in the method signature to distinguish a parameter name from an ABAP word with the same name. The escape character itself isn't part of the name. Example:

```abap
REPORT zre_test_escape.

DATA gv_time TYPE t.

CLASS lcl_time_utility DEFINITION FINAL.

  PUBLIC SECTION.
    CLASS-METHODS display_time
      IMPORTING
        !importing TYPE t.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS lcl_time_utility IMPLEMENTATION.

  METHOD display_time.
    WRITE: / `Pass by reference (implicit):`.
    WRITE: / importing.

    WAIT UP TO 2 SECONDS.
    gv_time = sy-uzeit.

    WRITE: / `Pass by reference (implicit) after 2 seconds wait:`.
    WRITE: / importing.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  gv_time = sy-uzeit.
  lcl_time_utility=>display_time( gv_time ).
```

The report generates the following output to the screen:

```output
Pass by reference (implicit):
154728
Pass by reference (implicit) after 2 seconds wait:
154730
```

I can't think of any example where I've felt the need to use the escape character, and it is probably a good idea to avoid it whenever possible.

## Further reading

There have been some interesting discussions on pass by value and pass by reference in the following issues of the GitHub repository for SAP's ABAP Styleguide:

- [Issue #150: Prefer EXPORTING parameters passed by value?](https://github.com/SAP/styleguides/issues/150)
- [Issue #33: Passing value type importing parameters](https://github.com/SAP/styleguides/issues/33)

I also recommend the [ABAP Keyword Documentation](https://help.sap.com/doc/abapdocu_753_index_htm/7.53/en-US/index.htm?file=abapcall_method_parameters.htm).

Happy coding!

_If you would like to comment on this post, please head over to [SAP Community](https://blogs.sap.com/2021/02/18/pass-by-value-or-pass-by-reference/)._
