---
layout: post
title: Wrong user used in backend when calling OData service through API Management with SAML2 token
date: 2021-01-22 08:30
author: Johan Wigert
tags: [OData, API management]
permalink: /2021-01-22-wrong-user-used-in-backend-when-calling-odata-service-through-api-management-with-saml2-token/
---

I have developed an OData service that returns different results depending on which user is calling the service. I noticed that users often didn't get the expected results, but rather the results of another user using the application at the same time. In this blog post I'll describe the issue and the solution I found.
<!--more-->

## Scenario

The OData service is consumed by a .NET microservice through SCP API Management. The API in API Management uses policies to create SAML2 tokens. A part of the token content is the business partner GUID of the employee related to the user. The OData service returns data that is dependent on the user calling the service. The users often didn't get the expected results, but rather the results of another user using the application at the same time.

## Analysis

The first step of the analysis of the issue was to rule out that the consuming .NET microservice was caching the results instead of making new calls to API Management. This could be ruled out by analyzing the logs in Application Insights.

The next step was to make sure that the API in API Management didn't cache the response data or the SAML2 token. I could confirm that no caching took place and that API Management created the token correctly with the expected business partner GUID by using the debug functionality in the API Portal.

I set up SAP Gateway traces for several users in transaction `/IWFND/TRACES` in the backend ABAP system to see which OData calls were made by which user. I could see that the OData calls often were performed by another user than expected.

I went back to analyzing the request received by API Management through the debugger in the API portal, and I could see that the same cookie was used by the .NET microservice for different users. A part of the cookie is `SAP_SESSIONID_<SID>_<CLIENT>=3cPL...`. This is the root cause of the issue, since a session from another user is accidentally used.

## Solution

To verify that I had found the root cause, I added a policy to the API to remove the cookie. This was done through a _Mediation Policy_ of type _Assign Message_:

```html
<!-- This policy can be used to create or modify the standard HTTP request and response messages -->
<AssignMessage async="false" continueOnError="false" enabled="true" xmlns='http://www.sap.com/apimgmt'>
	<Remove>
	 <Headers>
            <Header name="Cookie"/>
        </Headers>
	</Remove>
	<IgnoreUnresolvedVariables>false</IgnoreUnresolvedVariables>
	<AssignTo createNew="false" type="request"/>
</AssignMessage>
```

With this policy in place, the issue didn't occur anymore. I have now turned the results of my analysis over to the .NET team for a solution on the consumer side.

_If you would like to comment on this post, please head over to [SAP Community](https://blogs.sap.com/2021/01/22/wrong-user-used-in-backend-when-calling-odata-service-through-api-management-with-saml2-token/)._
