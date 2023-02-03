---
layout: post
title: Determine the current class and method names in ABAP
date: 2019-09-13 16:23
author: Johan Wigert
tags: [ABAP, ABAP fundamentals]
permalink: /2019-09-13-determine-the-current-class-and-method-names/
---
<!-- wp:paragraph -->
<p>In some situations, it can be useful to be able to determine the names of the current class and method dynamically instead of using hard-coded strings. I find this particularly useful for logging purposes. I have a helper class which writes to the system log when certain exceptions are triggered. As input to this helper class (or rather the method writing to the system log) I want to provide the names of the class and method where the exception was raised.</p>
<!-- /wp:paragraph -->
<!--more-->
<!-- wp:heading -->
<h2>Determining the name of the current class</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>SAP provides the class <code>CL_ABAP_CLASSDESCR</code> for determining some class attributes dynamically. To determine the name of the current class, the following code snippet can be used:</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><pre>DATA(lv_class_name) = cl_abap_classdescr=>get_class_name( me ).</pre></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><code>LV_CLASS_NAME</code> will contain the class name in the following format: <code>\CLASS=ZCL_MY_CLASS</code></p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Determining the name of the current method</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>The only approach I've found for determining the name of the current method is by using a function module to read the call stack. If you are aware of a better way of doing this, please leave a comment! The call stack approach looks like this:</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><pre>DATA lt_callstack TYPE abap_callstack.

CALL FUNCTION 'SYSTEM_CALLSTACK'
  EXPORTING
    max_level = 1
  IMPORTING
    callstack = lt_callstack.

DATA(lv_method_name) = lt_callstack[ 1 ]-blockname.</pre></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><code>LV_METHOD_NAME</code> will contain the method name in the following format: <code>MY_METHOD</code></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy coding!</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><em>If you would like to comment on this post, please head over to <a href="https://blogs.sap.com/2019/09/13/determine-the-current-class-and-method-names-in-abap/">SAP Community</a>.</em></p>
<!-- /wp:paragraph -->