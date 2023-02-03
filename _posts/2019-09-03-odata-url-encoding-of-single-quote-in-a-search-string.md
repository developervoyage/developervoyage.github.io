---
layout: post
title: OData URL encoding of single quote ' (%27) in a search string
date: 2019-09-03 16:32
author: Johan Wigert
tags: [OData, URL encoding]
permalink: /2019-09-03-odata-url-encoding-of-single-quote-in-a-search-string/
---
<!-- wp:paragraph -->
<p>When developing an OData service for searching for contact persons by name, I came across a scenario where the name contains the special character ' (single quote character). As an example, the user would like to search for contact persons with the last name O'Reilly.</p>
<!-- /wp:paragraph -->
<!--more-->
<!-- wp:paragraph -->
<p> The URL encoding of the single quote character is <code>%27</code>.  First I just tried the following:<br><code>https://servername/sap/opu/odata/SAP/Z_CONTACT_PERSON_SRV/ContactSet?$format=json&amp;$filter=substringof(%27O%27Reilly%27,%20SearchText)</code></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>This lead to an error with HTTP status code 400 and the message "Invalid token detected at position &amp;" with exception /IWCOR/CX_DS_EXPR_SYNTAX_ERROR. </p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>As you might already have guessed, the issue is that <code>%27</code> is used to enclose the search string. When adding a single <code>%27</code> within the search string, the parser of the <code>$filter</code> expression gets confused.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The solution is to escape the single quote by adding a single quote before it:<br><code>https://servername/sap/opu/odata/SAP/Z_CONTACT_PERSON_SRV/ContactSet?$format=json&amp;$filter=substringof(%27O%27%27Reilly%27,%20SearchText)</code></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><em>If you would like to comment on this post, please head over to <a href="https://blogs.sap.com/2019/09/03/odata-url-encoding-of-single-quote-%27-in-a-search-string/">SAP Community</a>.</em></p>
<!-- /wp:paragraph -->