---
layout: post
title: "ViewData seems too constraining"
date: 2008-01-25 06:06:35 -0800
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.com/archive/2008/01/24/viewdata-seems-too-constraining.aspx"]
author: 0
---
<!-- more -->
<p>I worked more last night on my ASP.NET MVC project.  Second time sitting down to work on it.  I spent the evening dealing with ViewData, trying to find the best way to wrap everything the UI needs into a nice ViewData object.  The night didn't end well.</p>  <p>As I <a href="http://blog.jeffhandley.com/archive/2008/01/17/asp.net-mvc---first-use.aspx" target="_blank">mentioned</a>, I'm implementing a wizard.  The user will select one or more products, and then they will be prompted with additional steps for each product selected.  I wanted the View to be able to do something like this:</p>  <div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.5%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; background-color: #f4f4f4">   <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">     <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> StaplerReview : ViewPage&lt;ProductWizard&lt;Stapler&gt;&gt;</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   2:</span> {</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   3:</span> }</pre>
  </div>
</div>

<div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.5%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; background-color: #f4f4f4">
  <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">
    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   1:</span> &lt;h2&gt;Details about your selected stapler&lt;/h2&gt;</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   2:</span> &lt;ul&gt;</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   3:</span>     &lt;li&gt;Staple Size: &lt;%# ViewData.ActiveStep.Product.StapleSize %&gt;&lt;/li&gt;</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   4:</span>     &lt;li&gt;Number of Pages: &lt;%# ViewData.ActiveStep.Product.NumberPages %&gt;&lt;/li&gt;</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   5:</span> &lt;/ul&gt;</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   6:</span> &lt;h4&gt;</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   7:</span> You are on step &lt;%# ViewData.ActiveStepIndex + 1 %&gt;</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   8:</span> of &lt;%# ViewData.StepCount %&gt;</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   9:</span> &lt;/h4&gt;</pre>
  </div>
</div>

<p>But man, this starting getting really, really messy.  It was hard to follow through the code and I couldn't quite get it to work the way I wanted.  The Model ended up knowing too much about how it was going to be presented.</p>

<p><a href="http://codebetter.com/blogs/jeffrey.palermo/archive/2008/01/19/introducing-the-smartbag-for-asp-net-mvc-and-soliciting-feedback.aspx" target="_blank">Jeffrey Palermo to the rescue!</a>  A strange twist of fate led me to subscribe to <a href="http://feeds.feedburner.com/jeffreypalermo" target="_blank">Jeffrey's blog</a> tonight and read up.  Just 16 hours ago I was giving up on what I was trying to do with ViewData, and I had no ideas of where to go next.  And now Jeffrey has shown me the light.</p>

<p>Here's what Jeffrey laid out on the table:</p>

<p><code><font size="1">There are some challenges with ViewData as it stands now:</font></p>

  <ul>
    <li><font size="1">A key is required for every object, both in the controller and view. 
        <br />ViewData.Add("conference", conference); </font></li>

    <li><font size="1">A cast is required to pull out object by key. 
        <br />(ScheduledConference)ViewData["conference"] </font></li>

    <li><font size="1">The ViewPage&lt;T&gt; solution discards the valuable flexibility of the objectbag being passed to the view. 
        <br />&lt;%=ViewData.DaysUntilStart.ToString() %&gt; where ViewData is of type ScheduledConference</font> </li>
  </ul>

  <p><font size="1">Facts (or my strong opinions):</font></p>

  <ul>
    <li><font size="1">Repeated keys from controller and view increase chance for typos and runtime errors. </font></li>

    <li><font size="1">Casting every extraction of an object in the view is annoying. </font></li>

    <li><font size="1">Strong-typing ViewPage only works for trivial scenarios. 
        <br />- For instance, suppose once logged in, every view will need the currently logged in user.  Perhaps the user name is displayed at the top right of the screen in the layout (master page).  Since the layout shares the viewdata with the page, we immediately have the need for a flexible container that supports multiple objects.  A strongly typed ViewPage&lt;T&gt; won't work without an elaborate hierarchy of presentation object that are themselves flexible object containers able to support everything needed.  Once you get there, you are almost back to the initial dictionary.</font> </li>
  </ul>
</blockquote>

<p>His SmartBag allows any number of objects to be exposed to ViewData instead of just one.  While I will likely implement my own flavor of this, the concept is the exactly solution I needed.  Now, my ViewData can be strongly typed, but it can provide multiple objects for me, and they don't have to know about each other.  Here's what I'm thinking will be in my bag:</p>

<ol>
  <li>Wizard Information 
    <ol>
      <li>How many steps </li>

      <li>What step am I on </li>

      <li>What was the previous step </li>

      <li>What is the next step </li>
    </ol>
  </li>

  <li>Product object for the current step </li>

  <li>Current User information, always 
    <ol>
      <li>This is part of why I will go with my own implementation. </li>

      <li>My bag will always contain current user information, or what I have always called 'CurrentContext' in basically every app I've written this century. </li>
    </ol>
  </li>
</ol>

<p>The View will then be capable of doing this:</p>

<div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.5%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; background-color: #f4f4f4">
  <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">
    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   1:</span> <span style="color: #008000">// ViewBase inherits from ViewPage&lt;CurrentContext&gt;</span></pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   2:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> StaplerReview : ViewBase</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   3:</span> {</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   4:</span> }</pre>
  </div>
</div>

<div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.5%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; background-color: #f4f4f4">
  <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">
    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   1:</span> <span style="color: #0000ff">&lt;</span><span style="color: #800000">h2</span><span style="color: #0000ff">&gt;</span>Details about your selected stapler<span style="color: #0000ff">&lt;/</span><span style="color: #800000">h2</span><span style="color: #0000ff">&gt;</span></pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   2:</span> <span style="color: #0000ff">&lt;</span><span style="color: #800000">ul</span><span style="color: #0000ff">&gt;</span></pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   3:</span>     <span style="color: #0000ff">&lt;</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span>Staple Size: <span style="color: #0000ff">&lt;</span>%# ViewData.Get<span style="color: #0000ff">&lt;</span><span style="color: #800000">Stapler</span><span style="color: #0000ff">&gt;</span>().StapleSize <span style="background-color: #ffff00">%&gt;</span><span style="color: #0000ff">&lt;/</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span></pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   4:</span>     <span style="color: #0000ff">&lt;</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span>Number of Pages: <span style="color: #0000ff">&lt;</span>%# ViewData.Get<span style="color: #0000ff">&lt;</span><span style="color: #800000">Stapler</span><span style="color: #0000ff">&gt;</span>().NumberPages <span style="background-color: #ffff00">%&gt;</span><span style="color: #0000ff">&lt;/</span><span style="color: #800000">li</span><span style="color: #0000ff">&gt;</span></pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   5:</span> <span style="color: #0000ff">&lt;/</span><span style="color: #800000">ul</span><span style="color: #0000ff">&gt;</span></pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   6:</span> <span style="color: #0000ff">&lt;</span><span style="color: #800000">h4</span><span style="color: #0000ff">&gt;</span></pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   7:</span> You are on step <span style="color: #0000ff">&lt;</span>%# ViewData.Get<span style="color: #0000ff">&lt;</span><span style="color: #800000">Wizard</span><span style="color: #0000ff">&gt;</span>().ActiveStepIndex + 1 <span style="background-color: #ffff00">%&gt;</span></pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   8:</span> of <span style="color: #0000ff">&lt;</span>%# ViewData.Get<span style="color: #0000ff">&lt;</span><span style="color: #800000">Wizard</span><span style="color: #0000ff">&gt;</span>().StepCount <span style="background-color: #ffff00">%&gt;</span></pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   9:</span> <span style="color: #0000ff">&lt;/</span><span style="color: #800000">h4</span><span style="color: #0000ff">&gt;</span></pre>
  </div>
</div>

<p>I feel much better about this implementation.</p>

<div class="wlWriterSmartContent" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:1a30b3e6-06cd-4e3c-8b2b-282d0c745c58" style="padding-right: 0px; display: inline; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px">Technorati Tags: <a href="http://technorati.com/tags/ASP.NET" rel="tag">ASP.NET</a>,<a href="http://technorati.com/tags/MVC" rel="tag">MVC</a></div>

