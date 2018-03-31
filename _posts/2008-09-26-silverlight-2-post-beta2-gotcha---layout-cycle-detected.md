---
layout: post
title: "Silverlight 2 Post Beta2 Gotcha - Layout Cycle Detected"
date: 2008-09-26 16:46:43 -0700
comments: true
category: Archive
tags: []
redirect_from: ["/archive/2008/09/26/silverlight-2-post-beta2-gotcha---layout-cycle-detected.aspx/"]
author: 0
---
<!-- more -->
<p>Continuing my series of gotchas for Silverlight 2, I wanted to talk about a common error that people are seeing.  This error is something new that you might see when moving code from Beta 2 to the Release Candidate or later.  In Beta 2, if the layout engine detected a cycle, it didn't throw any errors; as I understand it, the layout was just aborted.  But with post Beta2 bits, an error is thrown.</p>
<p>The error you'll get will specify "Layout Cycle Detected" as the message.  This error message is very accurate--the layout engine detected a cycle within your layout; or another way to say it, you have an infinite loop in your layout.</p>
<p>The biggest culprit that leads to this error is code within the LayoutUpdated event handler.  If your LayoutUpdated event handler does anything to alter the layout of your control, then that will cause the LayoutUpdated event to fire again, and again, and again... :-)</p>
<p>Sometimes you need to have layout altering code within this event handler though, so what is one to do?</p>
<p>First, you should consider whether you really need the layout changes to occur on every call to LayoutUpdated.  Would it suffice to handle the Loaded event as well as the Application.Current.Host.Content.Resized event.  Between these two events, you'll get notified when the control is loaded into the visual tree, and you'll get notified any time the host is resized, which could cause you to need to change your layout again.  Scenarios like modal dialogs should fall into this category.</p>
<p>Second, if you really do need to use LayoutUpdated, you might just need to put some conditions around your layout changes.  For instance, if you are calculating a new width and height for your control, before you actually set the width and height, check to make sure the current values differ from what you calculated.  This will allow the first LayoutUpdated event to resize your control, which triggers another LayoutUpdated event, but that event will recognize that there's no work to do, and the cycle will end.</p>
<p>These same rules will apply when you're handling the SizeChanged event, or if you're doing any other overrides on the layout of your control.</p>
<p><em>Update: I posted this information on <a href="http://silverlight.net/forums/t/30604.aspx">Silverlight Forums</a> as well</em></p>
<div class="wlWriterSmartContent" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:23d10125-9126-4ab4-b95c-4111f65033a9" style="PADDING-RIGHT: 0px; DISPLAY: inline; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px">Technorati Tags: <a rel="tag" href="http://technorati.com/tags/Silverlight">Silverlight</a>,<a rel="tag" href="http://technorati.com/tags/XAML">XAML</a>,<a rel="tag" href="http://technorati.com/tags/Silverlight%202%20RC0">Silverlight 2 RC0</a></div>

