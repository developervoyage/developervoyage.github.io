---
layout: post
title: Every OData call through API Management transformed into a GET call
date: 2021-01-15 15:25
author: Johan Wigert
tags: [OData, API management]
permalink: /2021-01-15-every-call-transformed-into-a-get-call/
---

I recently struggled with a confusing issue related to SCP API Management, SAP NetWeaver Gateway, and OData. The issue was that irrespective of the HTTP verb used when calling the API through API Management, the OData service interpreted the call as a `GET` call. In this blog post I'll provide some details on the issue as well as the solution implemented to remedy the issue.
<!--more-->

## The issue

I had created an OData service that supported the HTTP verbs `GET` and `PUT`. When calling the OData service directly, everything worked as expected. I then set the OData service up as an API in SCP API Management. When calling the API with the HTTP verb `GET`, everything worked as expected. When calling the API with the HTTP verb `PUT` however, the call was interpreted by the SAP backend as a `GET` call.

## Analyzing the issue

My first thought was that API Management must be doing something strange to the call. Maybe I had done some trivial mistake in a policy applied to the API? After examining the policies as well as debugging the call in API Management, I had to rule this possibility out. Everything looked perfectly fine in API Management.

The next suspect was the Cloud connector used to communicate between API Management and the SAP Gateway / backend server. I activated tracing in the Cloud connector, but the HTTP verb was correct according to the trace files.

I then decided to debug the request in the back-end SAP system. The first method call I was able to debug was `/IWFND/CL_SODATA_HTTP_HANDLER->IF_HTTP_EXTENSION~HANDLE_REQUEST`. Here the `request_method` (local variable `LV_HTTP_METHOD`) had the value `GET`.

Something strange happened to the call between the Cloud connector and the SAP backend, but what?

## The solution

After having discussed the issue with SAP development, the recommendation we got was to solve the issue by creating a SAML policy and assigning it to the service in transaction `SICF`.

### Creating the SAML policy

We ran transaction `SAML2` which opens the URL `https://servername/sap/bc/webdynpro/sap/saml2`.

When creating the policy, the key setting is `IdP-Initiated SSO`:

![saml2-policy-01](/assets/2021-01-15-every-call-transformed-into-a-get-call/saml2-policy-01.png)

The setting must be `Preserve original method`. Otherwise, every call gets transformed into a `GET` call.

### Using the SAML policy for the service

The SAML policy must be linked to the service in transaction `SICF`. This is done like this:

![saml2-policy-02](/assets/2021-01-15-every-call-transformed-into-a-get-call/saml2-policy-02.png)

## Conclusion

Even though the solution was very simple to implement, the issue cost us a lot of time. I hope that the post is useful to someone else facing the same issue.

_If you would like to comment on this post, please head over to [SAP Community](https://blogs.sap.com/2021/01/15/every-odata-call-through-api-management-transformed-into-a-get-call/)._
