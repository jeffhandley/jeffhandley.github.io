---
layout: post
title: "Visual Studio 2003 on Vista"
date: 2007-12-19 02:47:33 -0800
comments: true
tags: ["Visual Studio .NET 2003", "Vista"]
redirect_from: ["/archive/2007/12/18/visual-studio-2003-on-vista.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p>I'm just now getting around to installing Visual Studio .NET 2003 Enterprise Architect on my new Vista workstation at the office.  I haven't been worried about this too much, because I have this setup working at home without problem.</p>  <p>But of course, I ran into a snag here.  When I ran the setup, it highlighted the Pre-requisites task as the only available step.  Then when that opened up, I got this lovely message:</p>  <p><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="268" alt="Web Project Requirements: Front Page Server Extensions missing" src="/img/postimages/VisualStudio2003onVista_10841/xxl16BD.tmp.jpg" width="440" border="0" /> </p>  <p>I tried a few things to get past this, including installing the <a href="http://www.iis.net/downloads/default.aspx?tabid=34&amp;g=6&amp;i=1577" target="_blank">FrontPage 2002 Server Extensions for IIS 7 (RC1)</a>.  But I kept getting the same error.</p>  <p>All I needed to do was to run the Pre-requisites as a standalone installation instead of through the VS.NET installer.  After doing that, I can fire right into the VS.NET installation without any warnings or errors.  The installation hasn't finished yet though, so I'm keeping my fingers crossed.</p>
