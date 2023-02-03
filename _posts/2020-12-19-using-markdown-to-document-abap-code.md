---
layout: post
title: Using Markdown to document ABAP code
date: 2020-12-19 20:00
author: Johan Wigert
tags: [ABAP, Documentation]
permalink: /2020-12-19-using-markdown-to-document-abap-code/
---

Having worked in IT for about 17 years, mostly as a consultant, I've yet to see a company where the technical documentation is up-to-date and reliable. I think that a major reason for the documentation not being up-to-date is that documentation is maintained far away from the source code, for example in a plethora of Word documents stored in a separate Solution Manager system. In this post, I'll explain how Markdown files being handled in a Git repository can bring the documentation much closer to the ABAP source code.
<!--more-->

## Markdown

In practically every SAP project I've worked on, Word has been the go-to document format. Being active on [GitHub](https://github.com/jwigert), I've lately often found myself editing [Markdown](https://en.wikipedia.org/wiki/Markdown) files. I find Markdown much easier and quicker to write in. Searching through a large number of Markdown files in a Git repository is also far easier than trying to scan through a large number of Word documents stored in a document management system. Why wouldn't we be able to use Markdown to document ABAP development?

## Tools

We use [Azure DevOps](https://dev.azure.com) together with [abapGit](https://github.com/abapGit/abapGit) to version control our ABAP code. We decided to use the same tools to manage our technical documentation in Markdown format. My go-to editor for Markdown files is [Visual Studio Code](https://code.visualstudio.com/) with a couple of Markdown-related extensions.

## Work process

My work process typically looks like this when doing development and writing documentation:

1. Do the development in the ABAP system.
2. Use abapGit to create a new branch in the repository hosted on Azure DevOps by using the _Transport to branch_ functionality of abapGit.
3. Pull the branch to my local PC.
4. Add the Markdown file to the branch in Azure DevOps by pushing through command-line Git.
5. Create the pull request in Azure DevOps.
6. The code change as well as the documentation is reviewed by a colleague simultaneously.
7. Feedback from the code review might lead to pushing new changes in the code as well as in the documentation to the repository.
8. The pull request eventually gets merged and the code, as well as the documentation, is updated in the master branch.

## Level of documentation

Typically we create one Markdown file per package and name the files in accordance with the packages they document. As an example, when creating a Markdown file documenting a package related to activities named `ZACTIVITY`,
the Markdown file should be put in the package folder (e.g. `src/zactivity/`) and should be named `zactivity.md`. Note that it is important that the filename is lower-case since abapGit otherwise will throw the error described in the following [issue](https://github.com/abapGit/abapGit/issues/3073) for example when adding the file to the ignore tag in file `.abapgit.xml`.

In general, the code should be self-explanatory, and not require extensive documentation through comments or Markdown files. The Markdown documentation should give another developer not familiar with the package an overview of the package, for example describing in which process the code is used and what problem it solves. We typically try to document important design decisions that were made when writing the code as well as highlight design patterns used. If there are dependencies to other packages these are also described. We try to keep the documentation brief and view it as something that should point the reader in the right direction, rather than explain every implementation detail extensively. To help the developers write consistent documentation we've created a Markdown template with headlines and hints of what might be relevant to include in the documentation.

## Searching the documentation

Structurally the documentation is easy to find since it is maintained in close proximity to the code. In Azure DevOps it is also convenient to search through the whole repository or across several repositories. The search can be limited to only include Markdown files by using the criteria `ext:md` in the search box.

## Conclusion

I think that using Markdown files in combination with a Git-managed repository gives excellent results in keeping the documentation alive. The documentation lives very close to the code and is easy to find, maintain, and review.

Happy documenting!

_If you would like to comment on this post, please head over to [SAP Community](https://blogs.sap.com/2020/12/19/using-markdown-to-document-abap-code/)._
