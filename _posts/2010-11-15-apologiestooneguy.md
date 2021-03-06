---
layout: post
title: "Our Apologies to One Guy"
date: 2010-11-15 22:53:38 -0800
comments: true
tags: ["RIAServices"]
redirect_from: ["/archive/2010/11/15/ApologiesToOneGuy.aspx/", "/archive/2010/11/15/apologiestooneguy.aspx"]
author: "Jeff Handley"
---
<!-- more -->
<p>Last week, <a href="http://twitter.com/#!/JeffHandley/status/2806952786657281" target="_blank">I tweeted</a> about a bug the RIA Services QA team found.  It’s rather obscure and we decided not to fix it.  I thought it was worth mentioning for at least the humor of it.</p>  <p>Here’s what you must be using in order to see this issue:</p>  <ul>   <li>Windows XP Service Pack 3 - Japanese</li>  <li>Visual Web Developer 2010 Express - Japanese</li>  <li>WCF RIA Services V1.0 SP1 Beta (or RTM, since we won’t be fixing the issue)</li>  <li>VB</li> </ul>  <p>And here’s what you do:</p>  <ol>   <li>Create a new Silverlight Business Application project using WCF RIA Services - Using VB</li>  <li>Build the Solution</li> </ol>  <p>Expected Result:</p>  <ul>   <li>The solution builds without error</li> </ul>  <p>Actual Result:</p>  <ul>   <li>A seemingly random number of build errors; somewhere between 50 and 75 of them.</li>  <li>The build errors all point to the .Designer.vb files for ValidationErrorResources.resx and RegistrationDataResources.resx</li> </ul>  <p>Workaround:</p>  <ol>   <li>Open both ValidationErrorResources.resx and RegistrationDataResources.resx and re-save the files; or</li>  <li>Close and re-open the solution; or</li>  <li>Go to one of the errors that shows up in the XML comments in the Designer.vb files and add a space anywhere in the line.</li> </ol>  <p>Once the errors are gone, they stay gone.  They only show up when you first create your solution; it’s quite strange.  I have filed this as a bug in Visual Web Developer 2010 Express, but I don’t know what the bug’s fate will be.</p>  <p>Maybe I’m being naive, but I just can’t imagine that there are many people using:</p>  <ol>   <li>Windows XP SP3 Japanese (English works fine)</li>  <li>Visual Web Developer 2010 Express Japanese (English works fine)</li>  <li>VB (C# works fine)</li> </ol>  <p>Maybe there’s one guy?  If so, he is whom I’m apologizing to in the title of this blog post.  If you know him, please send him the link to this page.  And then send him a license for Windows 7 please.</p>

