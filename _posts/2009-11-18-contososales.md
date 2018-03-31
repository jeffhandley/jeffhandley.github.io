---
layout: post
title: "Building ContosoSales - The RIA Services Keynote Demo"
date: 2009-11-18 09:42:12 -0800
comments: true
tags: ["Silverlight", "RIAServices", "Visual Studio 2010"]
redirect_from: ["/archive/2009/11/18/contososales.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p>During <a href="http://weblogs.asp.net/scottgu/" target="_blank">Scott Guthrie</a>’s <a href="http://microsoftpdc.com/Sessions/KEY02" target="_blank">keynote at PDC09</a> <font size="1">(starting around 1:28:00)</font>, <a href="http://www.hanselman.com" target="_blank">Scott Hanselman</a> presented a demo that highlighted Visual Studio 2010, Silverlight 4, RIA Services, and lots of great new tooling that ties all of these products together.  I wanted to show you how you can build the same application using installations that are available today.</p>  <h4>Machine Setup</h4>  <p>You’ll need to <a href="http://go.microsoft.com/fwlink/?LinkID=151797" target="_blank">install Visual Studio 2010 Beta 2</a> if you haven't already.  If you have a previous release of RIA Services already installed, you’ll need to uninstall it before proceeding.  Please note that you want to keep the Silverlight 3 SDK installed though.  While you can only have one Silverlight runtime installed, Visual Studio 2010 Beta 2 installs the Silverlight 3 SDK for you and it should remain installed side-by-side with the Silverlight 4 SDK.</p>  <p>When you go to <a href="http://silverlight.net/riaservices">http://silverlight.net/riaservices</a>, you’ll be able to <a href="http://go.microsoft.com/fwlink/?LinkID=177508" target="_blank">install the Silverlight 4 Tools for Visual Studio 2010</a>.  With one installer, you get everything you need to build Silverlight 4 and RIA Services applications with Visual Studio 2010 Beta 2!</p>  <h4>Building the Solution</h4>  <p><em><a href="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image_2.png" rel="lightbox"><img style="border-right-width: 0px; margin: 0px 0px 0px 10px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="New Silverlight Applicatoin" border="0" alt="New Silverlight Applicatoin" align="right" src="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image_thumb.png" width="404" height="372" /></a>From here, I’m going to assume that you have SQL 2008 Express installed on your machine.  If you’re using SQL Standard or whatnot, please make the appropriate tweaks to the instructions.</em></p>  <p>Create a new solution using the “Silverlight Navigation Application” template.  Call it ContosoSales and be sure to create a directory for the solution.</p>  <p>When prompted, choose to host the Silverlight application in a new web application project (the default settings),  keep Silverlight 4 selected, and enable RIA Services.</p>  <br clear="all" />  <p><a href="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image4.png" rel="lightbox"><img style="border-right-width: 0px; margin: 0px 0px 0px 10px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="Add App_Data ASP.NET Folder" border="0" alt="Add App_Data ASP.NET Folder" align="right" src="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image4_thumb.png" width="404" height="162" /></a>We’re going to add an existing database file, so we need to add the App_Data folder to the Web project.  Once that folder is added, right-click on it and choose to add an existing item.  You’ll want to grab ContosoSales_Data.mdf from the <a href="http://jeffhandley.com/Files/ContosoSales_Data.mdf.zip" target="_blank">zip file posted here</a>, and that’s what you will add into the App_Data folder.</p>  <br clear="all" />  <p><a href="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image11.png" rel="lightbox"><img style="border-right-width: 0px; margin: 0px 0px 0px 10px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="Entity Data Model Wizard" border="0" alt="Entity Data Model Wizard" align="right" src="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image11_thumb.png" width="404" height="413" /></a>We can now create the Entity Framework model on top of our database.  Add a new ADO.NET Entity Data Model (found under the Data tab), called ContactModel.edmx.  Use the default settings to generate the model from the ContosoSales.mdf file.  Then select the 3 tables from the database (Store, StoreContact, Contact).  Change the model namespace to ContactModel.</p>  <br clear="all" />  <p>At this point, you’ll need to build your solution. </p>  <br clear="all" />  <p><a href="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image23.png" rel="lightbox"><img style="border-right-width: 0px; margin: 0px 0px 0px 10px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="Add New Domain Service Class" border="0" alt="Add New Domain Service Class" align="right" src="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image23_thumb.png" width="404" height="414" /></a> Now, we can add our Domain Service Class using the RIA Services Domain Service wizard (found under the Web tab).  Name the class ContactService.cs.</p>  <p>In the wizard, you’ll need to select all three of the entities and enable editing for Contact.  We also want to turn on ‘Generate associated classes for metadata.’</p>  <p><em>Note: During the keynote demo, we already had the metadata class in place so that we could have the attributes applied to it ahead of time, which is why we did this a little bit differently during the demo.  Using this wizard, RIA Services will add the necessary references to your project and add some entries in your web.config to configure the service.  You don’t have to use the wizard to create your Domain Service, but it helps get you going very quickly.</em></p>  <p>We now want to edit the metadata for our entities.  To keep things simple, we’ll use the single metadata file that was created from the wizard.  Edit ContactService.metadata.cs to have the following:</p>  <div id="codeSnippetWrapper">   <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px" id="codeSnippet">     <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">using</span> System.Collections.Generic;</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">using</span> System.ComponentModel.DataAnnotations;</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">using</span> System.Web.DomainServices;</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">namespace</span> ContosoSales.Web</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">{</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    [MetadataTypeAttribute(<span style="color: #0000ff">typeof</span>(Contact.ContactMetadata))]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    <span style="color: #0000ff">public</span> <span style="color: #0000ff">partial</span> <span style="color: #0000ff">class</span> Contact</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    {</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        <span style="color: #0000ff">internal</span> <span style="color: #0000ff">sealed</span> <span style="color: #0000ff">class</span> ContactMetadata</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        {</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> ContactID { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> ContactPhoto { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> IEnumerable&lt;StoreContact&gt; StoreContacts { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Required]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [StringLength(30, MinimumLength = 2)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Display(Name = <span style="color: #006080">"First Name"</span>)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> FirstName { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Required]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [StringLength(30, MinimumLength = 2)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Display(Name = <span style="color: #006080">"Last Name"</span>)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> LastName { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Required]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Range(10, 1000000, ErrorMessage = <span style="color: #006080">"{0} must be between $10 and $1,000,000"</span>)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Display(Name = <span style="color: #006080">"Sales Target"</span>)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> <span style="color: #0000ff">decimal</span> SalesTarget { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Required]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Display(Name = <span style="color: #006080">"Work Phone"</span>)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> WorkPhone { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    [MetadataTypeAttribute(<span style="color: #0000ff">typeof</span>(Store.StoreMetadata))]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    <span style="color: #0000ff">public</span> <span style="color: #0000ff">partial</span> <span style="color: #0000ff">class</span> Store</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    {</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        <span style="color: #0000ff">internal</span> <span style="color: #0000ff">sealed</span> <span style="color: #0000ff">class</span> StoreMetadata</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        {</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> StoreID { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Required]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> City { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Required]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Display(Name = <span style="color: #006080">"State/Province"</span>)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> StateProvince { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Display(Name = <span style="color: #006080">"Store Image"</span>)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> StoreImage { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Required]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Display(Name = <span style="color: #006080">"Store Name"</span>)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> StoreName { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Include]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> IEnumerable&lt;StoreContact&gt; StoreContacts { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    [MetadataTypeAttribute(<span style="color: #0000ff">typeof</span>(StoreContact.StoreContactMetadata))]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    <span style="color: #0000ff">public</span> <span style="color: #0000ff">partial</span> <span style="color: #0000ff">class</span> StoreContact</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    {</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        <span style="color: #0000ff">internal</span> <span style="color: #0000ff">sealed</span> <span style="color: #0000ff">class</span> StoreContactMetadata</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        {</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> StoreID { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> ContactID { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Required]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Position { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> Store Store { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            [Include]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">public</span> Contact Contact { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">}</pre>
<!--CRLF--></div>
</div>

<br />

<p>In this application, we actually only need to provide a single query for getting Stores, and a single update method for updating Contacts.  The DomainService class can be trimmed down to the following:</p>

<div id="codeSnippetWrapper">
  <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px" id="codeSnippet">
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">using</span> System.Data;</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">using</span> System.Linq;</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">using</span> System.Web.DomainServices.Providers;</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">using</span> System.Web.Ria;</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">namespace</span> ContosoSales.Web</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">{</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    [EnableClientAccess]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> ContactService : LinqToEntitiesDomainService&lt;ContosoSales_DataEntities&gt;</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    {</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        <span style="color: #0000ff">public</span> IQueryable&lt;Store&gt; GetStores()</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        {</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">return</span> from store <span style="color: #0000ff">in</span> <span style="color: #0000ff">this</span>.ObjectContext.Stores.Include(<span style="color: #006080">"StoreContacts"</span>).Include(<span style="color: #006080">"StoreContacts.Contact"</span>)</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">                   <span style="color: #0000ff">where</span> store.StateProvince == <span style="color: #006080">"CA"</span></pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">                   orderby store.StoreName</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">                   select store;</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        <span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> UpdateContact(Contact currentContact)</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        {</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            <span style="color: #0000ff">if</span> ((currentContact.EntityState == EntityState.Detached))</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            {</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">                <span style="color: #0000ff">this</span>.ObjectContext.AttachAsModified(currentContact, <span style="color: #0000ff">this</span>.ChangeSet.GetOriginal(currentContact));</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">            }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">}</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF--></div>
</div>

<p>
  <br /></p>

<p />

<p />

<p>We’re finished creating the Domain Service now, so we can go ahead and build the solution.  This will trigger the RIA Services code generation, ultimately allowing the Data Sources window to pick up our model.</p>

<p>We’re going to build the Silverlight application like most developers would, without the awesome styles provided by a designer.  But at the end of this post, I’ll give you a link to get the fully styled version of the application.</p>

<p>Open up Home.xaml; we’ll create our controls in there.  During the demo, we used a Blank.xaml and a Contacts.xaml, but we’ll just stick with Home.xaml here to keep things simple.  We want to resize the page, drop a few grids into place and get something that looks like this:</p>

<p><a href="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image28.png" rel="lightbox"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="Grid layout - 3 columns, with 2-row grids in the left and right columns" border="0" alt="Grid layout - 3 columns, with 2-row grids in the left and right columns" src="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image28_thumb.png" width="644" height="275" /></a> </p>

<p>We now need to get to the Data Sources window.  If it’s not already open, you can open it using Data-&gt;Show Data Sources menu option.  It might take a few moments for your model to show up in the window, but you will end up seeing ContactContext with Store under it.</p>

<br clear="all" />

<p><a href="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image37.png" rel="lightbox"><img style="border-right-width: 0px; margin: 0px 0px 0px 10px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="Customize Control Binding from Data Sources window" border="0" alt="Customize Control Binding from Data Sources window" align="right" src="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image37_thumb.png" width="404" height="291" /></a> By default, ListBox doesn’t show up as an option for the Store list, but we can easily add it.  Click the dropdown next to Store and choose “Customize…”  Then turn on the checkbox for ListBox and click OK.</p>

<p />

<p>Now you can click the dropdown next to Store again and choose ListBox.  This tells the Data Sources window that when you drag Store onto the design surface, it should create a new ListBox control.  Go ahead and do this, dropping the ListBox into the upper-left cell in our grid.  Once you have the ListBox positioned entirely within the appropriate grid cell, you’ll want to use the same right-click, Reset Layout-&gt;All gesture you saw during the keynote.  This will size the ListBox to fill its container.</p>

<br clear="all" />

<p><a href="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image42.png" rel="lightbox"><img style="border-right-width: 0px; margin: 0px 0px 0px 10px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="Choose Toolbox Items to add DataPager" border="0" alt="Choose Toolbox Items to add DataPager" align="right" src="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image42_thumb.png" width="404" height="257" /></a> During the keynote, we had a DataPager already in place in the page, but of course we don’t have that in place ourselves.  Before we’ll be able to add the DataPager to the view, we need to add DataPager into the Toolbox by right-clicking on the toolbox and selecting Choose Items.</p>

<p>Once you have DataPager in your Toolbox, you can drag one out of your Toolbox and into the lower-left cell in our grid.  Use the Reset Layout-&gt;All gesture on this control as well.</p>

<p>Using the Properties window, set the DataPager’s DisplayMode to PreviousNext and also set the PageSize property to 5.  Then drag the Store entity out of the Data Sources window and drop it onto the DataPager.  This will bind the existing DataPager control to the same collection of Stores as the ListBox we created a minute ago, thus applying server-side paging to the ListBox.  You should see something like this:</p>

<p><a href="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image60.png" rel="lightbox"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="ListBox and DataPager are added to the Grid" border="0" alt="ListBox and DataPager are added to the Grid" src="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image60_thumb.png" width="644" height="319" /></a> </p>

<p>Let’s now set up the next part of the master-details scenario.  Expand Store in the Data Sources window and select StoreContacts.  Use the dropdown to select ListBox and drag StoreContacts onto the middle cell in our grid layout.  Be sure to use Reset Layout-&gt;All to have it fill its container.</p>

<br clear="all" />

<p>We also want to expand StoreContacts, select Contact, and <a href="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image51.png" rel="lightbox"><img style="border-right-width: 0px; margin: 10px 0px 0px 10px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="Data Sources window shows our model - Customize the Contact Details" border="0" alt="Data Sources window shows our model - Customize the Contact Details" align="right" src="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image51_thumb.png" width="234" height="244" /></a>choose to have it generate Details.  Before we drag this Details view onto the page though, we want to make a few adjustments to what will be generated.</p>

<ol>
  <li>For ContactID, select [None]; </li>

  <li>For ContactPhoto, select Customize… and then check Image and click OK; </li>

  <li>Then for ContactPhoto, select the Image control. </li>
</ol>

<p>We can now drag Contact into the upper-right cell of our grid layout and reset the layout.</p>

<p />

<br clear="all" />

<p><em><a href="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image55.png" rel="lightbox"><img style="border-right-width: 0px; margin: 0px 0px 0px 10px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="Use the Data Binding picker to select the String Format for currency" border="0" alt="Use the Data Binding picker to select the String Format for currency" align="right" src="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image55_thumb.png" width="404" height="291" /></a>In the keynote, Scott deleted the Contact Photo label and resized the Image control to fill the width of the details.  If you do this too, you might encounter a bug where the image placeholder isn’t rendered correctly.  This is a known bug that occurs in some scenarios.  Often, zooming the view to 100% will alleviate this issue.</em></p>

<p>Let’s edit the Sales Target textbox using the binding picker to set the String Format for the binding, setting it to {0:c}.</p>

<p>We now just need to create a Save button and wire it up to submit changes.  Drag a button out of the Toolbox, dropping it into the lower-right cell of the grid; change its Content to “Save” and then double-click on it to set its click handler.</p>

<p><em>There’s a known bug with the preview release that prevents IntelliSense from working at this point, until you perform a build.  So just hit F6 and IntelliSense will come back.</em></p>

<p />

<p>In the click event handler, add the single line of code:</p>

<div id="codeSnippetWrapper">
  <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px" id="codeSnippet">
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">this</span>.storeDomainDataSource.SubmitChanges();</pre>
<!--CRLF--></div>
</div>

<p>
  <br />You can now run the application and it’s fully functional.  You should be able to page through the records, click through the stores, store contacts, and edit the contact details, with validation wired up, and the ability to save changes.  Of course, it’s not yet styled, and we don’t have any of the images in place in the web project.</p>

<p><a href="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image64.png" target="_blank"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="ContosoSales - Working Application" border="0" alt="ContosoSales - Working Application" src="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image64_thumb.png" width="644" height="341" /></a> </p>

<h4>Styling the Application</h4>

<p>Okay, what we just build doesn’t look quite like what we saw during the keynote.  That’s where having some designer-supplied XAML comes in handy!  Our designer, <a href="http://blogs.msdn.com/corrinab/" target="_blank">Corrina</a>, created the design of the application using Expression Blend and provided a customized MainPage.xaml, Styles.xaml, and she had Contacts.xaml set up with the grids arranged the way that fits into the design.  Here is the finished result with the styles and everything in place:</p>

<p><a href="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image68.png" target="_blank"><img style="border-right-width: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px" title="ContosoSales with styles applied" border="0" alt="ContosoSales with styles applied" src="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/BuildingContosoSalesTheRIAServicesKeynot_12431/image68_thumb.png" width="644" height="427" /></a> </p>

<p>You can <a href="http://jeffhandley.com/Files/ContosoSales.Styled.zip" target="_blank">download the styled version of the application here</a>.  I’ll work on follow-up posts that break down how the styles transform what we built into this end result.</p>

<p>When you download the styled application, be sure to:</p>

<ol>
  <li>Right-click on the Zip file and hit Properties to Unblock it if necessary; </li>

  <li>Extract the zip; </li>

  <li>Open the solution; </li>

  <li>Set the Web project as your Startup Project; and </li>

  <li>Rebuild the solution. </li>
</ol>

<h4>Run-Down</h4>

<p>You can see how the new tooling in Visual Studio 2010 jumpstarts application development using RIA Services and Silverlight 4.</p>

<p>Here’s a quick reference to the links throughout this post:</p>

<ul>
  <li><a href="http://go.microsoft.com/fwlink/?LinkID=151797" target="_blank">Install Visual Studio 2010 Beta 2</a> </li>

  <li><a href="http://go.microsoft.com/fwlink/?LinkID=177508" target="_blank">Install the Silverlight 4 Tools for Visual Studio 2010</a>, which includes: 

    <ul>
      <li>Silverlight 4 Developer Runtime </li>

      <li>Silverlight 4 Beta SDK </li>

      <li>Microsoft </li>

      <li>WCF RIA Services </li>
    </ul>
  </li>

  <li>Download the Database from <a href="http://jeffhandley.com/Files/ContosoSales_Data.mdf.zip" target="_blank">ContosoSales.mdf.zip</a> </li>

  <li>Download the styled application from <a href="http://jeffhandley.com/Files/ContosoSales.Styled.zip" target="_blank">ContosoSales.Styled.zip</a> </li>

  <li>Be sure to visit <a href="http://silverlight.net/riaservices">http://silverlight.net/riaservices</a> </li>
</ul>

<p>This week has been extremely exciting for me and I hope that you enjoy building the application that you saw presented during the keynote.</p>

<p />

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:82ddcfa6-730f-4ced-8228-fe447e18a42a" class="wlWriterEditableSmartContent">Technorati Tags: <a href="http://technorati.com/tags/Silverlight" rel="tag">Silverlight</a>,<a href="http://technorati.com/tags/RIAServices" rel="tag">RIAServices</a>,<a href="http://technorati.com/tags/Visual+Studio+2010" rel="tag">Visual Studio 2010</a></div>

