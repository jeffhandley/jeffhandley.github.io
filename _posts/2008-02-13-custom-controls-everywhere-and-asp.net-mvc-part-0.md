---
layout: post
title: "Custom Controls Everywhere and ASP.NET MVC, part 0"
date: 2008-02-13 19:53:52 -0800
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.com/archive/2008/02/13/custom-controls-everywhere-and-asp.net-mvc-part-0.aspx"]
author: 0
---
<!-- more -->
<p>As I <a target="_blank" href="http://blog.jeffhandley.com/archive/2008/02/12/self-validating-form-controls.aspx">referenced</a> last night, I've been advocating "custom controls everywhere" for a long, long time.  I don't approve of using the &lt;asp:Textbox&gt; control or &lt;asp:DataGrid&gt; control, or pretty much any others.  Instead, these controls should be inherited, and the derived controls should be used.</p>
<p>There are many reasons for doing this, and I've given a few user group talks on this and I've offered tidbits in my blog over the years.  But I've been thinking about how ASP.NET MVC will hinder my ability to use custom controls everywhere, and what I should do about that.</p>
<p>The problem is that ASP.NET MVC offers <a target="_blank" href="http://blog.wekeroad.com/2007/12/05/aspnet-mvc-preview-using-the-mvc-ui-helpers/">HTML UI Helpers</a> instead of actual controls.  These helpers are functions that return HTML snippets inline.  It feels just like what I did back in ASP days when trying to encapsulate common HTML blocks (VBScript, yea!!).  And honestly, it seems like a huge step backward.  Using ASP.NET MVC, I immediately miss the form and validator controls.  On a large project, I know I'd miss my derived datagrid that has tons and tons of goodness baked in, especially when mixed with custom datagrid columns.</p>
<p>This post serves as part 0 of a 4-part series on the topic.  During this series, I am sure that many MVC purists will disagree with what I have to say, because what I will present isn't "pure" MVC.  That's okay, and comments are welcomed!  For many of us though, we don't care about using MVC in its virgin state; rather, we want to build maintainable, quick-to-develop, user-friendly applications, regardless of the pattern applied.  The MVC pattern has many offerings that provide maintainability, but there seems to be some loss in developer efficiency and user experience.</p>
<ul>
    <li>Part 0 (this post) - Announcement of the series </li>
    <li><a href="http://blog.jeffhandley.com/archive/2008/02/24/custom-controls-everywhere-and-asp.net-mvc-part-1.aspx">Part 1</a> - Why to use Custom Controls Everywhere, and how ASP.NET MVC takes away the capability </li>
    <li><a href="http://blog.jeffhandley.com/archive/2008/03/08/custom-controls-everywhere-and-asp.net-mvc-part-2.aspx">Part 2</a> - How to implement Custom Controls Everywhere, using ASP.NET MVC </li>
    <li><a href="http://blog.jeffhandley.com/archive/2008/09/07/custom-controls-everywhere-is-cheap.aspx">Custom Controls Everywhere is Cheap!</a> </li>
    <li><a href="http://blog.jeffhandley.com/archive/2008/09/07/custom-controls-everywhere-and-asp.net-mvc-incomplete.aspx">Intermission and Disclaimer about Parts 3 and 4</a> </li>
    <li><a href="http://blog.jeffhandley.com/archive/2008/09/20/custom-controls-everywhere-and-asp.net-mvc-part-3.aspx">Part 3</a> - How the ASP.NET MVC framework could change to offer a lot more extensibility and customization </li>
    <li>Part 4 - Adding <u>client-side</u> validation to the concept </li>
</ul>
<p>Please tune in and watch where this goes.  I would love to hear candid comments and constructive criticism.  Heck, I even invite you to blast me for not knowing what the heck I'm talking about.  Hit me with whatever you got.  But in the end, I promise that I will have presented a means for encapsulating common HTML in a form similar to what we're used to in traditional ASP.NET.  And this approach will offer a means for customizing those controls for an application, ensuring a consistent user interface, improved developer efficiency, and better maintainability.</p>
<div class="wlWriterSmartContent" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:6795a2e4-6f66-4d45-9009-eba32f661986" style="PADDING-RIGHT: 0px; DISPLAY: inline; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px">Technorati Tags: <a rel="tag" href="http://technorati.com/tags/ASP.NET">ASP.NET</a>,<a rel="tag" href="http://technorati.com/tags/Custom%20Controls%20Everywhere">Custom Controls Everywhere</a>,<a rel="tag" href="http://technorati.com/tags/MVC">MVC</a>,<a rel="tag" href="http://technorati.com/tags/MVP">MVP</a></div>

