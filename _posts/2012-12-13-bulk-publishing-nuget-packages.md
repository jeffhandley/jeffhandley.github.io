---
layout: post
title: "Bulk Publishing NuGet Packages"
date: 2012-12-13 18:42:03 -0800
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.com/archive/2012/12/13/Bulk-Publishing-NuGet-Packages", "http://jeffhandley.com/archive/2012/12/13/bulk-publishing-nuget-packages"]
author: 0
---
<!-- more -->
<p>One of the responsibilities I have come to own is our group’s NuGet package publishing.  My group owns all of the ASP.NET MVC, Web API, Web Pages, Razor, and SignalR packages, among others; and there are quite a few of them.  When it’s time to publish a set of packages, we go through a bit of a dance:</p>  <ol>   <li>Gather all of the packages that are going to be published together into a single location      <ol>       <li>We have packages that are built out of different repositories that need to be brought together </li>        <li>Each team that has packages to be published as part of a larger release will put their packages into a designated TFS folder (don’t judge, but TFS is perfect for this)</li>        <li>Then, when we have QA sign-off on all of the packages, we will publish them all from that folder </li>     </ol>   </li>    <li>Upload all of the packages to nuget.org, but then immediately mark them as unlisted </li>    <li>When all of the other release assets are ready, and we’re ready to “flip the switch,” list all of the packages </li> </ol>  <p>To make this process smooth, I have created a few PowerShell functions that I use each time.  These are wrapped up in a PowerShell module so that I can easily reuse them.  Here is the repository for the module:    <br /><a title="https://github.com/jeffhandley/JeffHandley.NuGetPS" href="https://github.com/jeffhandley/JeffHandley.NuGetPS">https://github.com/jeffhandley/JeffHandley.NuGetPS</a></p>  <p>Within that repository, the <a href="https://github.com/jeffhandley/JeffHandley.NuGetPS/blob/master/NuGetPackagePublishing.psm1">NuGetPackagePublishing.psm1</a> file exports the following functions.</p>  <h2>Submit-Package</h2>  <pre>NAME
    Submit-Package

SYNOPSIS
    Submits a NuGet package (or set of packages) to the gallery, but as hidden (unlisted).


SYNTAX
    Submit-Package [-packageId &lt;Object&gt;] [-packageVersion &lt;Object&gt;] [-packageFile &lt;Object&gt;] [-apiKey &lt;Object&gt;]
    [-galleryUrl &lt;Object&gt;] [&lt;CommonParameters&gt;]

    Submit-Package [-packagesConfig &lt;Object&gt;] [-apiKey &lt;Object&gt;] [-galleryUrl &lt;Object&gt;] [&lt;CommonParameters&gt;]


DESCRIPTION
    Uploads the specified package (or all packages from a packages.config file) to the gallery and then immediately
    marks the package(s) as unlisted by running the nuget delete command.


RELATED LINKS

REMARKS
    To see the examples, type: "get-help Submit-Package -examples".
    For more information, type: "get-help Submit-Package -detailed".
    For technical information, type: "get-help Submit-Package -full".</pre>

<h2>Hide-NuGetPackage</h2>

<pre>NAME
    Hide-NuGetPackage

SYNOPSIS
    Hides a package from the NuGet gallery


SYNTAX
    Hide-NuGetPackage [-packageId &lt;Object&gt;] [-packageVersion &lt;Object&gt;] [-apiKey &lt;Object&gt;] [-galleryUrl &lt;Object&gt;]
    [&lt;CommonParameters&gt;]

    Hide-NuGetPackage [-packagesConfig &lt;Object&gt;] [-apiKey &lt;Object&gt;] [-galleryUrl &lt;Object&gt;] [&lt;CommonParameters&gt;]


DESCRIPTION
    Marks the specified NuGet package as unlisted, hiding it from the gallery.


RELATED LINKS

REMARKS
    To see the examples, type: "get-help Hide-NuGetPackage -examples".
    For more information, type: "get-help Hide-NuGetPackage -detailed".
    For technical information, type: "get-help Hide-NuGetPackage -full".</pre>

<h2>Show-NuGetPackage</h2>

<pre>NAME
    Show-NuGetPackage

SYNOPSIS
    Shows a package on the NuGet gallery, listing an already-published but unlisted package.


SYNTAX
    Show-NuGetPackage [-packageId &lt;Object&gt;] [-packageVersion &lt;Object&gt;] [-apiKey &lt;Object&gt;] [-galleryUrl &lt;Object&gt;]
    [&lt;CommonParameters&gt;]

    Show-NuGetPackage [-packagesConfig &lt;Object&gt;] [-apiKey &lt;Object&gt;] [-galleryUrl &lt;Object&gt;] [&lt;CommonParameters&gt;]


DESCRIPTION
    Marks the specified NuGet package as listed, showing it on the gallery.


RELATED LINKS

REMARKS
    To see the examples, type: "get-help Show-NuGetPackage -examples".
    For more information, type: "get-help Show-NuGetPackage -detailed".
    For technical information, type: "get-help Show-NuGetPackage -full".</pre>

<h2>Set-NuGetPackageVisibility</h2>

<pre>NAME
    Set-NuGetPackageVisibility

SYNOPSIS
    Sets a package's visibility within the NuGet gallery


SYNTAX
    Set-NuGetPackageVisibility [-action &lt;Object&gt;] [-packageId &lt;Object&gt;] [-packageVersion &lt;Object&gt;] [-apiKey &lt;Object&gt;]
    [-galleryUrl &lt;Object&gt;] [&lt;CommonParameters&gt;]

    Set-NuGetPackageVisibility [-action &lt;Object&gt;] [-packagesConfig &lt;Object&gt;] [-apiKey &lt;Object&gt;] [-galleryUrl &lt;Object&gt;]
    [&lt;CommonParameters&gt;]


DESCRIPTION
    Hide (unlist) a package from the gallery or show (list) a package on the gallery.


RELATED LINKS

REMARKS
    To see the examples, type: "get-help Set-NuGetPackageVisibility -examples".
    For more information, type: "get-help Set-NuGetPackageVisibility -detailed".
    For technical information, type: "get-help Set-NuGetPackageVisibility -full".</pre>

<h1> </h1>

<h1>Ship It!</h1>

<p>With the above module imported, by using PowerShell's Import-Module command, I can then very easily take a directory of NuGet packages and publish them all at once. There's still a little bit that I don't have automated, and that is creating a packages.config file to use as a parameter to the functions. To do that, my process is presently to do the following:</p>

<ol>
  <li> In Windows Explorer, select all of the files </li>

  <li>Shift+Right-Click and choose "Copy as Path" </li>

  <li>Paste the paths into a text editor like Sublime Text </li>

  <li>Use search/replace to change the file paths into a packages.config file format </li>
</ol>

<p>
Here is the regular expression that proves to be handy:<br />
Find: ^"{root file path}\\(\w\w\w)\\([\D]*[a-zA-Z])\.([\w\.\-]*)\.nupkg"$<br />
Replace: &lt;package culture="$1" id="$2" version="$3" /&gt;
</p>

<p>For the packages I published a few minutes ago, the packages.config file looks like this:</p>

<blockquote>
  <pre>&lt;packages&gt;
    &lt;package id="Microsoft.Owin.Host.SystemWeb" version="1.0.0-rc1" /&gt;
    &lt;package id="Microsoft.AspNet.FriendlyUrls" version="1.0.0-rc1" /&gt;
    &lt;package id="Microsoft.AspNet.FriendlyUrls.ViewSwitcher" version="1.0.0-rc1" /&gt;
    &lt;package id="Microsoft.AspNet.Mvc.Facebook" version="0.3.0-rc" /&gt;
    &lt;package id="Microsoft.AspNet.SignalR" version="1.0.0-rc1" /&gt;
    &lt;package id="Microsoft.AspNet.SignalR.Client" version="1.0.0-rc1" /&gt;
    &lt;package id="Microsoft.AspNet.SignalR.Core" version="1.0.0-rc1" /&gt;
    &lt;package id="Microsoft.AspNet.SignalR.Hosting.Utils" version="1.0.0-rc1" /&gt;
    &lt;package id="Microsoft.AspNet.SignalR.JS" version="1.0.0-rc1" /&gt;
    &lt;package id="Microsoft.AspNet.SignalR.Owin" version="1.0.0-rc1" /&gt;
    &lt;package id="Microsoft.AspNet.SignalR.Redis" version="1.0.0-rc1" /&gt;
    &lt;package id="Microsoft.AspNet.SignalR.ServiceBus" version="1.0.0-rc1" /&gt;
    &lt;package id="Microsoft.AspNet.SignalR.SystemWeb" version="1.0.0-rc1" /&gt;
    &lt;package id="Microsoft.AspNet.SignalR.Utils" version="1.0.0-rc1" /&gt;
    &lt;package id="Microsoft.AspNet.WebApi.HelpPage" version="0.3.0-rc" /&gt;
    &lt;package id="Microsoft.AspNet.WebApi.HelpPage.VB" version="0.3.0-rc" /&gt;
    &lt;package id="Microsoft.AspNet.WebApi.OData" version="0.3.0-rc" /&gt;
    &lt;package id="Microsoft.AspNet.WebApi.Tracing" version="0.3.0-rc" /&gt;
&lt;/packages&gt;</pre>
</blockquote>

<p />

<p>Once I have that packages.config (which I also check into the TFS repository with the packages), I can then run the following two commands:</p>
  <ol>
    <li><b>Upload the packages as unlisted</b><br />Submit-Package -packagesConfig packages.config -apiKey &lt;apikey&gt;<br /><br /></li>
    <li><b>List the packages that have already been uploaded</b><br />Show-NuGetPackage -packagesConfig packages.config -apiKey &lt;apikey&gt;</li>
  </ol>

<p>
That's it. Now, with only 18 packages being published, this might seem like overkill. However, for the RTM release ASP.NET MVC 4, Web Pages 2, etc., we had 491 NuGet packages that were published! With that volume, having the process scripted out like this was crucial. And now I like to follow the same process regardless of the number of packages. If you too have lots of NuGet packages that you publish and you want to simplify your process, feel free to grab the <a href="https://github.com/jeffhandley/JeffHandley.NuGetPS/blob/master/NuGetPackagePublishing.psm1">NuGetPackagePublishing.psm1</a> file and use it within your process. 
</p>
<h1>Other Tips</h1>
<p>
Here are some other tips to help with your NuGet Publishing:
</p>
<ol>
<li>nuget.exe push accepts wildcards.  That means you can run nuget.exe push *.nupkg to publish all nupkg files in a folder.<br />I don't use this approach because my process typically involves uploading as unlisted and then listing the packages later.  In order to do that, I need to have the package Id and Version, which is why I have the packages.config file approach.</li>
<li>nuget.exe delete will unlist a package.  You may have noticed this from my process above, but it's a little-known feature.</li>
<li>nuget.org supports POST and DELETE operations for a package, allowing you to set the package's visibility through a simple web request.  The URL for the web request is https://nuget.org/api/v2/Package/&lt;packageId&gt;/&lt;packageVersion&gt;?apiKey=&lt;apiKey&gt;.  You can see this in use within the SetVisibility method in the NuGetPackageVisibility.psm1 file.
</li></ol>

