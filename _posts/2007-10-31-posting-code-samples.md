---
layout: post
title: "Posting Code Samples"
date: 2007-10-31 08:49:16 -0700
comments: true
category: Archive
tags: []
redirect_from: ["/archive/2007/10/31/posting-code-samples.aspx/"]
author: 0
---
<!-- more -->
<p>One of the reasons I've moved my blog so many times is that I've had a hard time finding a good blog and writer that allows me to easily post nicely-formatted code samples.  I tried Wordpress with some of the add-ons that were supposed to do the trick, but it just kept getting me close, but not all the way there.</p>  <p>So, I'm now using <a href="http://subtextproject.com/" target="_blank">Subtext</a> and Windows Live Writer.  I just gambled and assumed this combination would work well, without doing any research.  If it does, great, if not, I'm no worse off than I was before!  So here it goes, let's see how it looks...</p>  <p>I installed the <a href="http://gallery.live.com/liveItemDetail.aspx?li=d4409446-af7f-42ec-aa20-78aa5bac4748&amp;bt=9" target="_blank">Code Snippet plugin for Windows Live Writer</a> by the way.</p>  <p>Here's the code that I had to add to my Subtext skin to get my Blogroll to show up:</p>  <div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.5%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; background-color: #f4f4f4">   <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">     <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #0000ff">&lt;</span><span style="color: #800000">h3</span> <span style="color: #ff0000">id</span><span style="color: #0000ff">="blogroll-heading"</span><span style="color: #0000ff">&gt;</span>Blogroll<span style="color: #0000ff">&lt;/</span><span style="color: #800000">h3</span><span style="color: #0000ff">&gt;</span></pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #0000ff">&lt;</span><span style="color: #800000">script</span> <span style="color: #ff0000">src</span><span style="color: #0000ff">="http://services.newsgator.com/ngws/Blogroll.aspx?uid=169110&amp;mid=1"</span><span style="color: #0000ff">&gt;&lt;/</span><span style="color: #800000">script</span><span style="color: #0000ff">&gt;</span></pre>
  </div>
</div>

<p>And here's a teaser that might give you some clues about what my MVP pattern does:</p>

<div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.5%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; background-color: #f4f4f4">
  <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">
    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none">ITextbox txtFirstName;</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">...</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none">txtFirstName.Enabled = <span style="color: #0000ff">false</span>;</pre>
  </div>
</div>

<p>
  <br />Not too bad.  I tried a couple of other add-ins first, but this one looks like it'll do what I want.</p>

