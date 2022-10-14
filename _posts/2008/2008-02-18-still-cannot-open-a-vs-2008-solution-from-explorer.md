---
layout: post
title: "Still cannot open a VS 2008 solution from explorer"
date: 2008-02-18 06:32:33 -0800
comments: true
tags: ["Visual Studio", "VS 2008"]
redirect_from: ["/archive/2008/02/17/still-cannot-open-a-vs-2008-solution-from-explorer.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p><img height="108" alt="System.Runtime.InteropServices.COMException" src="/img/postimages/StillcannotopenaVS2008solutionfromexplor_13CF7/image.png" width="240" align="right" />Well, I jumped the gun.  I saw the <a href="http://blogs.msdn.com/andrewarnottms/archive/2008/02/13/why-double-clicking-on-an-sln-file-doesn-t-always-launch-visual-studio.aspx" target="_blank">post</a> that was referenced during <a href="http://www.hanselman.com/blog/ThisWeekOnChannel9Feb15.aspx" target="_blank">This Week on Channel 9</a> and I <a href="http://blog.jeffhandley.com/archive/2008/02/15/open-a-vs-2008-solution-from-explorer.aspx" target="_blank">thought</a> it would solve my problems.  It did not.  I still cannot open a VS 2008 solution from explorer.</p>  <p>My issue does seem to be that I have the UAC turned on.  In order for VS 2008 to open cleanly, I have to run it as Administrator.  If I don't, I get this message when I try to open a web project.</p>  <p>This means that I must always run VS 2008 as Administrator.  I've updated the shortcut's compatibility settings so that I don't have to explicitly choose to run as admin though, because that got old very quickly.</p>  <p><img height="53" alt="Shortcut Compatibility - Run this program as an administrator" src="/img/postimages/StillcannotopenaVS2008solutionfromexplor_13CF7/image_3.png" width="240" align="right" />When I double-click on a solution file that should open in VS 2008, I get nothing.  Even after checking my solution files per Andrew Arnott's post.  My solution files were just fine.  If I run explorer as Administrator, and then double-click on the solution files, they open just fine.  So permissions are my issue.  I might just set my .sln file type to always open in VS 2008.  When at home (where I have this problem), I'm typically working in 2008.  If I need to open a pre-2008 solution, I can start up devenv first.</p>
