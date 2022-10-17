---
layout: post
title: "RIA Services Silverlight NuGet Packages"
date: 2013-07-15 22:21:05 -0700
comments: true
tags: ["RIAServices"]
redirect_from: ["/archive/2013/07/15/ria-services-silverlight-nuget-packages.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p>As we look forward to the <a title="RIA Services is Getting Open-Sourced" href="http://jeffhandley.com/archive/2013/07/03/ria-services-is-getting-open-sourced.aspx" target="_blank">Open RIA Services project</a>, we want to make sure we’re helping lay out a transition for those that desire to make the switch.  As part of that transition plan, we have just published 2 new NuGet packages for RIA Services: the Silverlight Client and the Silverlight DomainDataSource control.  These packages can be used instead of adding references from the WCF RIA Services MSI installation.  By referencing these libraries via NuGet instead of from the MSI, you’ll be better poised to switch to Open RIA Services packages when they exist, and you’ll have fewer dependencies on the bits included in the MSI.</p>  <p>These two Silverlight NuGet packages round out the NuGet-based offering of RIA Services.  We now have the server-side and Silverlight client-side libraries all available, allowing you to build RIA Services applications without needing the MSI installed on your machine.  To see all of the packages we’ve published, you can view the profile page for the ‘riaservices’ user on nuget.org at <a href="https://nuget.org/profiles/riaservices/">https://nuget.org/profiles/riaservices/</a>.</p>  <h2>RIAServices.Silverlight</h2>  <p>RIAServices.Silverlight provides the System.ServiceModel.DomainServices.Client and System.ServiceModel.DomainServices.Client.Web assemblies for your Silverlight projects.</p>  <p><a href="https://nuget.org/packages/RIAServices.Silverlight/">https://nuget.org/packages/RIAServices.Silverlight/</a></p>  <h2>RIAServices.Silverlight.DomainDataSource</h2>  <p>RIAServices.Silverlight.DomainDataSource provides the DomainDataSource control for Silverlight, providing a declarative model for binding UI controls to a DomainContext.</p>  <p><a title="https://nuget.org/packages/RIAServices.Silverlight.DomainDataSource/" href="https://nuget.org/packages/RIAServices.Silverlight.DomainDataSource/">https://nuget.org/packages/RIAServices.Silverlight.DomainDataSource/</a></p>    <p><strong><font color="#d26941" face="Arial Narrow"> </font></strong></p>
