---
layout: post
title: "Tweaking Registry for Taskbar in Vista"
date: 2007-12-19 19:27:37 -0800
comments: true
category: Archive
tags: ["Vista", "Taskbar"]
redirect_from: ["/archive/2007/12/19/tweaking-registry-for-taskbar-in-vista.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p><a href="http://jalaj.net/2007/11/28/tweaking-registry-for-task-bar-in-vista/" target="_blank">This post</a> is proving useful.  It didn't solve my root annoyance, but it did help.  Here's what I wanted to beat...</p>  <p>I like using Toolbars as quick menus on the task bar.  You can set them up like this:    <br /><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="77" alt="Taskbar - Unlocked" src="http://blog.jeffhandley.com/Images/PostImages/TweakingRegistryforTaskbarinVista_A121/image.png" width="429" border="0" />  <br />But when you turn on "<a href="http://botenanna.vox.com/library/audio/6a00cdf7e7bdd5094f00cdf3a2edd9cb8f.html" target="_blank">Lock the Taskbar</a>" things get repositioned and it looks like this:     <br /><a href="http://blog.jeffhandley.com/Images/PostImages/TweakingRegistryforTaskbarinVista_A121/image_3.png"><img style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" height="77" alt="Taskbar - Locked" src="http://blog.jeffhandley.com/Images/PostImages/TweakingRegistryforTaskbarinVista_A121/image_thumb.png" width="429" border="0" /></a> </p>  <p>From what I understand, the configuration of the taskbar toolbars is stored in binary in the registry.  I haven't yet found a way to manipulate it to get rid of the little gaps created in this scenario.</p>  <p>So, I am leaving "Lock the Taskbar" turned off, but I'm using the TaskbarNoDragToolbar registry setting to prevent the toolbars from actually being moved.</p>  <p><em>Follow-up… Someone commented with an even better solution below.  <a href="http://blog.jeffhandley.com/archive/2007/12/19/35.aspx#271">Click here</a> to scroll to the comment.</em></p>
