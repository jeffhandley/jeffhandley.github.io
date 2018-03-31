---
layout: post
title: "Using NANTRunner in VS 2003 on Vista 64-bit"
date: 2008-02-05 22:26:47 -0800
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.com/archive/2008/02/05/using-nantrunner-in-vs-2003-on-vista-64-bit.aspx"]
author: 0
---
<!-- more -->
<p>I am actually doing a little coding today, woot!  Except, I haven't gotten <a href="http://nantrunner.sourceforge.net/" target="_blank">NANTRunner</a> to run on my Vista 64-bit workstation yet.  I need to use this in order to correctly build the solution.</p>  <p>Running <em>any</em> build target from NANTRunner (even an empty one) was yielding this result:</p>  <p> <a href="http://blog.jeffhandley.com/Images/PostImages/UsingNANTRunnerinVS2003onVista64bit_CB1D/image.png"><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="288" alt="Win32Exception: The system cannot find the path specified" src="http://blog.jeffhandley.com/Images/PostImages/UsingNANTRunnerinVS2003onVista64bit_CB1D/image_thumb.png" width="461" border="0" /></a> </p>  <p>By using an empty target in the build file, I ruled out problems with the build script, or accessing files that were part of the build.  So this means that VS or NANTRunner is missing something.</p>  <p>I grabbed a copy of the handy-dandy <a href="http://technet.microsoft.com/en-us/sysinternals/bb896645.aspx" target="_blank">Process Monitor</a> from <a href="http://www.sysinternals.com/" target="_blank">SysInternals</a> and applied some filters.  Here's what I narrowed it down to, although it didn't seem suspect to me at first:</p>  <p><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="82" alt="vcspawn.exe Path Not Found" src="http://blog.jeffhandley.com/Images/PostImages/UsingNANTRunnerinVS2003onVista64bit_CB1D/image_3.png" width="641" border="0" /> </p>  <p>I searched the registry and it doesn't look like the path to this file or folder is defined in there, meaning something is hard-coded to this path.  I went to find this file, and found the problem: VS.NET 2003 is not installed under "C:\Program Files".  It's installed under "C:\Program Files (x86)".</p>

