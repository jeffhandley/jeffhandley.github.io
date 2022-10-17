---
layout: post
title: "RIA Services SP1 Installation Note"
date: 2010-11-19 00:54:30 -0800
comments: true
tags: ["RIAServices"]
redirect_from: ["/archive/2010/11/18/RiaServicesSP1InstallationNote.aspx/", "/archive/2010/11/18/riaservicessp1installationnote.aspx"]
author: "Jeff Handley"
---
<!-- more -->
<p>With our <a title="Download WCF RIA Services V1.0" href="http://go.microsoft.com/fwlink/?LinkId=205085" target="_blank">WCF RIA Services V1.0 SP1 Beta</a> release, we have a known installation issue that we wanted to call out.  In actuality, the issue is not with our SP1 installer, but with our V1.0 RTM installer, but it doesn't surface until you've installed SP1.</p>  <p>To get right to the point: If you have WCF RIA Services V1.0 <em>SP1</em> installed, <strong><em>do not </em></strong>attempt to install WCF RIA Services V1.0 <em>RTM</em>.  If you do, you will find yourself in this strange scenario where <strong><em>both</em></strong> V1.0 RTM and V1.0 SP1 appear to be installed.  What you really have is a union of the two versions installed, with V1.0 RTM taking over as the installed assemblies.</p>  <p>If you get into this mode, <u>you must uninstall V1.0 RTM and then uninstall V1.0 SP1</u>, and re-install the desired version.</p>  <p>The cause for this is that the V1.0 installer did not handle upgrade scenarios, instead we blocked the installation if you attempted to install a new version of the product.  However, here's the ironic part... with the SP1 Beta release, we switched to a mode where our installer supports upgrades, and the two approaches don't work together.  In effect, V1.0 SP1 is treated as a different product, and V1.0 RTM cannot block its installation.  We of course cannot go back and fix the already-released V1.0 RTM installer, so we have to accept this as a known issue.</p>  <p>Related to this issue, please go check out <a title="Dan Liu: Install WCF RIA Services v1.0 SP1 Beta - missing Silverlight 4 developer runtime?" href="http://blogs.msdn.com/b/danliuatms/archive/2010/11/12/install-wcf-ria-services-v1-0-sp1-beta-missing-silverlight-4-developer-runtime.aspx" target="_blank">Dan Liu's blog post</a> that talks about the Silverlight Developer Runtime getting stomped over by Windows Update.  If you have installed WCF RIA Services V1.0 SP1 Beta, and then you lose your Silverlight Developer Runtime, and you go install the Silverlight 4 Tools (which includes RIA Services V1.0 RTM), you can find yourself in the scenario I outlined above.</p>  <p>This was a conscious trade-off that we made with SP1 and we do not plan to address this issue for V1.0 SP1 RTM.  Our installer is now upgrade-friendly though, so we do not expect this kind of issue to reoccur as we look toward V2+.</p>
