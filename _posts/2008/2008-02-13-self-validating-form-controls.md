---
layout: post
title: "Self-Validating Form Controls"
date: 2008-02-13 06:16:01 -0800
comments: true
tags: ["ASP.NET", "Validation", "MVC", "MVP", "Custom Controls"]
redirect_from: ["/archive/2008/02/12/self-validating-form-controls.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p>Ever since I started working with ASP.NET, back in v1.0 Beta 1, I've been creating self-validating form controls.  I've gone through a few iterations with them, but overall, the concept has stayed the same.   <br />  <br /><em>Here's a <a href="http://web.archive.org/web/20030618195607/www.msdevcin.org/meetings.htm" target="_blank">fun link</a> to an archive of the old Cincinnati .NET user group.  It shows where I gave a presentation back in February of 2003 on this topic.  I was trying to remember when that was, and <a href="http://www.archive.org" target="_blank">archive.org</a> was able to remember for me.</em></p>  <p>On my current project, our Textbox got the most attention for validation.  We also have a SpinBox control that utilizes the Textbox and exposes all of the same properties.  I fixed a couple of bugs on a screen today related to validation on a form, and I was quickly reminded why I love self-validating controls so much.</p>  <p>Here's how the SpinBox is implemented in the ASPX code:</p>  <div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.36%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; height: 118px; background-color: #f4f4f4">   <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">   <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   1:</span> <span style="color: #0000ff">&lt;</span><span style="color: #800000">app:SpinBox</span> <span style="color: #ff0000">Runat</span><span style="color: #0000ff">="server"</span> <span style="color: #ff0000">ID</span><span style="color: #0000ff">="spbRatioDenominator"</span></pre>

  <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   2:</span>   <span style="color: #ff0000">FieldName</span><span style="color: #0000ff">="Ratio Denominator"</span></pre>

  <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   3:</span>   <span style="color: #ff0000">MaxLength</span><span style="color: #0000ff">="3"</span></pre>

  <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   4:</span>   <span style="color: #ff0000">MinValue</span><span style="color: #0000ff">="1"</span></pre>

  <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   5:</span>   <span style="color: #ff0000">MaxValue</span><span style="color: #0000ff">="100"</span></pre>

  <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   6:</span>   <span style="color: #ff0000">Required-Enabled</span><span style="color: #0000ff">="True"</span> <span style="color: #0000ff">/&gt;</span></pre>
  </div>
</div>

<p>
  <br />The display of this control is what you'd expect to see, a Textbox with up/down arrows next to it.  But all of the following features are implemented as well:</p>

<ul>
  <li>RequiredFieldValidator, which on its own renders an icon next to the control that indicates that it's required (RequiredFieldIndicator control) </li>

  <li>CompareValidator, set to ensure that the data type is an integer (this can be overridden by setting the Type attribute on the control)</li>

  <li>RangeValidator, set to the range of 1-100 </li>

  <li>The validator controls have their error message automatically formatted to reference the field name: "Ratio Denominator is required" and "Ratio Denominator must be a whole number between 1 and 100" </li>
</ul>

<p>With ASP.NET MVC, things like this will be much more painful, and that is one of my biggest hesitations with using ASP.NET MVC.  My teams have relied on this type of productivity boost, and it would be a tough loss.  I'm very interested to see how the client-side validation problem gets solved within the MVC framework--it seems to be the biggest unknown as far as I can tell.</p>

<p>
  </p><hr />

<p>As an aside, this example can also serve as an example of why <em>only</em> having validation within the domain can fail.  If the domain only needs to know the ratio percentage, instead of the numerator and the denominator, but the UI needs to present it to the user as numerator and denominator, what do you do?</p>

<p>With my <a href="http://jeffhandley.com/archive/2007/11/09/an-extended-mvp-pattern-mvp-validation.aspx" target="_blank">Extended MVP pattern</a>, the View interface would include both the numerator and the denominator, and set up validation on both.  Then the Presenter would map that into the domain's percentage field appropriately. </p>
