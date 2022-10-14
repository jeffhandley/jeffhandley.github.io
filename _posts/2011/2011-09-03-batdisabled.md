---
layout: post
title: "Business Application Project Login / Registration Disables Everything"
date: 2011-09-03 22:42:56 -0700
comments: true
tags: ["RIAServices", "Silverlight"]
redirect_from: ["/archive/2011/09/03/BATDisabled.aspx/", "/archive/2011/09/03/batdisabled.aspx"]
author: "Jeff Handley"
---
<!-- more -->
<p>There is a known issue with WCF RIA Services V1.0 SP2 RC’s Business Application project template.  The issue only surfaces in Silverlight 5, and there’s an easy way to fix it.  We determined the root cause of this issue after it was too late to fix it in time for the RC release, but the correction is in place for the RTW (final) release of SP2.</p>  <p>This bug surfaces after you create a new project after installing RIA Services SP2, using the Business Application project template, and then an end user registers or logs in.  After completing the registration/login process, the entire application is disabled.  You can see the Home, About, and logout buttons are disabled, and nothing is clickable.</p>  <p><a href="/img/postimages/84403f50f45e_D26D/image_2.png" rel="lightbox"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="/img/postimages/84403f50f45e_D26D/image_thumb.png" width="215" height="87" /></a></p>  <p>If you change the project to target Silverlight 4, the problem goes away.  This made us think the problem was in the Silverlight runtime or SDK, but after the Silverlight team investigated it, the root cause ended up being in the project template within the code we put in place to help you get started.</p>  <p>It boils down to the LoginRegistrationWindow.xaml.cs file that is included in the template under the Views\Login folder in the Silverlight project.  Within that file, the OnOpened method from ChildWindow is overridden:</p>

