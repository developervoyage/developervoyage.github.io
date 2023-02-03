---
layout: post
title: Using native SQL for case-insensitive search
date: 2021-02-12 21:00
author: Johan Wigert
tags: [ABAP]
permalink: /2021-02-12-using-native-sql-for-case-insensitive-search/
---

As I was developing an OData service related to contact persons in SAP CRM, I was faced with the scenario that the user wanted to search based on e-mail addresses of the contact persons. The e-mail addresses are stored in the database with a mixture of uppercase and lowercase letters. In this post, I'll explain how the requirement can be met by using native SQL.
<!--more-->

## Scenario

The e-mail addresses of the contact persons are stored in table `ADR6`. The field where the e-mail address is stored is `SMTP_ADDR`, which has a data element with a case-sensitive domain handling 241 characters. Since the field is case-sensitive, we have e-mail addresses with a mixture of uppercase and lowercase letters, e.g.:

- TestUser1@somedomain.com
- testUSER2@somedomain.com
- testuser3@SomeDomain.com

In order to search irrespective of the casing, we want the e-mail addresses to be uppercase only when performing the search.

## Search field SMTP_SRCH

There is a field `SMTP_SRCH` in table `ADR6` which is provided to simplify the search by storing the e-mail address uppercase. However, there is a serious limitation to this solution. The field is only 20 characters long. Since many e-mail addresses are longer than 20 characters, the field isn't very useful.

## Native SQL when selecting from the database table

With the help of native SQL we can transform `SMTP_ADDR` ot uppercase in the `SELECT` statement when selecting directly from the database table `ADR6`:

```abap
DATA user_email TYPE ad_smtpadr.

TRY.

    " Note that table and field names must be uppercase
    EXEC SQL.
      SELECT
          SMTP_ADDR
          INTO :user_email
          FROM ADR6
          WHERE CLIENT = :sy-mandt
            AND UPPER(SMTP_ADDR) = 'Q.W@R.S'
    ENDEXEC.

  CATCH cx_sy_native_sql_error INTO DATA(native_sql_excecption).
    DATA(error_text) = |{ native_sql_excecption->get_text( ) } SQL CODE: { native_sql_excecption->sqlcode } MSG: { native_sql_excecption->sqlmsg }|.
    MESSAGE error_text TYPE 'E'.
ENDTRY.
WRITE: / user_email.
```

So if the e-mail address in database table `ADR6` is lowercase `q.w@r.se`, the entry is still found.

## Native SQL when selecting from the DDL SQL View

Native SQL can also be used when selecting from the DDL SQL View of the CDS containing table `ADR6`:

```abap
DATA user_email TYPE ad_smtpadr.

TRY.

    " Using the DDL SQL View of the CDS works
    EXEC SQL.
      SELECT
          EMAIL
          INTO :user_email
          FROM ZCDSCPEMAIL
          WHERE MANDT = :sy-mandt
            AND UPPER(EMAIL) = 'Q.W@R.S'
    ENDEXEC.

  CATCH cx_sy_native_sql_error INTO DATA(native_sql_excecption).
    DATA(error_text) = |{ native_sql_excecption->get_text( ) } SQL CODE: { native_sql_excecption->sqlcode } MSG: { native_sql_excecption->sqlmsg }|.
    MESSAGE error_text TYPE 'E'.
ENDTRY.
WRITE: / user_email.
```

## Native SQL when selecting from the CDS

Native SQL can not be used when selecting from the CDS containing table `ADR6`:

```abap
DATA user_email TYPE ad_smtpadr.

TRY.

 " Using the CDS name does not work
    EXEC SQL.
      SELECT
          EMAIL
          INTO :user_email
          FROM ZCDS_CONTACT_EMAIL
          WHERE MANDT = :sy-mandt
            AND UPPER(EMAIL) = 'Q.W@R.S'
    ENDEXEC.

  CATCH cx_sy_native_sql_error INTO DATA(native_sql_excecption).
    DATA(error_text) = |{ native_sql_excecption->get_text( ) } SQL CODE: { native_sql_excecption->sqlcode } MSG: { native_sql_excecption->sqlmsg }|.
    MESSAGE error_text TYPE 'E'.
ENDTRY.
WRITE: / user_email.
```

The code above results in the following error: `You tried to work with the name of a table or view that does not exist in the database SQL CODE: 208 MSG: Invalid object name 'ZCDS_CONTACT_EMAIL'.`

## Conclusion

Even though it would have been possible to meet the requirement by using native SQL, we decided to implement the solution outlined in Note [1664239](https://launchpad.support.sap.com/#/notes/1664239) instead. We opted for this solution since it is more general, and we avoid the dependency to a specific database implied by native SQL. I still think it was educational to explore the native SQL route.

_If you would like to comment on this post, please head over to [SAP Community](https://blogs.sap.com/2021/02/12/using-native-sql-for-case-insensitive-search/)_
