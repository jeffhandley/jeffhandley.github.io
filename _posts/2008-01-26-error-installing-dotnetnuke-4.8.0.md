---
layout: post
title: "Error Installing DotNetNuke 4.8.0"
date: 2008-01-26 07:56:14 -0800
comments: true
category: Archive
tags: []
redirect_from: ["/archive/2008/01/25/error-installing-dotnetnuke-4.8.0.aspx"]
author: 0
---
<!-- more -->
<p>I'm setting up <a href="http://www.dotnetnuke.com/" target="_blank">DotNetNuke</a> for a project and I got an error trying to install the database.</p>  <p><code>Installing Database - Version 4.4.0...FAILURE 400 - Thread was being aborted.</code></p>  <p>I couldn't find any help anywhere.  I think I figured it out though.  I was using the custom installation option and I'd get the error after what I think was about 3 minutes.  I suspect that IIS was terminating the thread because the request had been running too long.</p>  <p>I didn't actually need to change any of the options for the custom installation, so I went back and selected the Auto installation method.  This worked like a champ and I'm moving forward.</p>  <div class="wlWriterSmartContent" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:99d456b4-845d-49e0-9782-af5456320b3c" style="padding-right: 0px; display: inline; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px">Technorati Tags: <a href="http://technorati.com/tags/DotNetNuke" rel="tag">DotNetNuke</a></div>

