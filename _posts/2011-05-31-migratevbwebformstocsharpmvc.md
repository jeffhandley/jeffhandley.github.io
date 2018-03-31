---
layout: post
title: "Out with the Old and in with the New (Gradually migrating ASP.NET from VB Web Forms to C# MVC/Razor)"
date: 2011-05-31 11:07:05 -0700
comments: true
category: Archive
tags: []
redirect_from: ["/archive/2011/05/31/MigrateVBWebFormsToCSharpMVC.aspx/", "/archive/2011/05/31/migratevbwebformstocsharpmvc.aspx"]
author: 0
---
<!-- more -->
<p>I have a web application that I have been tinkering with for years – about 6 years; it’s built in ASP.NET Web Forms with VB.  Every so often, I jump into this app and create some new features or fix some bugs, and over the past few years I’ve been itching to get it converted over to C# and ASP.NET MVC.  But the application has about 100 screens (distinct views – often a single ASPX will have multiple screens) and there are tens of thousands of lines of Web Forms event-driven code, so I’ve been intimidated by the idea of a rewrite.  This weekend though, I wanted to integrate a fancy new UI design for the application – one that is so drastically different from the old that I will <em>have to </em>touch every screen.  With this ahead of me, I decided to embark upon finding a way to start a migration to the new and fun style of web application development: ASP.NET MVC with C# and the Razor syntax.</p>
<h3>Existing Application Characteristics</h3>
<p>Again, the existing code is Web Forms and it’s your average Joe’s Web Forms coding style: event-driven forms with &lt;asp:Placeholder&gt; tags, stateful &lt;asp:Textbox&gt; controls, Session usage, Forms Authentication, etc. I would bet that this application is representative of how 95% of developers created their Web Forms apps.</p>
<ol>
    <li>Project Type: <strong>Web Application Project (Web Forms)</strong> </li>
    <li>Language: <strong>VB</strong> (although other referenced projects such as the data layer are in C#) </li>
    <li>Forms Authentication </li>
    <li>Reliant upon Session state </li>
    <li>Standard, event-driven Web Forms implementation </li>
    <li>Lots of &lt;table&gt; tags and otherwise poor HTML design </li>
    <li>Virtually no AJAX or other client-side script (clue: the app references jQuery 1.2.6) </li>
    <li>Hosted in IIS, even locally during development </li>
</ol>
<h3>Desired Characteristics for New Development</h3>
<p>As I create new screens in the application, I want to migrate to a new setup.  Just as I’ve opportunistically deleted Stored Procedures over the last few years, replacing them with LINQ-based code, I want to gradually shift away from VB/Web Forms into the new world.</p>
<ol>
    <li>Project Type: <strong>ASP.NET MVC3 Application</strong> </li>
    <li>Language: <strong>C#</strong> </li>
    <li>View Engine: Razor (cshtml) </li>
    <li>Many fewer &lt;table&gt; tags (although I think they still have their time and place) and a better HTML design throughout </li>
    <li>A lot more client-side script based on the latest and greatest in the jQuery world </li>
</ol>
<h3>Ground Rules</h3>
<p>Because I have a pretty large existing application, there were some ground rules for the introduction of MVC.  </p>
<ol>
    <li>Existing screens must continue to work as-is </li>
    <li>New screens recognize the same auth token as the existing app </li>
    <li>New screens created using C# controllers with cshtml (Razor) views </li>
    <li>All of the awesome MVC 3 tooling needs to work when working in the MVC bits </li>
    <li>Controllers will need to access the same Session state used by the legacy Web Forms screens </li>
    <li>The MVC app should remain sanitized, free of artifacts specific to this strange legacy hybrid setup.  Perhaps one day everything will get migrated over… if so, I should just be able to cut the cord and have a clean MVC app. </li>
</ol>
<h3>Things I tried that ultimately failed</h3>
<p>While the end solution that I’ll illustrate in a moment is insanely simple, it wasn’t the first thing I tried.  Along the way, I considered a few other approaches that all failed.</p>
<ol>
    <li><em>Having the MVC application as a “sub web” where a new Application is hosted under either a physical or virtual directory</em> <br />
    This ultimately failed because I couldn’t get session state shared between the two applications.  I went as far as starting to move session state to SqlServer model, but decided that was just too drastic of a change. </li>
    <li><em>Compiling the MVC application into the bin folder of the Web Forms application</em> <br />
    I didn’t go far with this because I realized I have two global.asax files, and this just wasn’t going to work for several other reasons too. </li>
    <li><em>Creating the MVC application as an entirely new site in IIS, and using a subdomain to differentiate</em> <br />
    I considered this but didn’t even start, because A) the session state issue would still be there, and B) any SSL certificates would be invalid. </li>
</ol>
<h3>Super Simple Solution</h3>
<p>I can’t decide if I should be upset that I didn’t come up with the end solution right off the bat.  It’s not entirely obvious, but man was it simple.</p>
<ol>
    <li>Create a new MVC 3 Web Application project as a sibling to the existing Web Forms application.  This will yield a project structure like this: <br />
    <img style="BACKGROUND-IMAGE: none; BORDER-RIGHT-WIDTH: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; DISPLAY: inline; BORDER-TOP-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; PADDING-TOP: 0px" title="image" border="0" alt="image" width="222" height="125" src="http://jeffhandley.com/images/jeffhandley_com/Windows-Live-Writer/Out-with-the-Old-and-in-with-the-New-Gra_1EB6/image_784ae486-e9d9-406c-ac7b-5bdd7b0ba0e7.png" /> </li>
    <li>Open the Global.asax.cs file in the new MVC application and edit the routes. </li>
    <li>Add a fake folder name as a prefix to your controllers, so that no routes ever conflict with existing pages.  If you are worried about permalinks, consider how you will deal with this long term.  I chose the App folder as my prefix. </li>
    <li>Add the .aspx extension to your controllers.  This is only needed if hosting in a “Classic Mode” IIS application pool. <br />
    <pre>  public static void RegisterRoutes(RouteCollection routes)   {     routes.IgnoreRoute("{resource}.axd/{*pathInfo}");     routes.MapRoute(       "Default", // Route name       "App/{controller}.aspx/{action}/{id}", // URL with parameters        new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults     );   }<br /></pre>
    </li>
    <li>Build your new C# project </li>
    <li>Add a reference to this new C# project from within the Web application </li>
    <li>Open the Global.asax.vb file in the existing Web application </li>
    <li>Change the Inherits statement from HttpApplication to point to the MvcApplication class within the new MVC application. </li>
    <li>Delete the existing Application_Start method from the Global.asax.vb to avoid the name conflict.  If you have existing code in there, you can make the method in the MvcApplication class virtual, and then override it and call the base method within the override. </li>
</ol>
<p>Now, your code is ready to roll, but we have a little more work to do.  If you try browsing out to an MVC route within your Web Forms project, you’ll get a nasty error like this:</p>
<p><img style="BACKGROUND-IMAGE: none; BORDER-RIGHT-WIDTH: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; DISPLAY: inline; BORDER-TOP-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; PADDING-TOP: 0px" title="The view 'Index' or its master was not found or no view engine supports the searched locations. The following locations were searched:" border="0" alt="The view 'Index' or its master was not found or no view engine supports the searched locations. The following locations were searched:" width="644" height="244" src="http://jeffhandley.com/images/jeffhandley_com/Windows-Live-Writer/Out-with-the-Old-and-in-with-the-New-Gra_1EB6/image_e82d9e9c-8b6c-4f1a-86d9-e0658a3cfee2.png" /></p>
<p>This is happening because the View that the Home controller’s Index action is trying to render cannot be found.  The Views folder is within the MVC application, not the Web Forms (running) application, so that makes sense.  All we need to do is find a way to make the MVC Views folder available within the Web Forms app.  Let’s do that…  I am using IIS on the local machine to address the problem.  I suspect the same can be done with IIS Express, but I tried creating the virtual directories manually within the applicationhost.config file and it didn’t work.</p>
<ol>
    <li><em>Prerequisite: You need to have IIS installed and working on your machine</em> </li>
    <li>Open the project properties for the Web Forms application and go to the Web tab </li>
    <li>Change the “Servers” option to “Use a Local IIS Web server” and turn off “Use IIS Express” and click the Create Virtual Directory button </li>
</ol>
<p>Now we need to go add a couple of virtual directories to the Web Forms app, one for the Views folder and one for Content.  These are folders used within the MVC application that need to be rendered from the expected path but within the Web Forms application.</p>
<ol>
    <li>Open IIS from your start menu </li>
    <li>Navigate to the IIS Application that was created for the Web Forms application </li>
    <li>Right-click and Add Virtual Directory.  Name it “Views” and select the Views folder from the MVC application’s folder as the target. </li>
    <li>Create another Virtual Directory for “Content” in the same way, selecting the Content folder from the MVC application. </li>
</ol>
<p>At this point, everything is fully configured.  But something that kept tripping me up is that I need to rebuild the solution after updating IIS in order for ASP.NET to pick up the configuration changes.  So go back into Visual Studio and rebuild your solution.  You’re now done.</p>
<p>Now you can browse back to the same URL as before and see the marvelous Index page.</p>
<p><img style="BACKGROUND-IMAGE: none; BORDER-RIGHT-WIDTH: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; DISPLAY: inline; BORDER-TOP-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; PADDING-TOP: 0px" title="image" border="0" alt="image" width="529" height="181" src="http://jeffhandley.com/images/jeffhandley_com/Windows-Live-Writer/Out-with-the-Old-and-in-with-the-New-Gra_1EB6/image_42903c79-a9bc-454e-916e-807d840c34b6.png" /></p>
<h3>
<h3>Review</h3>
<p>While there are a bunch of steps involved to get this going, it really is simple once you set back and review.</p>
<ol>
    <li>Edit the routes in your MVC application so that they can work within the hosting application </li>
    <li>Add a reference to the MVC application from the Web Forms application </li>
    <li>Make the Web Forms application derive from the MVC application within Global.asax </li>
    <li>Using IIS, create virtual directories for the MVC Views and Content folders so that they can be found within the Web Forms application </li>
    <li>Rebuild the solution any time you reconfigure the virtual directories in IIS – this kept tripping me up, making me think the solution was flawed, but with remembering this step, it’s working great </li>
</ol>
<p>So far, I’m thrilled with the setup.  I’ve already migrated some screens over to MVC, but I am able to have the two working together really seamlessly.</p>
<div style="PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; DISPLAY: inline; FLOAT: none; PADDING-TOP: 0px" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:5f535e93-4f43-4e6e-9696-e8ab9e369f8f" class="wlWriterEditableSmartContent">Technorati Tags: <a rel="tag" href="http://technorati.com/tags/ASP.NET">ASP.NET</a>,<a rel="tag" href="http://technorati.com/tags/MVC">MVC</a>,<a rel="tag" href="http://technorati.com/tags/WebForms">WebForms</a>,<a rel="tag" href="http://technorati.com/tags/Razor">Razor</a></div>
</h3>

