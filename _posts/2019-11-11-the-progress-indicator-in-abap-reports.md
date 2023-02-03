---
layout: post
title: The progress indicator in ABAP reports
date: 2019-11-11 17:47
author: Johan Wigert
tags: [ABAP, ABAP fundamentals]
permalink: /2019-11-11-the-progress-indicator-in-abap-reports/
---
<!-- wp:paragraph -->
<p>I'm sure most of you have been asked to develop a report displaying a progress indicator during the execution of the report. I just developed a migration report which needs several minutes to execute, so I decided to put in a progress indicator.</p>
<!-- /wp:paragraph -->
<!--more-->
<!-- wp:paragraph -->
<p>When running the ATC check with <a href="https://github.com/larshp/abapOpenChecks">abapOpenChecks</a> for the report I've developed, I got an error telling me that function module <code>SAPGUI_PROGRESS_INDICATOR</code> should not be used. Even though this is documented in the documentation of <a href="https://docs.abapopenchecks.org/checks/53/">check 53</a> for abapOpenChecks, an SAP Knowledge Base Search for information on what should be used instead of function module <code>SAPGUI_PROGRESS_INDICATOR</code> didn't give me any results. The documentation at abapOpenChecks states that class <code>CL_PROGRESS_INDICATOR</code> should be used instead of the function module. I decided to write this short blog post to share this information with the community as well as to provide a tiny code example.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Instead of using the function module like this:</p>
<!-- /wp:paragraph -->

<!-- wp:html -->
<p><pre>
CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
  EXPORTING
    percentage = progress_percent
    text       = progress_text.
</pre></p>
<!-- /wp:html -->

<!-- wp:paragraph -->
<p>You can use the class like this:</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><pre>
cl_progress_indicator=>progress_indicate(
    i_text = |Processing: { current_record }/{ total_records }|
    i_output_immediately = abap_true ).
</pre></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>The result isn't exactly the same since the function module only works with percentages. This could easily be achieved with the class as well, but in this case, I was more interested in seeing how many of the total records had been processed.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Happy coding!</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><em>If you would like to comment on this post, please head over to <a href="https://blogs.sap.com/2019/11/11/the-progress-indicator-in-abap-reports/">SAP Community</a>.</em></p>
<!-- /wp:paragraph -->