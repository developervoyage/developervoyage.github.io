---
layout: post
title: Converting UUID between hyphened representation and RAW16
date: 2020-04-20 07:00
author: Johan Wigert
tags: [ABAP, OData]
permalink: /2020-04-20-converting-uuid-between-hyphened-representation-and-raw16/
---

If you've been testing OData services for example with Postman lately, you've most likely come across the scenario where you need to convert a [UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier) (Universal Unique Identifier) between hyphened representation and RAW16. I've previously done this manually, but today I decided to find a class that could help me with this.
<!--more-->

## Example

Let's assume that we want to test an OData service where one of the properties is the business partner GUID (Edm Core Type = Edm.Guid). The OData service expects this property to be supplied in hyphened representation (e.g. `0050569a-1453-1ed5-b9cb-7e54178c13f0`). In the SAP business partner table, the business partner GUID is however stored in RAW16 format (e.g. `0050569A14531ED5B9CB7E54178C13F0`).

It is trivial to manually convert between hyphened representation and RAW16, but I find this to be a bit tedious.

## Solution

After some searching, I eventually came across the class `CL_SOAP_WSRMB_HELPER` which can assist us when doing the conversion.

### From hyphened representation into RAW16

The following unit test illustrates how the conversion from hyphened representation into RAW16 can be done:

```abap
" Convert UUID from hyphened representation into RAW16
" given
CONSTANTS uuid_raw_exp TYPE sysuuid_x VALUE '0050569A14531ED5B9CB7E54178C13F0'.
CONSTANTS uuid_hyphened TYPE string VALUE '0050569a-1453-1ed5-b9cb-7e54178c13f0'.

" when
DATA(uuid_raw_act) = cl_soap_wsrmb_helper=>convert_uuid_hyphened_to_raw( uuid_hyphened ).

" then
cl_abap_unit_assert=>assert_equals( act = uuid_raw_act
                                    exp = uuid_raw_exp ).
```

### From RAW16 into hyphened representation

The following unit test illustrates how the conversion from RAW16 into hyphened representation can be done:

```abap
" Convert UUID from RAW16 into hyphened representation
" given
CONSTANTS uuid_hyphened_exp TYPE string VALUE '0050569a-1453-1ed5-b9cb-7e54178c13f0'.
CONSTANTS uuid_raw TYPE sysuuid_x VALUE '0050569A14531ED5B9CB7E54178C13F0'.

" when
DATA(uuid_hyphened_act) = cl_soap_wsrmb_helper=>convert_uuid_raw_to_hyphened( uuid_raw ).

" then
cl_abap_unit_assert=>assert_equals( act = uuid_hyphened_act
                                    exp = uuid_hyphened_exp ).
```

Happy converting!

_If you would like to comment on this post, please head over to [SAP Community](https://blogs.sap.com/2020/04/20/converting-uuid-between-hyphened-representation-and-raw16/)._