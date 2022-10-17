---
layout: post
title: "I Get NuGet. You Get NuGet?"
date: 2011-08-11 07:28:25 -0700
comments: true
tags: ["RIAServices", "NuGet"]
redirect_from: ["/archive/2011/08/11/IGetNuGet-YouGetNuGet.aspx/", "/archive/2011/08/11/igetnuget-yougetnuget.aspx"]
author: "Jeff Handley"
---
<!-- more -->
<h5>Hello, my name is Jeff, and I am addicted to NuGet.</h5>  <p> </p>  <p>I firmly believe NuGet is one of the best things to come out of Microsoft in a long time, or maybe ever.  NuGet has already transformed the way the RIA Services team releases software.  Now it’s starting to change the way we build our features.  I can envision lots of clever ways to utilize NuGet, but before going crazy, I want a sanity check.</p>  <p><em>tl;dr: Should we go hog-wild with NuGet, or should we keep our focus on the MSI?</em></p>  <h3>Releasing Software</h3>  <p>Starting at MIX11, the RIA Services team published a set of NuGet packages.  These packages contained features that have traditionally been included in our RiaServicesToolkit.msi, but NuGet allows us to break the single Toolkit up into several distinct pieces.</p>  <ul>   <li><a href="http://nuget.org/List/Packages/RIAServices.Endpoints">RIAServices.Endpoints</a> - Includes the SOAP and JSON endpoints </li>  <li><a href="http://nuget.org/List/Packages/RIAServices.jQuery">RIAServices.jQuery</a> - Includes the preview for our JavaScript/jQuery client </li>  <li><a href="http://nuget.org/List/Packages/RIAServices.ViewModel">RIAServices.ViewModel</a> - Silverlight ViewModel (MVVM) features </li>  <li><a href="http://nuget.org/List/Packages/RIAServices.T4">RIAServices.T4</a> - T4 Code Generation </li>  <li><a href="http://nuget.org/List/Packages/RIAServices.WindowsAzure">RIAServices.WindowsAzure</a> - TableDomainService for Windows Azure Table Storage support </li>  <li><a href="http://nuget.org/List/Packages/RIAServices.EntityFramework">RIAServices.EntityFramework</a> - DbDomainService for EntityFramework 4.1 support (including EF Code First)   <ul>   <li>Note - the EntityFramework June 2011 CTP is NOT supported</li>   </ul>   </li>  <li><a href="http://nuget.org/List/Packages/RIAServices.Toolkit.All">RIAServices.Toolkit.All</a> - Includes all of the above NuGet packages except ViewModel - as that's the only Silverlight-targeted package and including it was causing problems for folks trying to apply the Toolkit.All package to a .NET project.</li> </ul>  <p>All of these features can still be found in the RiaServicesToolkit.msi, in case you’d prefer to go that route.  The Toolkit MSI still contains a couple of features not available via NuGet.</p>  <ul>   <li>Linq to Sql support (LinqToSqlDomainService) - This feature requires the addition of a registry key in order for the Domain Service Wizard (Add New Item… Domain Service) to recognize a Linq to Sql DataContext.  If there is demand for adding a NuGet package for this, we could do it and add the registry key using an Install.ps1 script, but I’d feel awfully dirty doing that. </li>  <li>ASP.NET DomainDataSource and DomainValidator - These features require VS integration through design-time components, and there presently isn’t a good way to install these bits through NuGet.</li> </ul>  <p>When we introduced the NuGet packages, we planned on always keeping the RiaServicesToolkit.msi and the NuGet packages in sync.  Needless to say this costs us extra time, but it allows developers to either install the MSI and get all of the Toolkit bits or reference the NuGet packages and get only the pieces they need.  We broke this rule when we introduced Entity Framework Code-First support though<sup>1</sup>.  We first published RIAServices.EntityFramework as a NuGet package, without also updating the Toolkit.  That happened because we had other code in flux in the Toolkit that wasn’t ready to ship, but we wanted to get the EF Code First support out as soon as possible.  It was a piece of cake to publish one feature without having to publish everything.  For the August 2011 drop, we added that new feature into the Toolkit and refreshed everything.</p>  <p><em><sup>1 </sup>It was telling to me that the 2nd time publishing NuGet packages, we broke our rule of keeping them in sync with the MSI because shipping via NuGet was easier.</em></p>  <h3>Building Features</h3>  <p>As we started building out RIA/JS, we targeted NuGet from the get-go.  Our RIAServices.jQuery package depends on jQuery, which allows our scripts to rely on jQuery without us having to ship jQuery or instruct developers on how to get it.  This is a brilliant (yet subtle) benefit.</p>  <p>The team is currently working on some new features that are all being factored for NuGet packages.  We could very well have put the features into existing assemblies in the Toolkit and refreshed the MSI.  Instead, we’re introducing new assemblies so that we can wrap NuGet packages around them and ship them standalone<sup>2</sup>.  The MSI suffers a bit because it now has extra assemblies to include, and that means you add more references.  But it also gives us flexibility to release features individually, rather than waiting months for other (perhaps unrelated) features to be ready.</p>  <p><em><sup>2 </sup>We used to <strong>really</strong> hesitate when creating new assemblies.  Now it’s starting to feel like the default approach.</em></p>  <h3>I Get NuGet</h3>  <p>Especially with the RIA/JS work we’re doing, we’re thinking of using NuGet quite a bit.  Here are some ideas for how we could leverage this new tool.</p>  <ol>   <li><strong>Samples.</strong>  I love how there’s an EntityFramework package and an EntityFramework.Sample package.  We can use this same approach for demonstrating how to use RIA Services with EF Code First and how to build an HTML/JavaScript client on top of your Domain Services.  <br /></li>  <li><strong>Opt-In Features.</strong> We’re already doing this with the RIAServices.T4 package.  When you want to turn and use a feature in your application, you just reference another package and everything gets set up for you.  Another example where we’re already doing this is with the RIAServices.Endpoints and RIAServices.jQuery packages.  RIAServices.Endpoints modifies your web.config to turn on the JSON and SOAP endpoints, and RIAServices.jQuery updates the JSON endpoint registration to transmit metadata.  <br />  <br />I can imagine breaking our product and toolkit up further than we have today. When we introduced Complex Type support in SP1, we were fearful that some applications might inadvertently get opted in to the feature when you expected the types to be excluded. Imagine a world where every new feature is opt-in by way of a NuGet package. We could stop worrying about accidentally breaking people when we add features that are on by default.  <br /></li>  <li><strong>Tooling.</strong>  RIAServices.EntityFramework added EF Code-First support at runtime, but it doesn’t have Domain Service Wizard support.  Soon after we published this package, <a href="http://larud.net/blog/">Rudi Larno</a> (<a href="https://twitter.com/#!/rlarno">@rlarno</a>) cranked out another package that added <a href="http://larud.net/Blog/archive/2011/07/04/simple-wcf-ria-services-ef-4-1-scaffolding.aspx">scaffolding for your domain services</a>.  What if the NuGet PowerShell command window became the primary way to do iterative development with RIA Services?</li> </ol>  <p>I could go on and on with specifics, but those themes give you an idea of where I can see things going.  But this is where I want to stop and as you, am I taking this too far?</p>  <h3>You Get NuGet?</h3>  <p>Here are some specific questions I’d love to hear answers to.</p>  <ol>   <li>Do you like having the WCF RIA Services Toolkit MSI, or could we dump it and just ship Toolkit features exclusively on NuGet?</li>  <li>Should we start limiting what goes into the “product” MSI (RiaServices.msi) and favor NuGet packages for new product features?</li>  <li>What quality level do you expect from NuGet packages?</li>  <li>How would you like to see us differentiate preview-quality packages from fully baked packages?</li>  <li>Do you prefer granular packages or monolithic ones, or a combination of the two?</li>  <li>Is the PowerShell console a blocker for you? (Do you prefer windows and buttons in VS, or is a text-based console acceptable?)</li>  <li>What do you think of using NuGet for (temporarily) adding sample code to you project to help you learn a product or feature?</li>  <li>How do you know what NuGet packages to look for?  Do you already know the package exists, or are you searching NuGet for neat new things?</li>  <li>Do you expect some package mash-ups to conflict and cause you pain, or do you expect every NuGet package to interact with every other NuGet package seamlessly?</li> </ol>  <p>If you tell me I’m taking NuGet too far, then I won’t really accuse of you not getting NuGet.  Maybe I’m off my rocker.  That’s why I’m asking you.  Should we fully embrace NuGet and find clever ways to use it, or should we keep our focus on the MSI?</p>
