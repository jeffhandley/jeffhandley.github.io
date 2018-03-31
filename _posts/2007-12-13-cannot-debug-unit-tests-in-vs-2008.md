---
layout: post
title: "Cannot Debug Unit Tests in VS 2008"
date: 2007-12-13 06:37:45 -0800
comments: true
category: Archive
tags: []
redirect_from: ["/archive/2007/12/12/cannot-debug-unit-tests-in-vs-2008.aspx/"]
author: 0
---
<!-- more -->
<p>I downloaded and installed VS 2008 Professional.  The first thing I wanted to play with was the <a href="http://weblogs.asp.net/scottgu/archive/2007/03/13/new-orcas-language-feature-extension-methods.aspx" target="_blank">Extension Methods</a> stuff.  Like a <a href="http://en.wikipedia.org/wiki/Test-driven_development" target="_blank">good little boy</a>, I stubbed out a method and then created a unit test.</p>  <p>The unit test failed, as expected.  Then I put the actual code into the extension method, and ran the test again.  The test still failed.  I looked through the code and everything seemed right to me, so I put a breakpoint into the unit test and tried to debug it.  But my breakpoint did not get hit; I get the message, "No symbols have been loaded for this document."</p>  <p>I've tried deleting the DLLs manually, rebuilding the solution, restarting VS 2008, rebooting, and every combination I can think of.  I cannot find a way to get it to load symbols for my unit test and hit my breakpoint.</p>  <p><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="212" alt="No symbols have been loaded for this document" src="http://blog.jeffhandley.com/Images/PostImages/CannotDebugUnitTestsinVS2008_13E0D/image.png" width="504" border="0" /></p>  <div class="wlWriterSmartContent" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:0134b028-62da-4f21-bb0e-97ff01a0c31c" style="padding-right: 0px; display: inline; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px">Technorati Tags: <a href="http://technorati.com/tags/TDD" rel="tag">TDD</a>,<a href="http://technorati.com/tags/Visual%20Studio%202008" rel="tag">Visual Studio 2008</a></div>

