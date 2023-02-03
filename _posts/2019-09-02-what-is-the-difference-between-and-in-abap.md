---
layout: post
title: What is the difference between ` and ' in ABAP?
date: 2019-09-02 08:39
author: Johan Wigert
tags: [ABAP, ABAP fundamentals]
permalink: /2019-09-02-what-is-the-difference-between-and-in-abap/
---
<!-- wp:paragraph -->
<p>When defining a variable containing a text of some sort in ABAP, which of the following options do you typically use?</p>
<!-- /wp:paragraph -->
<!--more-->
<!-- wp:preformatted -->
<pre class="wp-block-preformatted">" Option 1
DATA(my_text) = `my text`.

 " Option 2
DATA(my_text) = 'my text'. </pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>Are you aware of the differences between these two lines of code? Let us look into the details.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Character literals</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>What we are looking at are two different types of character literals. The <a href="https://help.sap.com/doc/abapdocu_751_index_htm/7.51/en-US/index.htm?file=abenuntyped_character_literals.htm">ABAP Keyword Documentation</a> provides us with the following explanation:</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>"Character literals can be either text field literals or text string literals. A text field literal is a character string enclosed in single quotation marks (<code>'</code>); a text string literal is a character string enclosed in single backquotes (<code>`</code>)."</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Revisiting our example, we can define the variables like this:</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">" Option 1
DATA(my_text_string_literal) = `my text`.

" Option 2
DATA(my_text_field_literal) = 'my text'.</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p><code>my_text_string_literal</code> has the actual type STRING and the technical type CString of length 7. <code>my_text_field_literal</code> has a generated actual type (e.g. %_T00006S00000000O0000000298) and the technical type C of length 7. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The text field literal can have a length between 1 and 255 characters, whereas a text string  literal can have a length between 0 and 255 characters.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>That the text field literal has a minimum length of 1 means that <code>''</code> (no space) has the same meaning as <code>' '</code> (a space character).</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>When to use which character literal?</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>The <a href="https://github.com/SAP/styleguides/blob/master/clean-abap/CleanABAP.md#use--to-define-literals">SAP Styleguide for clean ABAP</a> contains the following recommendation:</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>"Refrain from using <code>'</code>, as it adds a superfluous type conversion and confuses the reader whether he's dealing with a CHAR or STRING"</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The following is an example of a superfluous type conversion between CHAR (from the text field literal) and a STRING:</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">DATA example_string TYPE string.
example_string = 'QWERTY'.</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>Prefer the following assignment:</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">DATA example_string TYPE string.
example_string = `QWERTY`.</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>If however the data element of the variable has been defined as a CHAR, the text field literal should be used to avoid a type conversion:</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">DATA e_mail_address TYPE ad_smtpadr. " CHAR 241
e_mail_address = 'mail@test.com'.</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>I hope that this short post helped clarify the difference between <code>'</code> and <code>`</code>. Happy coding!</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><em>If you would like to comment on this post, please head over to <a href="https://blogs.sap.com/2019/09/03/what-is-the-difference-between-and-in-abap/">SAP Community</a>.</em></p>
<!-- /wp:paragraph -->