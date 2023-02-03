---
layout: post
title: HTTP status codes in ABAP
date: 2019-11-16 15:10
author: Johan Wigert
tags: [ABAP, HTTP, OData]
permalink: /2019-11-16-http-status-codes-in-abap/
---
<!-- wp:paragraph -->
<p>I've been working a lot with OData and REST lately, outbound as well as inbound. Some of my code needs to handle HTTP status codes in different ways. Since I didn't want to hard-code the status codes in my code, I started looking around for standard classes and interfaces which could be of use to me. This blog post is a brief summary of what I found.</p>
<!-- /wp:paragraph -->
<!--more-->
<!-- wp:heading -->
<h2>Interface IF_HTTP_STATUS</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>The interface <code>IF_HTTP_STATUS</code> contains a list of status texts in the form of constants of data type <code>STRING</code>. Some examples are:</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">CONSTANTS reason_200 TYPE string VALUE 'OK' . "#EC NOTEXT
CONSTANTS reason_201 TYPE string VALUE 'Created' . "#EC NOTEXT</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>This interface is quite handy if you want to present the user with not only a status code but also the corresponding text.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Class CL_REST_STATUS_CODE </h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>The classes <code>CL_REST_STATUS_CODE</code> and <code>/IWCOR/CL_REST_STATUS_CODE</code> also contain constants. The two classes are identical in regard to the constants but have some minor differences in one of the methods.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The constants in these two classes contain the numerical HTTP status codes of data type <code>I</code>. Some examples are:</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">constants GC_SUCCESS_OK type I value 200 . "#EC NOTEXT
constants GC_SUCCESS_CREATED type I value 201 . "#EC NOTEXT</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>The classes have some useful static methods as well:</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>Method <code>GET_REASON_PHRASE</code>: Takes in a status code and returns the corresponding status text. The method actually uses interface <code>IF_HTTP_STATUS</code> to accomplish this. </li><li>Method <code>IS_CLIENT_ERROR</code>: Takes in a status code and returns <code>abap_true</code> if the status code is in the range 400 - 499. Otherwise, the method returns <code>abap_false</code>.</li><li>Method <code>IS_REDIRECTION</code>: Takes in a status code and returns <code>abap_true</code> if the status code is in the range 300 - 399. Otherwise, the method returns <code>abap_false</code>.</li><li>Method <code>IS_SUCCESS</code>: Takes in a status code and returns <code>abap_true</code> if the status code is in the range 200 - 299. Otherwise, the method returns <code>abap_false</code>.</li><li>Method <code>IS_SERVER_ERROR</code>: Takes in a status code and returns <code>abap_true</code> if the status code is in the range 500 - 599. Otherwise, the method returns <code>abap_false</code>.</li><li>Method <code>IS_ERROR</code>: If one of the methods <code>IS_CLIENT_ERROR</code> and <code>IS_SERVER_ERROR</code> return <code>abap_true</code>, this method also returns <code>abap_true</code>. Otherwise, the method returns <code>abap_false</code>.</li></ul>
<!-- /wp:list -->

<!-- wp:heading -->
<h2>Limitations</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>The interface and the two classes mentioned in this blog post don't contain constants for every HTTP status code mentioned in the <a href="https://en.wikipedia.org/wiki/List_of_HTTP_status_codes">Wikipedia article</a>. However the most common ones are available, and for the use cases I've experienced so far the interface and the classes have been sufficient.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy coding!</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><em>If you would like to comment on this post, please head over to <a href="https://blogs.sap.com/2019/11/16/http-status-codes-in-abap/">SAP Community</a>.</em></p>
<!-- /wp:paragraph -->