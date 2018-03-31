---
layout: post
title: "An error must look like an error"
date: 2007-11-07 01:40:39 -0800
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.com/archive/2007/11/06/an-error-must-look-like-an-error.aspx"].aspx
author: 0
---
<!-- more -->
<p>Today, I had one of my development tasks come back to me because it failed QA.  I had been tasked with implementing a custom error page, and I did so.  I added all kinds of juicy information to the screen such as the highest version number of all binaries from the solution, the last database patch date, and browser information.  I made the screen very pretty and friendly so that it wasn't "scary" anymore.</p>  <p>Unfortunately, this failed our QA department's testing.  The problem was that the screen no longer looked like an error.  It was too pretty.  It was too friendly.  It made the user not think that something bad had actually occurred -- maybe the process even ended successfully for all they knew.</p>  <p>So here I am, altering my custom error page to look more intimidating, with big, red text and whatnot.  I guess I need to remember that an error must look like an error or else we'll have a problem.</p>

