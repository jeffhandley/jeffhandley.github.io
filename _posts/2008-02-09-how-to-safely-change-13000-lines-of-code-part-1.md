---
layout: post
title: "How to safely change 13,000 lines of code, part 1"
date: 2008-02-09 12:13:46 -0800
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.com/archive/2008/02/09/how-to-safely-change-13000-lines-of-code-part-1"]
author: 0
---
<!-- more -->
<p>I cranked out a bunch of code tonight for my new nullable types approach.  This is a .NET 1.1 solution, so it's pretty old school, but it was still fun.</p>  <p>I <a href="http://blog.jeffhandley.com/archive/2008/02/05/90-of-this-job-is-figuring-out-what-to-call.aspx" target="_blank">explained the problem</a> with our existing methods the other day.  Basically, we have a ton of helper functions for dealing with nulls and empty strings across all of the data types.  The methods are confusing and we haven't been using them correctly.  We need a more sensible approach.</p>  <p>After chatting with Marco, we came up with something like this:</p>  <div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.5%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; background-color: #f4f4f4">   <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">     <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   1:</span> NullableGuid.FromDatabase(Value <span style="color: #0000ff">as</span> <span style="color: #0000ff">Object</span>) <span style="color: #0000ff">As</span> Guid</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   2:</span>  </pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   3:</span> NullableGuid.FromUserInput(Value <span style="color: #0000ff">as</span> <span style="color: #0000ff">String</span>) <span style="color: #0000ff">AS</span> Guid</pre>
  </div>
</div>

<p>
  <br />I intended to create all of the new classes and methods, mark the old ones obsolete, and correct all of the existing code by hand.  This would force me into doing some pretty thorough code reviews, and we just wrapped up development on a major release, so that would be good.  I estimate that about 30% of our usage of the methods is incorrect, leaving tons of bugs waiting to pop up.  It would be awesome to clean that stuff up as part of this release.

  <br /><em>(30% is a VERY pessimistic estimate.  It could very well be 3%, but I wanted to be prepared for the worst.)</em></p>

<p>To get an idea of how much work I was getting into, I went ahead and marked everything as obsolete Thursday afternoon.  I guessed that it would create about 7000 build errors.  A coworker guessed 10,000.  Well, it ended up being nearly 13,000 errors.  When I left work Thursday, I still had it in my head that I'd find a way to update all of that code by hand, and here's why...</p>

<p>If the old method of IsNullGuid is being used incorrectly, and I replace that method with <u>NullableGuid.FromDatabase</u>, a global search and replace would translate to the new code, but it would leave all of the usage as is, and we'd still have the same error rate--only new code would benefit, leaving the million lines of existing code the same.  That won't do.</p>

<p>Frankly though, I knew there must be a better way.  I really shouldn't have to update 13,000 lines of code by hand to clean this up.  Besides, that level of monotony would surely lead to oversights and even more problems.  I need this to be 100% accurate and I cannot introduce <u>any</u> issues.</p>

<p>Friday morning, on my way in to work, I thought it through again and realized that I don't need to have 2 separate methods for FromDatabase and FromUserInput.  With each of the data types getting its own class (e.g. NullableGuid), I can overload the heck out of things, and make the routines much more intelligent.  I can simply create <u>NullableGuid.From</u> with a few different overloads.  Then I can replace all instances of IsNullGuid <em>as well as</em> IsStringEmptyGuid with <u>NullableGuid.From</u>.</p>

<p>If <u>NullableGuid.From</u> is implemented correctly, it will handle every possible scenario of data handed into it.  This would allow me to use a global search and replace, putting <u>NullableGuid.From</u> in everywhere, and it will always be right.  It will be impossible to get it wrong, so long as <u>NullableGuid.From</u> is bullet-proof.  Instead of fixing 13,000 lines of code by hand, I'll just need to execute a couple dozen search and replaces.  These thoughts made for an exciting drive into work.</p>

<p>What I say next might surprise some of you; the ones that know me best anyway.  The only person I've told this too was very surprised in fact.</p>

<p><strong>I used a TDD approach to make these methods bullet-proof, and to ensure compatibility with the old methods.</strong></p>

<p>I haven't previously used <a href="http://en.wikipedia.org/wiki/Test-driven_development" target="_blank">TDD</a> techniques on this project, and I've stated that TDD would not work on this project, for many reasons.  But for what I was doing, TDD made perfect sense today; it was an unordinary task for this project.  Let's break it down to see why it was such a good fit.</p>

<ol>
  <li>It's been like 4 years since anything this deep in the architecture has been changed</li>

  <li>I was creating lots of classes that have lots of tiny methods</li>

  <li>The methods deal strictly with scalar values and simple parameters</li>

  <li>There are no outside dependencies, no need for <a href="http://en.wikipedia.org/wiki/Dependency_injection" target="_blank">DI</a> or anything fancy</li>

  <li>There are several different scenarios for calling each method, and each method needs to be tested against each scenario</li>

  <li>The methods are going be be called 13,000 times, right off the bat -- they better be right!</li>

  <li>I have existing methods to use for benchmark results</li>
</ol>

<p>For every method, I ended up mapping it to an existing method.  I need to do this anyway, in order to do my search and replace.  Then I created unit tests for all possible scenarios, against all of the methods.  I did this before implementing the new methods, as true TDD dictates.  The unit tests compared the results of the new methods to the results of the old methods.  I started at 0% passing, but at 100% passing, it's safe to do the global search and replace.</p>

<p>All of my NullableType classes are fully implemented.  I didn't reach 100% passing, because I found a bug in the old IsNullString and IsStringEmptyString methods.  I've corrected the bug in the new <u>NullableString.From</u> method, but this leaves a difference between the methods.  I'll have to review this with the QA department on Monday to make sure they agree that we should fix the bug.  We were not trimming off leading and trailing spaces from user entries, and we're supposed to be.</p>

<p>I have not yet processed the search and replace.  I would've done it tonight, but some bozo on the project broke the build before he left for the night (he will be flogged on Monday).  So I'll have to wait until next week.  I'm very confident that the search and replace will safely change 13,000 lines of code, and the new nullable type methods will not be susceptible to misuse.</p>

<p>I'll post a follow up next week after I process the search and replace, and I'll include some samples of the code.  Until then, wish me luck!</p>

<div class="wlWriterSmartContent" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:de3d6478-43b4-4953-a3be-c3f8b384274f" style="padding-right: 0px; display: inline; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px">Technorati Tags: <a href="http://technorati.com/tags/TDD" rel="tag">TDD</a>,<a href="http://technorati.com/tags/DI" rel="tag">DI</a>,<a href="http://technorati.com/tags/Nullable%20Types" rel="tag">Nullable Types</a></div>

