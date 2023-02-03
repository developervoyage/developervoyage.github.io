---
layout: post
title: What are pragmas and pseudo comments in ABAP?
date: 2019-09-03 16:23
author: Johan Wigert
tags: [ABAP, ABAP fundamentals]
permalink: /2019-09-03-what-are-pragmas-and-pseudo-comments-in-abap/
---
<!-- wp:paragraph -->
<p>When using the <a href="https://help.sap.com/viewer/ba879a6e2ea04d9bb94c7ccd7cdac446/7.5.5/en-US/62c41ad841554516bb06fb3620540e47.html">ABAP Test Cockpit</a> (ATC) for statically and dynamically checking the quality of your ABAP code and related repository objects, some of the warnings and errors identified by the ATC aren't relevant in your specific scenario. Leaving errors and warnings unaddressed might cause confusion at some future point-in-time when you or another developer needs to change the code. In order to reduce the confusion, ABAP pragmas and pseudo comments can be used to blend out irrelevant warnings and errors. Let us take a detailed look at what pseudo comments and pragmas are and how to use them.</p>
<!-- /wp:paragraph -->
<!--more-->
<!-- wp:heading -->
<h2>Pseudo Comments</h2>
<!-- /wp:heading -->

<!-- wp:quote -->
<blockquote class="wp-block-quote"><p>Pseudo comments are program directives that influence check and test procedures. Pseudo comments have mostly become obsolete and have been replaced by pragmas or real additions. </p><cite> <a href="https://help.sap.com/http.svc/rc/abapdocu_751_index_htm/7.51/en-US/index.htm?file=abenpseudo_comment.htm">ABAP Keyword Documentation</a></cite></blockquote>
<!-- /wp:quote -->

<!-- wp:paragraph -->
<p>Even though mostly obsolete, the pseudo comments are still relevant for some scenarios in the code inspector.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>A pseudo comment looks like this:</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><code>METHOD get_sources.
     SELECT source, textlong
       INTO TABLE @rt_source
       FROM tb006
       WHERE spras = @sy-langu. "#EC CI_SUBRC
   ENDMETHOD.</code></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The pseudo comment  <code>"#EC CI_SUBRC</code> is used to hide a message telling us that <code>sy-subrc</code> should be checked after a <code>SELECT</code> statement. In the example above the desired behavior is that an empty table should be returned if the <code>SELECT</code> statement is not successful, so there is no need to check the value of <code>sy-subrc</code>.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Sometimes a line of code generates several warnings or errors which you may want to hide. Using pseudo comments, it is only possible to specify one pseudo comment for each program line.  When multiple pseudo comments are required, the statement must be divided up to span multiple lines. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Note that the pseudo comment is placed after the ending dot of a statement.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>Pragmas</h2>
<!-- /wp:heading -->

<!-- wp:quote -->
<blockquote class="wp-block-quote"><p>Pragmas are program directives that can be used to hide warnings from various check tools.</p><cite><a href="https://help.sap.com/doc/abapdocu_751_index_htm/7.51/en-US/index.htm?file=abenpragma.htm">ABAP Keyword Documentation</a></cite></blockquote>
<!-- /wp:quote -->

<!-- wp:paragraph -->
<p>Pragmas can be used to hide warnings from the ABAP compiler syntax check as well as from the extended program check.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The use of a pragma looks like this:</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><code>MESSAGE e001(ad) INTO DATA(lv_message) ##NEEDED.</code></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The pragma <code>##NEEDED</code> tells the check tools that even though the variable <code>lv_message</code> isn't used for further processing, the variable is still needed. In this specific scenario, it is needed since we want to be able to perform a where-used search for the message <code>AD 001</code> from transaction SE91.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Not that a pragma is placed before the dot or comma ending the statement to which the pragma is applied. If multiple pragmas are needed for the same statement, they can be placed one after the other separated by space. It is also possible to place pragmas in front of a colon (:) of a chained statement. This applies the pragma to the whole chained statement:</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><code>DATA ##NEEDED:
   gt_messages TYPE bapiret2_t,
   gt_sel_data TYPE ty_sel_data_tt.</code></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Personally I think that this is hard to read, and I'd much rather use the following format:</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><code>DATA: gt_messages TYPE bapiret2_t ##NEEDED,
      gt_sel_data TYPE ty_sel_data_tt ##NEEDED.</code></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Some pragmas can be used with parameters. The example mentioned in the ABAP Keyword Documentation is <code>##SHADOW,</code> which can be used with an optional parameter. It looks like this: <code>##SHADOW[LOG] </code></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>I've never come across this in practice, so I don't have much experience to share. Feel free to give some input on this by writing a comment on the blog post.</p>
<!-- /wp:paragraph -->

<!-- wp:heading -->
<h2>The mapping between obsolete pseudo comments and pragmas</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>As already mentioned, most pseudo comments are obsolete and have been replaced by pragmas. SAP provides a program which can be run to find the mapping between obsolete pseudo comments and pragmas. The name of the program is <code>ABAP_SLIN_PRAGMAS</code>. The main table used by the program is <code>SLIN_DESC</code>, if you prefer looking up the pseudo comments and programs directly in a table viewer like SE16.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>As an example, the pseudo comment <code>"#EC AUTFLD_MIS</code> has been superseded by the pragma <code>##AUTH_FLD_MISSING</code>.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The tables <code>TRPRAGMA</code> and <code>TRPRAGMAT</code> contain all pragmas.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>I hope that this brief overview of pragmas and pseudo comments was useful. Please leave a comment if you think that I missed mentioning something crucial. Happy coding!</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><em>If you would like to comment on this post, please head over to <a href="https://blogs.sap.com/2019/09/11/what-are-pragmas-and-pseudo-comments-in-abap/">SAP Community</a>.</em></p>
<!-- /wp:paragraph -->