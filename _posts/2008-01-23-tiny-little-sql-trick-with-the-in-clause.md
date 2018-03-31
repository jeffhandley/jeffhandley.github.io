---
layout: post
title: "Tiny little SQL trick with the IN clause"
date: 2008-01-23 22:22:45 -0800
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.com/archive/2008/01/23/tiny-little-sql-trick-with-the-in-clause.aspx"]
author: 0
---
<!-- more -->
<p>I don't know why I'd never used the IN clause in this manner before, but it just came to mind...</p>  <p>I was writing an ad-hoc query against the sitemap table.  I needed to find any nodes where either the node label or node heading was "Course Section Mark Entry".  This felt clever:</p>  <div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.5%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; background-color: #f4f4f4">   <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">     <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   1:</span> <span style="color: #0000ff">SELECT</span>        *</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   2:</span> <span style="color: #0000ff">FROM</span>        NavigationSitemap</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   3:</span> <span style="color: #0000ff">WHERE</span>        <span style="color: #006080">'Course Section Mark Entry'</span> <span style="color: #0000ff">IN</span> (Heading, Label)</pre>
  </div>
</div>

<p>I've used similar approaches before, but never exactly like this.</p>

<div class="wlWriterSmartContent" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:4b85a4db-1110-4c01-8783-02f815ca2f21" style="padding-right: 0px; display: inline; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px">Technorati Tags: <a href="http://technorati.com/tags/TSQL" rel="tag">TSQL</a></div>

