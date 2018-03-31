---
layout: post
title: "Custom Controls Everywhere and ASP.NET MVC, part 1"
date: 2008-02-25 02:05:15 -0800
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.com/archive/2008/02/24/custom-controls-everywhere-and-asp.net-mvc-part-1"]
author: 0
---
<!-- more -->
<p>This is part 1 of a <a href="http://blog.jeffhandley.com/archive/2008/02/13/custom-controls-everywhere-and-asp.net-mvc-part-0.aspx">4-part series</a> discussing a concept that I've long called "Custom Controls Everywhere" and how ASP.NET MVC affects it.  This article will explain why I advocate the pattern and how ASP.NET MVC takes the capability away.</p>
<h2>What does Custom Controls Everywhere mean?</h2>
<p>When I start my explanation of Custom Controls Everywhere, many listeners think I'm off my rocker.  At the least, they think I'm creating a bunch of extra work for nothing.  But once those listeners hear me out, as with some of my <a href="http://blog.jeffhandley.com/archive/2007/11/19/criticism-of-my-extended-mvp-pattern.aspx">other ideas</a>, the critics come to <a href="http://blog.jeffhandley.com/archive/2008/01/15/extended-mvp-pattern---domain-validation.aspx#110">realize the benefits</a>.  I preface the definition of Custom Controls Everywhere this way because I don't want listeners to stop paying attention before reaching the climax of the story.  There's an important take-away here.</p>
<p>To cut to the chase: Custom Controls Everywhere means that you don't use ASP.NET controls out of the box.  Don't use the &lt;asp:TextBox&gt; control; don't use the &lt;asp:DropDownList&gt; control; and don't use &lt;asp:Button&gt; or &lt;asp:Hyperlink&gt;.  With even more emphasis, <strong>never</strong> use the &lt;asp:DataGrid&gt; or &lt;asp:GridView&gt; controls!  Use your own custom controls, everywhere.  There are a few exceptions to the rule, which we'll talk about another time, but the idea is to <em>virtually always</em> inherit from the ASP.NET controls, deriving your own controls, and use those.  You end up with &lt;myApp:TextBox&gt;, &lt;myApp:DropDownList&gt;, &lt;myApp:Button&gt;, &lt;myApp:Hyperlink&gt;, &lt;myApp:DataGrid&gt; and &lt;myApp:GridView&gt;.</p>
<h2>Why on Earth would you do that!?</h2>
<p>The answer to that question is multifold.  Back in .NET 1.0 and 1.1, providing a consistent presentation was the first reason. ASP.NET 2.0 introduced <a href="http://msdn2.microsoft.com/en-us/library/ykzx33wh(VS.80).aspx">themes and skins</a>, which was excellent, but when I used themes for the first time, I realized that I still needed Custom Controls Everywhere because of a second reason, behavior.  Themes allow a consistent presentation to be configured application-wide, but they don't allow you to change behavior of controls.  For instance, the MaxLength property is not <a href="http://msdn2.microsoft.com/en-us/library/system.web.ui.themeableattribute(VS.80).aspx">themeable</a>.</p>
<p>If you define the following skin:</p>
<div style="BORDER-RIGHT: gray 1px solid; PADDING-RIGHT: 4px; BORDER-TOP: gray 1px solid; PADDING-LEFT: 4px; FONT-SIZE: 8pt; PADDING-BOTTOM: 4px; MARGIN: 20px 0px 10px; OVERFLOW: auto; BORDER-LEFT: gray 1px solid; WIDTH: 97.5%; CURSOR: text; MAX-HEIGHT: 200px; LINE-HEIGHT: 12pt; PADDING-TOP: 4px; BORDER-BOTTOM: gray 1px solid; FONT-FAMILY: consolas, 'Courier New', courier, monospace; HEIGHT: 83px; BACKGROUND-COLOR: #f4f4f4">
<div style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none">
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   1:</span> <span style="COLOR: #0000ff">&lt;</span><span style="COLOR: #800000">asp:TextBox</span> <span style="COLOR: #ff0000">runat</span><span style="COLOR: #0000ff">="server"</span></pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   2:</span>     <span style="COLOR: #ff0000">SkinId</span><span style="COLOR: #0000ff">="EmailAddress"</span></pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   3:</span>     <span style="COLOR: #ff0000">Columns</span><span style="COLOR: #0000ff">="25"</span></pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   4:</span>     <span style="COLOR: #ff0000">MaxLength</span><span style="COLOR: #0000ff">="80"</span> <span style="COLOR: #0000ff">/&gt;</span></pre>
</div>
</div>
<p><br />
And you attempt to utilize this SkinId:</p>
<div style="BORDER-RIGHT: gray 1px solid; PADDING-RIGHT: 4px; BORDER-TOP: gray 1px solid; PADDING-LEFT: 4px; FONT-SIZE: 8pt; PADDING-BOTTOM: 4px; MARGIN: 20px 0px 10px; OVERFLOW: auto; BORDER-LEFT: gray 1px solid; WIDTH: 97.5%; CURSOR: text; MAX-HEIGHT: 200px; LINE-HEIGHT: 12pt; PADDING-TOP: 4px; BORDER-BOTTOM: gray 1px solid; FONT-FAMILY: consolas, 'Courier New', courier, monospace; HEIGHT: 65px; BACKGROUND-COLOR: #f4f4f4">
<div style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none">
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   1:</span> <span style="COLOR: #0000ff">&lt;</span><span style="COLOR: #800000">asp:TextBox</span> <span style="COLOR: #ff0000">runat</span><span style="COLOR: #0000ff">="server"</span></pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   2:</span>     <span style="COLOR: #ff0000">ID</span><span style="COLOR: #0000ff">="txtEmailAddress"</span></pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   3:</span>     <span style="COLOR: #ff0000">SkinId</span><span style="COLOR: #0000ff">="EmailAddress"</span> <span style="COLOR: #0000ff">/&gt;</span></pre>
</div>
</div>
<p><br />
You get the following error message:  <em>The 'MaxLength' property of a control type System.Web.UI.WebControls.TextBox cannot be applied through a control skin.</em></p>
<p>Behavior ends up being one of the most important reasons for using Custom Controls Everywhere.  MaxLength is a rudimentary example, but it illustrates simply how themes and skins fall short.</p>
<p>My project (<a href="http://blog.jeffhandley.com/archive/2007/10/31/blog.jeffhandley.com-version-4.aspx">DASL</a>) was faced with a more involved behavior-related feature request after we already had 500 screens in place.  We needed to make all auto-post-back drop-downs retain focus after causing the post-back.  Users were very frustrated that changing the selection on drop-downs would cause them to lose their place in the <a href="http://www.codinghorror.com/blog/archives/001055.html">tab order</a>, so we needed to implement this feature application-wide, and in short order.  Since we were using a custom (derived) DropDownList control ubiquitously, I was able to implement this new behavior into the control and meet the new requirement in an afternoon, without having to change any of the screens' code.  This, on its own, justified having created Custom Controls Everywhere for DASL.</p>
<h4>Some other notable reasons for Custom Controls Everywhere</h4>
<p>I've also found that custom controls afford better cross-browser support capabilities, possibility for security integration, validation hooks, and abstractions from external resources.</p>
<p>One way that cross-browser support is improved includes changing the way a disabled controls are rendered.  Several of my ASP.NET projects had to support Netscape 4, which had no concept of disabled controls.  My custom TextBox, when disabled, actually renders as static text in a &lt;span&gt; that looks like a disabled TextBox.</p>
<p>I've implemented security into controls by having &lt;myApp:Button Access="Save"&gt; or even &lt;myApp:SaveButton&gt;, where these controls automatically hook into the application security to ensure that the user has save permission for the given page.  If the user doesn't have the permission, the button is hidden.  The developer has no code for this other than using the correct control.</p>
<p>Validation is dramatically simplified when you can use a tag like &lt;myApp:TextBox Format="EmailAddress" Required-Enabled="True" FieldName="Email Address"&gt;.  Enough said there.</p>
<p>As for external resources, this can get a little trickier.  But if you wrap the Peter Blum <a href="http://peterblum.com/DES/DateAndTime.aspx#DateTextBox">DateTextBox</a> in your own &lt;myApp:DateTextBox&gt;, you can use all of the goodness that comes with Peter's Date Package, but you can also add additional behavior.  For example, you can add quick selections for dates that are known to be important to the user.  In the case of DASL, a school system, dates like the end of the current semester make sense.  And if you need to, you can set it up so that you could yank Peter's Date Package out in the future, and replace it with another control.</p>
<h2>But isn't it a lot of extra work to create the controls?</h2>
<p>Gosh no. It's virtually no work at all.  All you have to do is create empty classes that inherit from the ASP.NET controls, and use those instead of the stock controls.  Then you can add code when you need to, like the auto-focus auto-post-back drop-down list feature.</p>
<p>Here's an example of how to start using Custom Controls Everywhere:</p>
<div style="BORDER-RIGHT: gray 1px solid; PADDING-RIGHT: 4px; BORDER-TOP: gray 1px solid; PADDING-LEFT: 4px; FONT-SIZE: 8pt; PADDING-BOTTOM: 4px; MARGIN: 20px 0px 10px; OVERFLOW: auto; BORDER-LEFT: gray 1px solid; WIDTH: 97.5%; CURSOR: text; MAX-HEIGHT: 200px; LINE-HEIGHT: 12pt; PADDING-TOP: 4px; BORDER-BOTTOM: gray 1px solid; FONT-FAMILY: consolas, 'Courier New', courier, monospace; HEIGHT: 62px; BACKGROUND-COLOR: #f4f4f4">
<div style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none">
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   1:</span> <span style="COLOR: #0000ff">public</span> <span style="COLOR: #0000ff">class</span> TextBox : System.Web.UI.WebControls.TextBox</pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   2:</span> {</pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   3:</span> }</pre>
</div>
</div>
<p><br />
Then you can just register the namespace of your custom controls in the web.config file, and it's available everywhere.  That's it.  Done; on to the next control.</p>
<div style="BORDER-RIGHT: gray 1px solid; PADDING-RIGHT: 4px; BORDER-TOP: gray 1px solid; PADDING-LEFT: 4px; FONT-SIZE: 8pt; PADDING-BOTTOM: 4px; MARGIN: 20px 0px 10px; OVERFLOW: auto; BORDER-LEFT: gray 1px solid; WIDTH: 97.5%; CURSOR: text; MAX-HEIGHT: 200px; LINE-HEIGHT: 12pt; PADDING-TOP: 4px; BORDER-BOTTOM: gray 1px solid; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BACKGROUND-COLOR: #f4f4f4">
<div style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none">
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   1:</span> <span style="COLOR: #0000ff">&lt;</span><span style="COLOR: #800000">pages</span><span style="COLOR: #0000ff">&gt;</span></pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   2:</span>     <span style="COLOR: #0000ff">&lt;</span><span style="COLOR: #800000">controls</span><span style="COLOR: #0000ff">&gt;</span></pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   3:</span>         <span style="COLOR: #0000ff">&lt;</span><span style="COLOR: #800000">add</span> <span style="COLOR: #ff0000">tagPrefix</span><span style="COLOR: #0000ff">="myApp"</span></pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   4:</span>              <span style="COLOR: #ff0000">namespace</span><span style="COLOR: #0000ff">="CustomControlsEverywhere.Controls"</span></pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   5:</span>              <span style="COLOR: #ff0000">assembly</span><span style="COLOR: #0000ff">="CustomControlsEverywhere"</span> <span style="COLOR: #0000ff">/&gt;</span></pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   6:</span>         ...</pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   7:</span>     <span style="COLOR: #0000ff">&lt;/</span><span style="COLOR: #800000">controls</span><span style="COLOR: #0000ff">&gt;</span></pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   8:</span> <span style="COLOR: #0000ff">&lt;/</span><span style="COLOR: #800000">pages</span><span style="COLOR: #0000ff">&gt;</span></pre>
</div>
</div>
<p> </p>
<h2>Okay, I'll buy in, but why won't it work in ASP.NET MVC?</h2>
<p>One of the first things I tried to do with ASP.NET MVC was to create a custom TextBox control, and slap it into a view.  But, that results in an error:</p>
<p><em>Control 'ctl00_MainContentPlaceHolder_EmailAddress' of type 'TextBox' must be placed inside a form tag with runat=server.</em></p>
<p>This is by design, and I expected to get this error.  MVC is not designed for use with forms set to runat=server.  Server forms are all about post-backs, and MVC is the polar opposite of post-backs.  While you could probably find a way to marry the two together, it would be ugly and pointless.  The result is that you cannot use some of the System.Web.UI.WebControls in MVC.  Form controls and validators will throw the above error, which is why the MVC demos out there show the old-school usage of &lt;input type="text"&gt;, and no validation in the view.</p>
<p>I thought I heard <a href="http://weblogs.asp.net/scottgu/">Scott Guthrie</a> mention that putting a server form in an MVC view would throw an exception, but that isn't the case (right now).  Instead, it <em>appears</em> to work. You can even put TextBox controls and validators onto the form.  But, the controller will not be able to retrieve the values from these controls, because of the Name attribute that will be emitted to the control.  The Name attribute will respect the naming container, to where it's unpredictable what the name of the control will be.  In summary, you cannot use these server controls.  Say bye-bye to all of the custom controls that you've already put in place.  And forget about inheriting from the ASP.NET TextBox for use within MVC.  No more Custom Controls Everywhere.</p>
<h3>What about the UI Helpers?</h3>
<p>Microsoft has given us some extensions to provide <a href="http://blog.wekeroad.com/2007/12/05/aspnet-mvc-preview-using-the-mvc-ui-helpers/">UI helpers</a>.  These are pretty snazzy.  Rob Conery has written a bunch about them--check em out.  Essentially, these are helper methods that emit HTML for you, so that you don't have to write all of those silly &lt;input&gt; tags.  Instead, you use code like this: <em>(credit to <a href="http://blog.wekeroad.com/">Rob Conery</a> on this)</em></p>
<div style="BORDER-RIGHT: gray 1px solid; PADDING-RIGHT: 4px; BORDER-TOP: gray 1px solid; PADDING-LEFT: 4px; FONT-SIZE: 8pt; PADDING-BOTTOM: 4px; MARGIN: 20px 0px 10px; OVERFLOW: auto; BORDER-LEFT: gray 1px solid; WIDTH: 97.5%; CURSOR: text; MAX-HEIGHT: 200px; LINE-HEIGHT: 12pt; PADDING-TOP: 4px; BORDER-BOTTOM: gray 1px solid; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BACKGROUND-COLOR: #f4f4f4">
<div style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none">
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   1:</span> Name:<span style="COLOR: #0000ff">&lt;</span><span style="COLOR: #800000">br</span> <span style="COLOR: #0000ff">/&gt;</span></pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   2:</span> <span style="BACKGROUND-COLOR: #ffff00">&lt;%</span>=Html.TextBox(“txtName”,20) %<span style="COLOR: #0000ff">&gt;&lt;</span><span style="COLOR: #800000">br</span> <span style="COLOR: #0000ff">/&gt;</span></pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   3:</span> Name, with maxlength:<span style="COLOR: #0000ff">&lt;</span><span style="COLOR: #800000">br</span> <span style="COLOR: #0000ff">/&gt;</span></pre>
<pre style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FONT-SIZE: 8pt; PADDING-BOTTOM: 0px; MARGIN: 0em; OVERFLOW: visible; WIDTH: 100%; COLOR: black; BORDER-TOP-STYLE: none; LINE-HEIGHT: 12pt; PADDING-TOP: 0px; FONT-FAMILY: consolas, 'Courier New', courier, monospace; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: #f4f4f4; BORDER-BOTTOM-STYLE: none"><span style="COLOR: #606060">   4:</span> <span style="BACKGROUND-COLOR: #ffff00">&lt;%</span>=Html.TextBox(“txtName”,“My Value”,20,20) %<span style="COLOR: #0000ff">&gt;&lt;</span><span style="COLOR: #800000">br</span> <span style="COLOR: #0000ff">/&gt;</span></pre>
</div>
</div>
<p><br />
There is a lot of work that has gone into these UI helpers, and they have some great advantages.  But, and you knew there was a but, they don't lend themselves to a Custom Controls Everywhere approach.  All of the UI Helpers are created as extension methods to the HtmlHelper class, so you can't create a derived HtmlHelper class that overrides these methods.  And even if you could, you'd have to override every overload that is offered.  So we have all of this goodness, and we cannot use it with the Custom Controls Everywhere pattern.</p>
<h2>Where does that leave us?</h2>
<p>When I think of losing my <a href="http://blog.jeffhandley.com/archive/2008/02/12/self-validating-form-controls.aspx">self-validating controls</a>, I am sad.  The loss of Custom Controls Everywhere really makes me feel like ASP.NET MVC is a huge step backward.  I've refused to throw in the towel though; so in the <a href="http://blog.jeffhandley.com/archive/2008/03/08/custom-controls-everywhere-and-asp.net-mvc-part-2.aspx">next article</a> of this series, I'll demonstrate a way to bring Custom Controls Everywhere back to life within MVC.  Then part 3 of the series will discuss how the MVC framework could be changed to promote the concept.  Part 4 will extend on that, showing how validation could be baked in too.</p>
<p>Please stay tuned and provide any thoughts or feedback that you have.</p>
<div class="wlWriterSmartContent" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:b8f06323-c73c-4bed-b3c7-c84f89d1b11f" style="PADDING-RIGHT: 0px; DISPLAY: inline; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px">Technorati Tags: <a rel="tag" href="http://technorati.com/tags/ASP.NET">ASP.NET</a>,<a rel="tag" href="http://technorati.com/tags/Custom%20Controls%20Everywhere">Custom Controls Everywhere</a>,<a rel="tag" href="http://technorati.com/tags/MVC">MVC</a>,<a rel="tag" href="http://technorati.com/tags/MVP">MVP</a></div>
