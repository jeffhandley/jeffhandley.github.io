---
layout: post
title: "Deprecating RIA Services "Live IntelliSense""
date: 2011-08-08 22:44:41 -0700
comments: true
tags: []
redirect_from: ["/archive/2011/08/08/LiveIntelliSenseDeprecated.aspx/", "/archive/2011/08/08/liveintellisensedeprecated.aspx"]
author: "Jeff Handley"
---
<!-- more -->
<p>WCF RIA Services V1.0 (and V1.0 SP1) included a feature called “Live IntelliSense.”  Live IntelliSense is a feature that you probably didn’t even know about, but you might also take it for granted.  Some people <em>do</em> know about the feature though as it’s caused a few problems, and those affected have had to disable it.</p>
<h3>What is Live IntelliSense?</h3>
<p>The easiest way to define the feature is by giving an example of how it applies.  Imagine the following steps are followed when using RIA Services:</p>
<ol>
  <li>Add a new DomainService class - call it CustomerService </li>
  <li>Within CustomerService, add a method: public IQueryable&lt;Customer&gt; GetCustomers() { … } </li>
  <li><em>Without building</em>, open up a file within your Silverlight project and either A) start typing code, or B) open the Data Sources window </li>
  <li>You will find that CustomerContext is available, with a GetCustomersQuery method available <em>(Live IntelliSense did this for you)</em> </li>
  <li>Use GetCustomersQuery and then build </li>
  <li>Go back into CustomerService and rename GetCustomers to GetActiveCustomers </li>
  <li><em>Without building</em>, go back into your Silverlight project and you should see a build error stating that GetCustomersQuery cannot be found <em>(Live IntelliSense did this for you)</em> </li>
  <li>Change the code to reference GetActiveCustomersQuery, and continue working </li>
</ol>
<h3>Why is it being deprecated?</h3>
<p>The primary reason for deprecating this feature is performance within Visual Studio.  RIA Services Live IntelliSense would kick in any time you changed context from your Web project to a Silverlight project.  With a RIA Services link between those two projects, a background compilation would kick off to update IntelliSense to match what your Web project’s Domain Services exposed.  When working in a large solution, this background compilation could take seconds and slow you down.</p>
<p>Additionally, we’ve seen a few reports where IntelliSense could get out of sync with what’s on disk vs. what’s in memory, and this has led to confusing issues where developers have had to restart Visual Studio to get things back into a normal state.</p>
<p>In situations where developers have been adversely impacted by the performance hit or recurrent out-of-sync bugs have hit them, we’ve encouraged them to disable the feature.</p>
<h3>How do you disable it?</h3>
<p>The Live IntelliSense feature checks a registry key value to determine whether or not to activate itself.  The key value is located at:</p>
<p>On a 32-bit machine: <br />
HKEY_LOCAL_MACHINE\SOFTWARE \Microsoft\WCFRIAServices\v1.0\DisableLiveIntelliSense</p>
<p>On a 64-bit machine: <br />
HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\WCFRIAServices\v1.0\DisableLiveIntelliSense</p>
<p>When that key value exists, as a dword with the value of 1, Live IntelliSense is disabled.  If the key is missing or has a value other than 1 (or a different value type), Live IntelliSense is active.</p>
<h3>When is it being deprecated?</h3>
<p>We will remove this feature when WCF RIA Services V1.0 SP2 is released.  In fact, with the SP2 Preview that we released for MIX11, we put the registry key in place by default, disabling the feature by default.  We have now removed the feature entirely, so the final release of SP2 will omit Live IntelliSense completely.</p>
<h3>How will I be affected?</h3>
<p>Review the workflow outlined above.  You will now have to build your solution at the places where you were able to proceed in your Silverlight project without building.  We expect this will be less of a nuisance than the constant performance hit you have been paying.  Since the Preview of SP2 at MIX11, we’ve not heard a single report of problems being caused by the feature being disabled by default, so that seems like a good indication to me that it’s okay to deprecate the feature.</p>
<div style="PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; DISPLAY: inline; FLOAT: none; PADDING-TOP: 0px" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:2b324231-f62a-4af8-b85e-8c89a24cf0c0" class="wlWriterEditableSmartContent">Technorati Tags: <a rel="tag" href="http://technorati.com/tags/RIAServices">RIAServices</a></div>
<h3> </h3>

