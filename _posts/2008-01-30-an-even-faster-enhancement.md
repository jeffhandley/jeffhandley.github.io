---
layout: post
title: "An even faster enhancement"
date: 2008-01-30 08:24:45 -0800
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.com/archive/2008/01/30/an-even-faster-enhancement"]
author: 0
---
<!-- more -->
<p>Well, I just broke my record again I think.</p>  <p><img height="450" alt="image" src="http://blog.jeffhandley.com/Images/PostImages/Anevenfasterenhancement_595/image.png" width="373" /> </p>  <p>It's been 17 minutes since I finished the <a href="http://blog.jeffhandley.com/archive/2008/01/30/fastest-enhancement-ever.aspx" target="_blank">last enhancement</a>.  Within this 17 minutes, I blogged about my previous enhancement and then completed a new enhancement.</p>  <p>There's a 'Submit Resume' link next to each job's position number now.  When you click on that, it passes the position number to the Submit Resume page and it pre-fills the message body of the form with a statement that the person is interested in the noted position number.</p>  <p><a href="http://www.dotnetnuke.com" target="_blank">DotNetNuke</a> made this really easy to do, with the following code:</p>  <div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.5%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; height: 50px; background-color: #f4f4f4">   <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">     <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   1:</span> <span style="color: #0000ff">&lt;</span><span style="color: #800000">a</span> <span style="color: #ff0000">href</span><span style="color: #0000ff">="&lt;%#NavigateUrl(55, "</span><span style="color: #0000ff">", "</span><span style="color: #ff0000">PositionNumber</span><span style="color: #0000ff">", DirectCast(Container.DataItem, JobInfo).PositionNumber) %&gt;"</span><span style="color: #0000ff">&gt;</span>Submit Resume<span style="color: #0000ff">&lt;/</span><span style="color: #800000">a</span><span style="color: #0000ff">&gt;</span></pre>
  </div>
</div>

<div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.5%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; background-color: #f4f4f4">
  <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">
    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   1:</span> <span style="color: #0000ff">If</span> <span style="color: #0000ff">Not</span> IsNothing(Request.Params(<span style="color: #006080">"PositionNumber"</span>)) <span style="color: #0000ff">Then</span></pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   2:</span>     txtBody.Text = <span style="color: #006080">"I am interested in position number "</span> &amp; Request.Params(<span style="color: #006080">"PositionNumber"</span>)</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   3:</span> <span style="color: #0000ff">End</span> <span style="color: #0000ff">If</span></pre>
  </div>
</div>

<p>I had to go into Debug mode to make sure that I'd be able to get "PositionNumber" from the querystring.  I did, and it worked like a charm.</p>

<p>I am really digging DotNetNuke!</p>

<div class="wlWriterSmartContent" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:d4eec2b1-26aa-4805-ab22-583b203bd20b" style="padding-right: 0px; display: inline; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px">Technorati Tags: <a href="http://technorati.com/tags/DotNetNuke" rel="tag">DotNetNuke</a></div>
