---
layout: post
title: "WCF RIA Services V1.0 SP2 RC"
date: 2011-09-03 01:25:26 -0700
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.com/archive/2011/09/02/RIAServicesSP2RC", "http://jeffhandley.com/archive/2011/09/02/riaservicessp2rc"]
author: 0
---
<!-- more -->
<p>On September 1, 2011, Silverlight 5 RC was released.  As always, RIA Services is included in the Tools for Silverlight, and that release included our V1.0 SP2 RC build.  And also as always, we published a standalone installer for RIA Services.  You can find it <a href="http://go.microsoft.com/fwlink/?LinkID=227926">on the download center</a>.  The <a href="http://silverlight.net/getstarted/riaservices">silverlight.net/getstarted/riaservices</a> page will get updated soon to include the link to this build.</p>  <p>This release is one more step toward closing down our SP2 release, and we fixed a number of bugs since SP1.  Some notable differences between SP1 and SP2 are:</p>  <ol>   <li>DateTimeOffset is supported in SP2 </li>    <li>Support for Silverlight 5 (see below) </li>    <li>Entity Framework Code-First Support (see below) </li>    <li><a href="http://jeffhandley.com/archive/2011/08/08/LiveIntelliSenseDeprecated.aspx">Live IntelliSense is deprecated</a> </li>    <li><a href="http://varunpuranik.wordpress.com/2011/06/14/operationtagits-demise-and-workarounds/">OperationTag was removed</a> </li> </ol>  <h3>Support for Silverlight 5 (and Silverlight 4)</h3>  <p>If you’re using RIA Services SP1, you can target Silverlight 5 with your applications and everything will seem to work.  Unfortunately, there’s a small issue that is lurking in your generated code, ready and waiting to cause you bugs.  If you look closely at differences between SL4 and SL5 code, you’ll see that there RIA Services SP1 never generates a [RoundtripOriginal] attribute.  The omission of this attribute can wreak havoc on your application, and it’s unfortunate that it is silently omitted.  With RIA Services SP2, the attribute will return when you are targeting Silverlight 5, and your app will be back to normal.</p>  <p>This issue was introduced because Silverlight 5 changed the runtime and SDK assembly versions from 2.0.5.0 to 5.0.5.0.  Deep down in the RIA Services code generation layer, this caused problems where Silverlight assemblies with the 2.0.5.0 version on them could not be loaded.  Ultimately, that surfaced as attributes from those assemblies not getting propagated from the server to the client.  Because RoundtripOriginalAttribute is defined in a SL4-based assembly, it fails to get generated when targeting Silverlight 5.</p>  <p><strong>We fixed this issue in RIA Services SP2, so if you are targeting Silverlight 5, you must use RIA Services SP2.</strong></p>  <p>In addition to using RIA Services SP2 for Silverlight 5 applications, <strong><u>you can still target Silverlight 4 as well</u></strong>.  RIA Services does not depend on Silverlight 5 at all and is in fact still compiled against Silverlight 4 to ensure backward-compatibility.</p>  <h3>Entity Framework Code First Support</h3>  <p>Support for Entity Framework Code First is provided through either the RIA Services Toolkit, or through the RIAServices.EntityFramework NuGet package.  Rather than repeating myself, I’ll just point you to some previous posts on this topic:</p>  <ul>   <li><a href="http://jeffhandley.com/archive/2011/06/30/RIAServicesCodeFirst.aspx">RIA Services EF Code First Support</a> </li>    <li><a href="http://jeffhandley.com/archive/2011/08/02/ToolkitAugust2011.aspx">WCF RIA Services Toolkit (August 2011) - And Updated NuGet Packages</a> </li> </ul>  <p>The difference that you’ll see with the SP2 RC release though is that EF Code First DbContext classes are now respected by the Domain Service Wizard when using “Add New Item… Domain Service.”  When you have a valid DbContext class, and you have the Microsoft.ServiceModel.DomainServices.EntityFramework assembly referenced (either from the Toolkit or NuGet), you can now select it from the drop-down and have your Domain Service class stubbed out for you.</p>  <p>For more info on how to use EF Code First with RIA Services, <a href="http://varunpuranik.wordpress.com/2011/06/29/wcf-ria-services-support-for-ef-4-1-and-ef-code-first/">please check out Varun Puranik’s blog</a>.  But again, with SP2 RC, you’ll get Domain Service wizard support. Yeah!  But don’t forget you need to add the reference to the Toolkit assembly or (preferably) the RIAServices.EntityFramework NuGet package in order for it to light up.</p>  <h3>Side by Side Support?</h3>  <p>Some people have asked me if RIA Services supports Side-by-Side installations.  No, it doesn’t.  If you’re targeting Silverlight 4 and you need a Go-Live license, use RIA Services V1.0 SP1.  If you’re targeting Silverlight 5 or you don’t need a Go-Live license, then use RIA Services V1.0 SP2.</p>  <p>Something else I wanted to mention regarding side-by-side support is Silverlight 4 and Silverlight 5.  There’s an important detail that I don’t know has been communicated properly: When installing Silverlight 5 on your machine, you <em>must</em> keep the Silverlight 4 SDK and Tools installed on your machine.  For that matter, you need to keep the Silverlight 3 SDK installed too.  If you uninstall any of those things, I promise you pain.  Installing Silverlight 5 RC Tools will give you the Silverlight 5 runtime, SDK, and Tools.  Your Silverlight 3/4 SDK/Tools will be left in place as these function side-by-side.  Your Silverlight runtime will be replaced with SL5, but that won’t interrupt SL4 work.</p>  <h3>Roadmap</h3>  <p>We are getting close to a final release of SP2.  You can expect our final release to be included with Silverlight 5’s final release.  We are listening for feedback on the RC though, and we look forward to getting the RTW build in your hands soon!</p>  <div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:560df27e-2d10-481d-8733-9abc250b15aa" class="wlWriterSmartContent">Technorati Tags: <a href="http://technorati.com/tags/RIAServices" rel="tag">RIAServices</a>,<a href="http://technorati.com/tags/Silverlight" rel="tag">Silverlight</a>,<a href="http://technorati.com/tags/EntityFramework" rel="tag">EntityFramework</a></div>
