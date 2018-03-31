---
layout: post
title: "Google Desktop - Search Desktop by default"
date: 2008-01-08 17:47:10 -0800
comments: true
category: Archive
tags: []
redirect_from: ["/archive/2008/01/08/google-desktop---search-desktop-by-default.aspx"]
author: 0
---
<!-- more -->
<p>I swore that <a href="http://desktop.google.com/" target="_blank">Google Desktop</a> used to provide a means for setting it to search the desktop by default, instead of the web.  <a href="http://jesstedder.com" target="_blank">Jess</a> confirmed this for me.  He's running version 5.1.0707 and I'm running version 5.7.0712.  I guess they decided to take this feature away for some reason.  Jess found the option on the 'Display' tab of the desktop preferences.  But the option isn't there for me.</p>  <p>I decided to jump into the registry to see if anything jumped out at me.  Sure enough, something did.  The key HKEY_CURRENT_USER\Software\Google\Google Desktop\Deskbar has REG_SZ setting for "search_type."  The value was "Search Web" and I changed it to "Search Desktop."  This immediately went into effect and I am now searching my desktop by default from the deskbar.</p>  <div class="wlWriterSmartContent" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:281025ba-9f0c-4bf6-8658-5b017fbf6a8b" style="padding-right: 0px; display: inline; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px">Technorati Tags: <a href="http://technorati.com/tags/Google%20Desktop" rel="tag">Google Desktop</a></div>

