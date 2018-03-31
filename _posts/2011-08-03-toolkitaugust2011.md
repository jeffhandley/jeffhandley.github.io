---
layout: post
title: "WCF RIA Services Toolkit (August 2011) - And Updated NuGet Packages"
date: 2011-08-03 03:53:00 -0700
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.com/archive/2011/08/02/ToolkitAugust2011", "http://jeffhandley.com/archive/2011/08/02/toolkitaugust2011"]
author: 0
---
<!-- more -->
<p>The RIA Services team published the <a title="WCF RIA Services Toolkit (August 2011)" target="_blank" href="http://www.microsoft.com/downloads/details.aspx?FamilyID=be343a68-d938-466e-860c-f98ca2eabfc5">August 2011 edition of the Toolkit</a> tonight.  We also refreshed all of our NuGet packages:</p>
<ul>
    <li><a target="_blank" href="http://nuget.org/List/Packages/RIAServices.Endpoints">RIAServices.Endpoints</a> - Includes the SOAP and JSON endpoints </li>
    <li><a target="_blank" href="http://nuget.org/List/Packages/RIAServices.jQuery">RIAServices.jQuery</a> - Includes the preview for our JavaScript/jQuery client </li>
    <li><a target="_blank" href="http://nuget.org/List/Packages/RIAServices.ViewModel">RIAServices.ViewModel</a> - Silverlight ViewModel (MVVM) features </li>
    <li><a target="_blank" href="http://nuget.org/List/Packages/RIAServices.T4">RIAServices.T4</a> - T4 Code Generation </li>
    <li><a target="_blank" href="http://nuget.org/List/Packages/RIAServices.WindowsAzure">RIAServices.WindowsAzure</a> - TableDomainService for Windows Azure Table Storage support </li>
    <li><a target="_blank" href="http://nuget.org/List/Packages/RIAServices.EntityFramework">RIAServices.EntityFramework</a> - DbDomainService for EntityFramework 4.1 support (including EF Code First)
    <ul>
        <li>Note - the EntityFramework June 2011 CTP is NOT supported </li>
    </ul>
    </li>
    <li><a target="_blank" href="http://nuget.org/List/Packages/RIAServices.Toolkit.All">RIAServices.Toolkit.All</a> - Includes all of the above NuGet packages except ViewModel - as that's the only Silverlight-targeted package and including it was causing problems for folks trying to apply the Toolkit.All package to a .NET project.</li>
</ul>
<h2>What’s the difference?</h2>
<p>We have both the RiaServicesToolkit.msi and the NuGet packages, so what’s the difference?  Generally speaking, there is no difference other than the ship vehicles.  We’re starting to favor NuGet over the Toolkit MSI for distributing our Toolkit components.  I would love to hear your thoughts on the pros/cons of each though!  With tonight’s releases, everything available via NuGet is also available as a component within the Toolkit MSI.</p>
<p>There are some MSI features that are <em>not</em> available via NuGet though:</p>
<ul>
    <li>Linq to Sql support (LinqToSqlDomainService) - This feature requires the addition of a registry key in order for the Domain Service Wizard (Add New Item… Domain Service) to recognize a Linq to Sql DataContext.  If there is demand for adding a NuGet package for this, we could do it and add the registry key using an Install.ps1 script, but I’d feel awfully dirty doing that. </li>
    <li>ASP.NET DomainDataSource and DomainValidator - These features require VS integration through design-time components, and there presently isn’t a good way to install these bits through NuGet. </li>
</ul>
<p>Otherwise, tonight’s release gets the Toolkit and the NuGet packages in sync.</p>
<h2>What was updated?</h2>
<p>There are two note-worthy changes in tonight’s release:</p>
<ol>
    <li>EntityFramework 4.1 support was added to the Toolkit via the Microsoft.ServiceModel.DomainServices.EntityFramework assembly.  Previously, this was only available via the RIAServices.EntityFramework NuGet package, but it’s now rolled into the Toolkit MSI as well. </li>
    <li>JavaScript/jQuery client (RIA/JS) updates.  These updates are in both the Toolkit MSI and the RIAServices.jQuery NuGet package.  When we first released this preview (and yes, it’s still in early preview form), it only worked with jQuery 1.4.4.  Now it works with jQuery 1.5.1+ (including 1.6.1).  There has been quite a bit of code refactoring and preparation for many new features. </li>
</ol>
<p>There were also quite a few bug fixes.  We fixed bugs in our EF Code First support, in the ViewModel features, and other various places.  Nothing comes to mind as being very noteworthy though.</p>
<p>Lastly, we also updated the NuGet packages to include and require a license acceptance upon reference into your project.  Exciting, huh?</p>
<p>I do think the RIA/JS support for the latest version of jQuery is worth grabbing the new bits for.  I know many of you were hit by our 1.4.4-specific targeting, so you should now be unblocked.  We’ve been working very closely with the jQuery team to ensure that the data observability model we use is jQuery-friendly (of not endorsed), and there was a <em>lot</em> of work put into RIA/JS to get us poised for developing more features and richness into the client while ensuring we fit nicely into the jQuery ecosystem.</p>
<h2>Is this for SP1 or SP2?</h2>
<p>The updated Toolkit and NuGet packages work with both WCF RIA Services V1.0 SP1 and SP2, with one exception: the JavaScript client (RIA/JS).  RIA/JS requires SP2.</p>
<h2>Forums</h2>
<p>As always, if you have questions or problems, I recommend you jump over to the <a target="_blank" href="http://jeffh.me/riaforums">forums</a>.</p>

