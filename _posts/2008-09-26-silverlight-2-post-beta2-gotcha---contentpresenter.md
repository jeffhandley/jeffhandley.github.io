---
layout: post
title: "Silverlight 2 Post Beta2 Gotcha - ContentPresenter"
date: 2008-09-26 06:37:09 -0700
comments: true
category: Archive
tags: []
redirect_from: ["/archive/2008/09/25/silverlight-2-post-beta2-gotcha---contentpresenter.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p>As I'm sure you already know, a Release Candidate for Silverlight 2 was <a target="_blank" href="http://weblogs.asp.net/scottgu/archive/2008/09/25/silverlight-2-release-candidate-now-available.aspx">published</a>.  ScottGu does an amazing job of covering a lot of information in his blog posts, and others like <a target="_blank" href="http://silverlight.net/blogs/msnow/archive/2008/09/25/silverlight-version-2-rc0-release.aspx">Mike Snow</a> have also provided some excellent detail.  As they repeatedly told you, go check out the <a target="_blank" href="http://download.microsoft.com/download/6/F/E/6FE1F43D-9D0C-4346-AD08-602DF9BCB3CF/BreakingChangesBetweenBeta2andRelease.doc">breaking changes document</a> that lists all breaking changes from Beta2 to this release candidate.</p>
<p>If you have a Silverlight application that runs against Beta2, please take immediate action to get it moved (in a test environment) to the RC bits.  There were a bunch of breaking changes (all for the better) and some of them might adversely affect your applications.  Since there isn't a release date for Silverlight 2 yet, I would recommend working quickly to make sure you are ready whenever it is released.  It's impossible to estimate how long it will take to complete the migration, so if you put it off, you might find yourself with a broken application once the final release is put out.</p>
<p>With all of that said, there is one gotcha that I want to highlight for you tonight.  This one caused some trouble for me when porting an application from Beta 2 to the newer bits.  I'm talking about the base class change to ContentPresenter.  In Beta2, ContentPresenter derived from Control; in the new bits, it derives from FrameworkElement.  This might not sound impactful, but it really is.  For starters, here's the list of properties that are now removed from ContentPresenter because of this change:</p>
<ul>
    <li>Background </li>
    <li>BorderBrush </li>
    <li>BorderThickness </li>
    <li>DefaultStyleKey </li>
    <li>FontFamily </li>
    <li>FontSize </li>
    <li>FontStretch </li>
    <li>FontStyle </li>
    <li>FontWeight </li>
    <li>Foreground </li>
    <li>HorizontalContentAlignment </li>
    <li>IsEnabled </li>
    <li>IsTabStop </li>
    <li>Padding </li>
    <li>TabIndex </li>
    <li>TabNavigation </li>
    <li>Template </li>
    <li>VerticalContentAlignment </li>
</ul>
<p>That's a pretty long list!  And to make matters worse, I think that every single ContentPresenter I encountered in the app I ported was using at least half of these properties.  That meant that the XAML had to be updated so that these properties were set on a container control that included the ContentPresenter.  In some cases, that was straight-forward, but in others, it wasn't as simple.</p>
<p>Now, for the real kick in the pants... If you have some of these properties set on a ContentPresenter, within your XAML, your application will build just fine.  It might even run and begin to function.  But eventually, the parser will try to load this portion of the XAML and it will barf.  You will get really bizarre errors like this: <em>Catastrophic failure (Exception from HRESULT: 0x8000FFFF (E_UNEXPECTED))</em>.  The stack trace will look very scary and it will point you nowhere near your ContentPresenter.</p>
<p>In my experience, this caused some major headaches.  Sometimes the app would run, sometimes it wouldn't.  Sometimes all screens would work, sometimes they wouldn't.  When it did crash, it would crash with a different stack trace each time it seemed.  The common thread was the catastrophic failure E_UNEXPECTED, even though the rest of the stack trace would vary widely.</p>
<p>Since examining the stack traces eventually proved to be a fruitless effort, I started removing XAML one block at a time from all content in the application.  Ultimately, I found that one of the XAML files had some errors in it when opened in VS.  When I had the file open, I could see that there were errors reported about the bad properties on the ContentPresenter.  Once I got rid of all of the obsolete properties from all of the ContentPresenter controls in the entire app, it ran smoothly.  I then just had to restyle some things to restore the desired presentation.</p>
<p>So, if you have a Silverlight Beta2 application that you are porting to the RC (or final) build, beware of your ContentPresenter controls.  If you get strange and sporadic errors from anywhere in your application, don't assume the problems are near where the failure was.  Just open all of your XAML files in the editor and look for errors on your ContentPresenters.  Once you get rid of the obsolete properties, you will be in much better shape.</p>
<p>Now, go update your application to work against the release candidate!</p>
<p><strong><em>Update: I posted this information to the <a href="http://silverlight.net/forums/p/30375/97511.aspx#97511">Silverlight Forums</a> as well<br />
Another Update: <a href="http://silverlight.net/blogs/jesseliberty/archive/2008/09/28/rc0-amp-contentpresenter.aspx">Jesse Liberty posted</a> about this topic to, upon my request for more coverage on the topic</em></strong></p>
