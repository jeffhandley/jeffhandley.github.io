---
layout: post
title: "No wonder it didn't work"
date: 2008-01-05 05:28:19 -0800
comments: true
tags: []
redirect_from: ["/archive/2008/01/04/no-wonder-it-didnt-work.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p>I am testing a change that I'm making for the school project.  This is a mission-critical change as it pertains to Ohio state reporting.  I executed the stored procedure that is being changed and looked at the results, and they appeared to be incorrect.</p>  <p>I undid all of my changes and ran the procedure again.  Sure enough, the new version is missing some data that should still be coming out.  I re-applied my changes using the redo command in VS.NET.  The fact that there were 666 actions made as part of the change is a bad sign, and I think that's why it didn't work.</p>  <p><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="235" alt="Redo 666 Actions" src="http://blog.jeffhandley.com/Images/PostImages/Nowonderitdidntwork_12DE2/image.png" width="491" border="0" /></p>

