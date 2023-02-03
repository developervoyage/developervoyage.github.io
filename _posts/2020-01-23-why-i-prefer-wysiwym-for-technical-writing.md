---
layout: post
title: Why I prefer WYSIWYM for technical writing
author: Johan Wigert
tags: [Writing, LaTeX, Jekyll, Markdown, WYSIWYM]
permalink: /2020-01-23-why-i-prefer-wysiwym-for-technical-writing/
---

Last month I switched my [blog](https://www.developervoyage.com) from [WordPress](https://wordpress.org) over to [Jekyll](https://jekyllrb.com). Jekyll is a static site generator, which transforms plain text files into a static website. I've also started writing a book using [LaTeX](https://www.latex-project.org), which is a document preparation system also using plain text. In this blog post, I'll explain why I think the What You See Is What You Mean ([WYSIWYM]((https://en.wikipedia.org/wiki/WYSIWYM))) approach is preferable for technical writing, at least for me.
<!--more-->

## What is WYSIWYM?

According to [Wikipedia](https://en.wikipedia.org/wiki/WYSIWYM), WYSIWYM is:

> a paradigm for editing a structured document. It is an adjunct to the better-known [WYSIWYG](https://en.wikipedia.org/wiki/WYSIWYG) (What You See Is What You Get) paradigm, which displays the end result of a formatted document as it will appear on screen or in print — without showing the descriptive code underneath.

The Wikipedia article continues:

> In a WYSIWYM editor, the user writes the contents in a structured way, marking the content according to its meaning, its significance in the document, and leaves its final appearance up to one or more separate style sheets. In essence, it aims to accurately display the contents being conveyed, rather than the actual formatting associated with it.

Now that we've covered the basics, let us look at two examples I've recent experience with.

## The WordPress visual editor approach vs Markdown files and Jekyll

When I started this blog about half a year ago, I opted for WordPress mainly due to its easy setup procedure and wide adoption. It felt like a safe bet. The writing experience hasn't been all that great though. Some of the writing-related pain-points which lead me to switch from WordPress to a static site generator were:

* Formatting of source code: Since my blog is focused on my journey as a developer, I often write technical blog posts containing code samples. Formatting the source code has been a major headache, and I've tried several different WordPress plugins and approaches without finding a good solution.
* Image handling: Scaling of images and manual adjustments of the theme I've used for WordPress were necessary, but I still felt a lack of control of the layout of the images. I ended up installing and trying out several plugins without finding a fully satisfactory solution.
* Visual editor vs raw editor: WordPress has a visual editor as well as a raw HTML editor. I've often encountered issues when switching between the visual editor and the raw editor, were formatting issues difficult to resolve have occurred.

Being active on [GitHub](https://github.com/jwigert), I've lately often found myself editing [Markdown](https://en.wikipedia.org/wiki/Markdown) files. I also use Markdown a lot in my day-job when writing technical documentation in [Azure DevOps](https://dev.azure.com). According to Wikipedia:

> Markdown is a lightweight markup language with plain text formatting syntax. Its design allows it to be converted to many output formats

I find Markdown much easier to write in than HTML. This motivated me to look into Jekyll, which is a static site generator originally developed by GitHub's co-founder Tom Preston-Werner. It is the engine used for [GitHub Pages](https://pages.github.com). I write my blog posts in Markdown, and let Jekyll take care of the rest. It has made my workflow of writing blog posts much more pleasant, and all the paint-points mentioned above have been resolved.

Some other advantages I've experienced as a side-effect of the switch to Jekyll are:

* Reduction in attacks on my site: When using WordPress to run my blog, the site was attacked daily. A static site is much less interesting to hackers, and the number of attacks has gone down.
* Editor: With Jekyll I write all my posts in my favorite code editor [Visual Studio Code](https://code.visualstudio.com). There are a lot of useful extensions for grammar checks, spell checks and Markdown handling which makes my life a lot easier.
* Offline writing: Using WordPress, I wrote my blog posts directly on the server which made me dependent on an internet connection. I know that there are workarounds available to work offline with WordPress as well, but with Jekyll and Markdown I have a true "offline first" experience.

## Microsoft Word / LibreOffice Writer vs LaTeX

I hardly use Microsoft Word or similar programs like LibreOffice Writer these days. From my days as a university student, I remember a lot of frustration related to formatting issues, generation of table of contents, page numbering etc. I recently started writing a book, and I decided to look around for alternatives to the regular word processing programs. I started looking at using Markdown for my book project as well, but I wanted more control than I felt Markdown would be able to provide me with for such an ambitious undertaking as writing a book.

I decided to give [LaTeX](https://www.latex-project.org) a try. LaTeX is a document preparation system also using plain text. Writing in LaTeX, the writer uses markup tags to structure the document and apply styles to the text. A large part of the academic world uses LaTeX, and it is excellent at handling functionality related to cross-references and citations. LaTeX makes it easy to generate table of contents, importing program source files and having them formatted correctly for many different programming languages, generating a title page, and handling appendixes among other things. It takes a little bit of getting used to, but after a day or two, I was convinced that this was the ideal solution for me.

## Summary

The previously cited [Wikipedia article](https://en.wikipedia.org/wiki/WYSIWYM) gives the following summary of the advantages of using WYSIWYM:

> The main advantage of this system is the total separation of presentation and content: users can structure and write the document once, rather than repeatedly alternating between the two modes of presentation — an approach which comes with its own switch cost. And since the rendering of formatting is left to the export system, this also makes it easier to achieve consistency in design as well.

For me, the major difference between working in a WYSIWYM environment compared to a WYSIWYG environment is the sense of control. It just feels a lot more like the level of control I have when writing code. It seems to fit my software engineering mindset well. I hope that this post can inspire you to look into WYSIWYM environments, in case you aren't already using them as well.

Happy writing and happy coding!

_If you would like to comment on this post, please head over to [dev.to](https://dev.to/jwigert/why-i-prefer-wysiwym-for-technical-writing-3a7o)._