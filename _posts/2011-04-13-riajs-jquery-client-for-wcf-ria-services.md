---
layout: post
title: "RIA/JS - jQuery client for WCF RIA Services"
date: 2011-04-13 21:42:41 -0700
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.github.io/archive/2011/04/13/RIAJS-jQuery-client-for-WCF-RIA-Services.aspx", "http://jeffhandley.github.io/archive/2011/04/13/riajs-jquery-client-for-wcf-ria-services.aspx"]
author: 0
---
<!-- more -->
<p>Today at MIX11, <a title="Building Data-centric N-tier Applications with jQuery" target="_blank" href="http://channel9.msdn.com/events/MIX/MIX11/FRM05">Brad Olenick announced</a> RIA/JS, a jQuery client for WCF RIA Services.  This is an early preview that we want to get your feedback on.  Long before WCF RIA Services V1.0 was released, we started talking RIA Services support for AJAX; in fact, you can see the item <a target="_blank" href="http://dotnet.uservoice.com/forums/57026-wcf-ria-services/suggestions/746018-ria-services-support-for-ajax">here on the RIA Services Wish List</a> (11th ranked as of today).  We hope that you’ll grab this preview and let us know if you like the direction we’re going.</p>
<h3>RIA/JS Features</h3>
<p>In today’s state the features are somewhat limited, but many of the basic scenarios are in place:</p>
<ol>
    <li>Query support with sorting, paging, filtering </li>
    <li>Changeset submission with two edit modes:
    <ol>
        <li>“Implicit Commit” or “write-thru edits” where updates to field values are automatically submitted to your DomainService.  This can enable a Netflix.com or Mint.com experience where field changes are submitted to the server as soon as the user tabs out of the field. </li>
        <li>“Buffered Changes” mode, where your code must call commitChanges() to submit your changeset to the DomainService.  Those that have used the Silverlight client will be most familiar with this mode - a submit button is often used to trigger the commit. </li>
    </ol>
    </li>
    <li>Data change events including collection changes </li>
    <li>Client-side change tracking with an entity state API for determining what entities and properties have been edited </li>
    <li>Entity data model support that allows you to navigate through associated entity properties and collections </li>
    <li>Client-side validation by exposing your server-side validation metadata in jQuery validation format </li>
</ol>
<h3>Contents and Prerequisites</h3>
<p>This jQuery client is broken up into several script files.  The factoring of these files will likely change with subsequent releases.</p>
<ol>
    <li><strong>DomainServiceProxy.js</strong> - provides an API for executing queries against your DomainService, with filtering, sorting, and paging. </li>
    <li><strong>EntitySet.js</strong> - Change tracking for a set of entities </li>
    <li><strong>DataContext.js</strong> - Client-side cache support, managing the entity sets </li>
    <li><strong>DataSource.js</strong> - A base datasource that is used for both remote and local data sources </li>
    <li><strong>RemoteDataSource.js</strong> - A datasource specific to a WCF RIA Services DomainService </li>
    <li><strong>LocalDataSource.js</strong> - A datasource that operates over local data already on the client </li>
    <li><strong>AssociatedEntitiesDataSource.js</strong> - A datasource that operates over an associated entities collection already on the client </li>
    <li><strong>jquery.array.js</strong> - A jQuery plug-in that provides array change methods and events (similar to INotifyCollectionChange) </li>
    <li><strong>jQuery.datasource.js</strong> - A jQuery plug-in that provides a simple jQuery-friendly API for working with data sources </li>
</ol>
<p>There are a few other script files that you will need to use as well:</p>
<ol>
    <li><strong><a target="_blank" href="http://go.microsoft.com/fwlink/?LinkId=215202">WCF RIA Services V1.0 SP2 Preview (April 2011)</a></strong> - This is required for the jQuery client to work, because we rely on an update to the hosting assembly for the JSON endpoint to be able to expose metadata </li>
    <li><strong><a target="_blank" href="http://blog.jquery.com/2010/11/11/jquery-1-4-4-release-notes/">jQuery 1.4.4</a></strong> - <em>Currently only version 1.4.4 is supported</em>.  We are working to get things going against 1.5+. </li>
    <li><strong><a target="_blank" href="http://api.jquery.com/category/plugins/data-link/">jQuery Data Link</a></strong> - To provide HTML DOM to jQuery object linking (similar to Silverlight’s Data Binding) </li>
    <li><strong><a target="_blank" href="http://api.jquery.com/category/plugins/templates/">jQuery Templates</a></strong> - To generate HTML on the client based on query results </li>
    <li><strong><a target="_blank" href="http://plugins.jquery.com/project/jqueryvalidate">jQuery Validate</a></strong> - To perform validation against the server-provided validation metadata </li>
</ol>
<h3>RIA/JS Installation</h3>
<p>The RIA/JS library is available in two forms:</p>
<ol>
    <li>Included in the <a target="_blank" href="http://go.microsoft.com/fwlink/?LinkID=205088">WCF RIA Services Toolkit (April 2011)</a>.  The script files are included in your Program Files under <em>Microsoft SDKs\RIA Services\v1.0\Toolkit\Scripts</em> </li>
    <li>By referencing the <a target="_blank" href="http://nuget.org/list/packages/RIAServices.jQuery">RIAServices.jQuery NuGet package</a> </li>
</ol>
<h3>Super QuickStart</h3>
<p><em><strong>Update: As of the August 2011 drop of RIA/JS, this walkthrough is now obsolete.  jquery.array.js and jquery.datalink.js are no longer included in RIA/JS; instead, we have jquery.observable.js included.  Additionally, the August 2011 preview works with jQuery 1.5.1+ instead of 1.4.4.</strong></em></p>
<p><em><strong>For an updated walkthrough, please refer to the <a href="http://wcf.codeplex.com/wikipage?title=jQueryRia&amp;referringTitle=WCF%20jQuery">WCF CodePlex site where the BigShelf application is used</a>.</strong></em></p>
<p>Let’s walk through a super quickstart that illustrates how to query and submit data through the jQuery client.</p>
<ul>
    <li>Open Visual Studio 2010 and hit <em>File\New Project</em>
    <ul>
        <li>Choose either an ASP.NET MVC 3 application or an ASP.NET Web Application </li>
        <li>Name it “<em>CustomerApp</em>” and click OK </li>
        <li>If you chose MVC, then select the <em>Internet Application</em> template </li>
    </ul>
    </li>
    <li>Right-click on References and select <em>Add Library Package Reference…</em>
    <ul>
        <li>Find and select <em>RIAServices.jQuery</em> and click <em>Install</em> to install the package </li>
        <li>Click Close to close the Library Package Reference window </li>
    </ul>
    </li>
    <li>Right-click on the project and choose <em>Add\New Item…</em> so that we can add a DomainService
    <ul>
        <li>Select <em>Domain Service Class</em>, name it <em>CustomerService.cs</em> and click <em>Add</em> </li>
        <li>Click OK to complete the wizard (to add an empty domain service class) </li>
    </ul>
    </li>
    <li>Paste the following code into the domain service class file to complete the server-side code </li>
</ul>
<div id="codeSnippetWrapper">
<pre style="TEXT-ALIGN: left; PADDING-BOTTOM: 0px; LINE-HEIGHT: 12pt; BACKGROUND-COLOR: rgb(244,244,244); MARGIN: 0em; PADDING-LEFT: 0px; WIDTH: 100%; PADDING-RIGHT: 0px; FONT-FAMILY: &quot;Courier New&quot;, courier, monospace; DIRECTION: ltr; COLOR: black; FONT-SIZE: 8pt; OVERFLOW: visible; PADDING-TOP: 0px" id="codeSnippet">[EnableClientAccess()]<br /><span style="COLOR: rgb(0,0,255)">public</span> <span style="COLOR: rgb(0,0,255)">class</span> CustomerService : DomainService<br />{<br />    <span style="COLOR: rgb(0,0,255)">public</span> IQueryable&lt;Customer&gt; GetCustomers()<br />    {<br />        <span style="COLOR: rgb(0,0,255)">return</span> <span style="COLOR: rgb(0,0,255)">new</span>[] {<br />            <span style="COLOR: rgb(0,0,255)">new</span> Customer { CustomerId = 1, CustomerName = <span style="COLOR: rgb(0,96,128)">"John Doe"</span> }<br />        }.AsQueryable();<br />    }<br /> <br />    <span style="COLOR: rgb(0,0,255)">public</span> <span style="COLOR: rgb(0,0,255)">void</span> UpdateCustomer(Customer customer)<br />    {<br />    }<br />}<br /> <br /><span style="COLOR: rgb(0,0,255)">public</span> <span style="COLOR: rgb(0,0,255)">class</span> Customer<br />{<br />    [Key]<br />    <span style="COLOR: rgb(0,0,255)">public</span> <span style="COLOR: rgb(0,0,255)">int</span> CustomerId { get; set; }<br /> <br />    <span style="COLOR: rgb(0,0,255)">public</span> <span style="COLOR: rgb(0,0,255)">string</span> CustomerName { get; set; }<br />}<br /></pre>
<br />
</div>
<p> </p>
<ul>
    <li>Open the default page for the application
    <ul>
        <li>In MVC, it’s /Views/Home/Index.cshtml </li>
        <li>In a Web Application case, it’s Default.aspx </li>
    </ul>
    </li>
    <li>Select the following files from the /Scripts folder, and drag them into the page (to create the necessary &lt;script&gt; tags):
    <ul>
        <li>DataContext.js </li>
        <li>DataSource.js </li>
        <li>DomainServiceProxy.js </li>
        <li>EntitySet.js </li>
        <li>jquery-1.4.4.min.js (not needed when using MVC, as it’s already included in the layout.  If using a Web Application, you might have to go download it) </li>
        <li>jquery.array.js </li>
        <li>jquery.datalink.js </li>
        <li>jquery.datasource.js </li>
        <li>RemoteDataSource.js </li>
    </ul>
    </li>
    <li>Update the &lt;script&gt; tags to fix the paths if necessary, so that they all start with /Scripts
    <ul>
        <li>Hold the Alt key and drag the mouse to make a rectangular selection, then hit delete to update the paths all at once </li>
    </ul>
    </li>
    <li>Add the following code to the page: (the &lt;script&gt; tags that you just created are shown here too) </li>
</ul>
<div id="codeSnippetWrapper">
<pre style="TEXT-ALIGN: left; PADDING-BOTTOM: 0px; LINE-HEIGHT: 12pt; BACKGROUND-COLOR: rgb(244,244,244); MARGIN: 0em; PADDING-LEFT: 0px; WIDTH: 100%; PADDING-RIGHT: 0px; FONT-FAMILY: &quot;Courier New&quot;, courier, monospace; DIRECTION: ltr; COLOR: black; FONT-SIZE: 8pt; OVERFLOW: visible; PADDING-TOP: 0px" id="codeSnippet">&lt;script src=<span style="COLOR: rgb(0,96,128)">"/Scripts/DataContext.js"</span> type=<span style="COLOR: rgb(0,96,128)">"text/javascript"</span>&gt;&lt;/script&gt;<br />&lt;script src=<span style="COLOR: rgb(0,96,128)">"/Scripts/DataSource.js"</span> type=<span style="COLOR: rgb(0,96,128)">"text/javascript"</span>&gt;&lt;/script&gt;<br />&lt;script src=<span style="COLOR: rgb(0,96,128)">"/Scripts/DomainServiceProxy.js"</span> type=<span style="COLOR: rgb(0,96,128)">"text/javascript"</span>&gt;&lt;/script&gt;<br />&lt;script src=<span style="COLOR: rgb(0,96,128)">"/Scripts/EntitySet.js"</span> type=<span style="COLOR: rgb(0,96,128)">"text/javascript"</span>&gt;&lt;/script&gt;<br />&lt;script src=<span style="COLOR: rgb(0,96,128)">"/Scripts/jquery.array.js"</span> type=<span style="COLOR: rgb(0,96,128)">"text/javascript"</span>&gt;&lt;/script&gt;<br />&lt;script src=<span style="COLOR: rgb(0,96,128)">"/Scripts/jQuery.DataLink.js"</span> type=<span style="COLOR: rgb(0,96,128)">"text/javascript"</span>&gt;&lt;/script&gt;<br />&lt;script src=<span style="COLOR: rgb(0,96,128)">"/Scripts/jquery.datasource.js"</span> type=<span style="COLOR: rgb(0,96,128)">"text/javascript"</span>&gt;&lt;/script&gt;<br />&lt;script src=<span style="COLOR: rgb(0,96,128)">"/Scripts/RemoteDataSource.js"</span> type=<span style="COLOR: rgb(0,96,128)">"text/javascript"</span>&gt;&lt;/script&gt;<br /> <br />&lt;script type=<span style="COLOR: rgb(0,96,128)">"text/javascript"</span>&gt;<br /> <br />    $(<span style="COLOR: rgb(0,0,255)">function</span> () {<br /> <br />        <span style="COLOR: rgb(0,0,255)">var</span> serviceUrl = <span style="COLOR: rgb(0,96,128)">"/CustomerApp-CustomerService.svc"</span>;<br />        <span style="COLOR: rgb(0,0,255)">var</span> customers = [];<br /> <br />        <span style="COLOR: rgb(0,0,255)">var</span> render = <span style="COLOR: rgb(0,0,255)">function</span> (loadedCustomers) {<br />            $(<span style="COLOR: rgb(0,96,128)">"#customerForm input[name='CustomerName']"</span>).val(loadedCustomers[0].CustomerName);<br />            $(<span style="COLOR: rgb(0,96,128)">"#customerForm"</span>).link(loadedCustomers[0]);<br />        };<br /> <br />        $([customers]).dataSource({<br />            serviceUrl: serviceUrl,<br />            queryName: <span style="COLOR: rgb(0,96,128)">"GetCustomers"</span>,<br />            refresh: render<br />        }).refresh();<br /> <br />    });<br /> <br />&lt;/script&gt;<br /> <br />&lt;div id=<span style="COLOR: rgb(0,96,128)">"customerForm"</span>&gt;<br />    Name: &lt;input type=<span style="COLOR: rgb(0,96,128)">"text"</span> name=<span style="COLOR: rgb(0,96,128)">"CustomerName"</span> /&gt;<br />&lt;/div&gt;<br /></pre>
<br />
</div>
<p> </p>
<ul>
    <li>In CustomerService.cs, put a breakpoint within the UpdateCustomer method, and press F5 to run the application - <strong>You now have a read/write jQuery client hitting your Domain Service!</strong>
    <ul>
        <li>The textbox should be filled in with “John Doe” </li>
        <li>Change the textbox to your name and press Tab </li>
        <li>Your breakpoint will be hit, and the Customer passed into UpdateCustomer will have your name </li>
        <li>Stop the debugger </li>
    </ul>
    </li>
    <li>Go back to your HTML and update the dataSource code to also specify <em>bufferChanges: true</em> within the options. </li>
</ul>
<div id="codeSnippetWrapper">
<pre style="TEXT-ALIGN: left; PADDING-BOTTOM: 0px; LINE-HEIGHT: 12pt; BACKGROUND-COLOR: rgb(244,244,244); MARGIN: 0em; PADDING-LEFT: 0px; WIDTH: 100%; PADDING-RIGHT: 0px; FONT-FAMILY: &quot;Courier New&quot;, courier, monospace; DIRECTION: ltr; COLOR: black; FONT-SIZE: 8pt; OVERFLOW: visible; PADDING-TOP: 0px" id="codeSnippet">$([customers]).dataSource({<br />    serviceUrl: serviceUrl,<br />    queryName: <span style="COLOR: rgb(0,96,128)">"GetCustomers"</span>,<br />    bufferChanges: <span style="COLOR: rgb(0,0,255)">true</span>,<br />    refresh: render<br />}).refresh();<br /></pre>
<br />
</div>
<p> </p>
<ul>
    <li>Add a button to the form: </li>
</ul>
<div id="codeSnippetWrapper">
<pre style="TEXT-ALIGN: left; PADDING-BOTTOM: 0px; LINE-HEIGHT: 12pt; BACKGROUND-COLOR: rgb(244,244,244); MARGIN: 0em; PADDING-LEFT: 0px; WIDTH: 100%; PADDING-RIGHT: 0px; FONT-FAMILY: &quot;Courier New&quot;, courier, monospace; DIRECTION: ltr; COLOR: black; FONT-SIZE: 8pt; OVERFLOW: visible; PADDING-TOP: 0px" id="codeSnippet"><span style="COLOR: rgb(0,0,255)">&lt;</span><span style="COLOR: rgb(128,0,0)">input</span> <span style="COLOR: rgb(255,0,0)">type</span><span style="COLOR: rgb(0,0,255)">="button"</span> <span style="COLOR: rgb(255,0,0)">value</span><span style="COLOR: rgb(0,0,255)">="Update Customer"</span> <span style="COLOR: rgb(255,0,0)">id</span><span style="COLOR: rgb(0,0,255)">="submit"</span> <span style="COLOR: rgb(0,0,255)">/&gt;</span></pre>
<br />
</div>
<p> </p>
<ul>
    <li>Wire up the button to commit pending changes on the dataSource: (add this code after the block that configures the dataSource) </li>
</ul>
<div id="codeSnippetWrapper">
<pre style="TEXT-ALIGN: left; PADDING-BOTTOM: 0px; LINE-HEIGHT: 12pt; BACKGROUND-COLOR: rgb(244,244,244); MARGIN: 0em; PADDING-LEFT: 0px; WIDTH: 100%; PADDING-RIGHT: 0px; FONT-FAMILY: &quot;Courier New&quot;, courier, monospace; DIRECTION: ltr; COLOR: black; FONT-SIZE: 8pt; OVERFLOW: visible; PADDING-TOP: 0px" id="codeSnippet">$(<span style="COLOR: rgb(0,96,128)">"#submit"</span>).click(<span style="COLOR: rgb(0,0,255)">function</span> () {<br />    $([customers]).dataSource().commitChanges();<br />});<br /></pre>
<br />
</div>
<p> </p>
<ul>
    <li>Keeping the breakpoint in your UpdateCustomer method, run the application again using F5 - <strong>You are now building up a changeset on the client!</strong> woo!
    <ul>
        <li>The textbox should load as “John Doe” </li>
        <li>Change the textbox to your name and press Tab </li>
        <li><em>NOTICE:</em> The DomainService method is not called, yet… </li>
        <li>Click the Update Customer button </li>
        <li>Your breakpoint will be hit, and the Customer passed into UpdateCustomer will have your name </li>
    </ul>
    </li>
</ul>
<h3>More Info…</h3>
<p>We will be publishing more details about this new jQuery client for WCF RIA Services.  You can also find more information and the BigShelf sample application at <a href="http://jeffh.me/wcfjquery">http://jeffh.me/wcfjquery</a>.</p>
<div style="PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; DISPLAY: inline; FLOAT: none; PADDING-TOP: 0px" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:79be1722-1fbb-4051-b72c-e48d142c2e21" class="wlWriterEditableSmartContent">Technorati Tags: <a rel="tag" href="http://technorati.com/tags/RIAServices">RIAServices</a>,<a rel="tag" href="http://technorati.com/tags/jQuery">jQuery</a></div>

