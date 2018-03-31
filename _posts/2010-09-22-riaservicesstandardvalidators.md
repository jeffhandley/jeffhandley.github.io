---
layout: post
title: "RIA Services Validation: Standard Validators"
date: 2010-09-22 10:16:10 -0700
comments: true
tags: ["RiaServicesValidation", "RiaServices", "Validation", "Silverlight", "DataAnnotations"]
redirect_from: ["/archive/2010/09/22/RiaServicesStandardValidators.aspx/", "/archive/2010/09/22/riaservicesstandardvalidators.aspx"]
author: "Jeff Handley"
---
<!-- more -->
<p>RIA Services offers powerful features for flowing validation from your entity model all the way up to the Silverlight UI.  In fact, flowing your validation rules from the server into your form controls was one of the primary tenets of RIA Services V1, and our team did the work of getting validation integrated deeply into Silverlight, long before RIA Services was released.  In this post we’ll take a look at the standard validators that are offered.</p>  <h3>System.ComponentModel.DataAnnotations.ValidationAttribute</h3>  <p>RIA Services employs the <a title="MSDN: System.ComponentModel.DataAnnotations.ValidationAttribute" href="http://msdn.microsoft.com/en-us/library/system.componentmodel.dataannotations.validationattribute.aspx" target="_blank">ValidationAttribute</a> class from <a title="MSDN: System.ComponentModel.DataAnnotations" href="http://msdn.microsoft.com/en-us/library/system.componentmodel.dataannotations.aspx" target="_blank">System.ComponentModel.DataAnnotations</a> for defining validation rules on your entity model.  ValidationAttribute itself is abstract <em>(VB: MustInherit)</em> but any class that derives from ValidationAttribute will be treated as a “validator.”  Validators can be applied to properties and classes alike, allowing for property-level or object-level validators.  Some common property-level validators are predefined within the DataAnnotations assembly:</p>  <ol>   <li><a href="http://msdn.microsoft.com/en-us/library/system.componentmodel.dataannotations.requiredattribute.aspx" target="_blank">RequiredAttribute</a> </li>    <li><a href="http://msdn.microsoft.com/en-us/library/system.componentmodel.dataannotations.rangeattribute.aspx" target="_blank">RangeAttribute</a> </li>    <li><a href="http://msdn.microsoft.com/en-us/library/system.componentmodel.dataannotations.stringlengthattribute.aspx" target="_blank">StringLengthAttribute</a> </li>    <li><a href="http://msdn.microsoft.com/en-us/library/system.componentmodel.dataannotations.regularexpressionattribute.aspx" target="_blank">RegularExpressionAttribute</a> </li> </ol>  <p>These four validators alone will cover a great deal of your validation scenarios.  Of course, we all know that <a title="Regular Expressions: Now You Have Two Problems (CodingHorror.com)" href="http://www.codinghorror.com/blog/2008/06/regular-expressions-now-you-have-two-problems.html" target="_blank">when you solve a problem using a regular expression, you now have two problems</a>.  But in all seriousness, these four little attributes can be extremely useful and they are what we’ll be focusing on within this post.  Here’s a sample class that utilizes these validators and a screen shot for what the UI does with these validators.</p>  <div id="codeSnippetWrapper"> </div>  <div id="codeSnippetWrapper">   <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px" id="codeSnippet">     <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #0000ff">using</span> System;</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #0000ff">using</span> System.ComponentModel.DataAnnotations;</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #0000ff">using</span> RudeValidation.Web.Resources;</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #0000ff">using</span> RudeValidation.Web.Validators;</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #0000ff">namespace</span> RudeValidation.Web.Models</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">{</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">    <span style="color: #0000ff">public</span> <span style="color: #0000ff">partial</span> <span style="color: #0000ff">class</span> Meeting</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">    {</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        [Key]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> MeetingId { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        [Required]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        <span style="color: #0000ff">public</span> DateTime Start { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        [Required]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        <span style="color: #0000ff">public</span> DateTime End { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        [Required]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        [StringLength(80, MinimumLength = 5,</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">            ErrorMessageResourceType = <span style="color: #0000ff">typeof</span>(ValidationErrorResources),</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">            ErrorMessageResourceName = <span style="color: #006080">"TitleStringLengthErrorMessage"</span>)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">            <span style="color: #008000">// {0} must be at least {2} characters and no more than {1}.</span></pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Title { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Details { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        [Required]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        [RegularExpression(<span style="color: #006080">@"\d{1,3}/\d{4}"</span>,</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">            ErrorMessage = <span style="color: #006080">"{0} must be in the format of 'Building/Room'"</span>)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Location { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        [Range(2, 100)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        [Display(Name = <span style="color: #006080">"Minimum Attendees"</span>)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> MinimumAttendees { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        [Range(2, 100)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        [Display(Name = <span style="color: #006080">"Maximum Attendees"</span>)]</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">        <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> MaximumAttendees { get; set; }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">    }</pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px">}</pre>
<!--CRLF--></div>
</div>

<p> </p>

<p><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="Validation errors display" border="0" alt="Validation errors display" src="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/RIAServicesValidation101_F17/image_f130885b-7714-43e1-9cfa-5355d119ed8b.png" width="541" height="216" /></p>

<h3>Error Messages</h3>

<p>All validators have default error messages (including ValidationAttribute itself, so that all derived validators get <em>some sort of message</em>).  When using validators, you can easily override the error message using the ErrorMessage property.  This allows for context-appropriate error messages to be used on your model.  The Location property above shows an example of setting the ErrorMessage.  Notice that the error message uses a {0} placeholder—this is completely optional, but it allows for the display name of the property to be plugged in wherever the placeholder is used.</p>

<p>It’s important to note that the above sentence said, “the display name of the property,” and not, “the property name.”  This is because the <a title="MSDN: System.ComponentModel.DataAnnotations.DisplayAttribute" href="http://msdn.microsoft.com/en-us/library/system.componentmodel.dataannotations.displayattribute.aspx" target="_blank">DisplayAttribute</a> is respected when error messages are being formatted.  If the property has a [Display] attribute declared, and the Name property has been specified on it, then that value will be used in place of the actual property name.  When a Display Name is not available, the property name itself will be used.  Whenever you have property names that are compound words, you should use a [Display] attribute to ensure your validation error messages are user-friendly.</p>

<p><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="RESX file Access Modifier: Public" border="0" alt="RESX file Access Modifier: Public" align="right" src="http://jeffhandley.com/images/jeffhandley_com/WindowsLiveWriter/RIAServicesValidation101_F17/image_3.png" width="353" height="69" />And speaking of being user-friendly, let’s talk about localization for a moment.  If you are making your application localizable, you can utilize the ErrorMessageResourceType and ErrorMessageResourceName properties on the validators to specify localizable error messages.  Be sure that your resource file has the access modifier set to public though, or else RIA Services won’t be able to propagate your validator because it will fail to load the type you specify as the ErrorMessageResourceType.  The resources need to be available within the Silverlight project too.  Fortunately the Business Application Project template that ships with RIA Services sets all of this up for you, and you can simply add your error messages to the ValidationErrorResources.resx file and everything will work straight-away.</p>

<p>Some validators offer additional placeholders for their error messages beyond the {0} placeholder for the display name of the property.</p>

<ol>
  <li><strong>[Required]</strong> – No additional placeholders </li>

  <li><strong>[Range(minimumValue, maximumValue)]</strong> – {1} = minimumValue; {2} = maximumValue </li>

  <li><strong>[StringLength(maxLength)]</strong> – {1} = maxLength </li>

  <li><strong>[StringLength(maxLength, MinimumLength = minLength)]</strong> – {1} = maxLength; {2} = minLength 

    <br />Note – Yes, {2} is the <em>minimum length</em> so that {1} is always the <em>maximum length</em>. </li>

  <li><strong>[RegularExpression(regEx)]</strong> – {1} = the regular expression specified, although it would be a crime to allow this to display in your UI (even though it will by default) </li>
</ol>

<h3>Nothing is Required, Except for Required</h3>

<p>When using RangeAttribute, StringLengthAttribute, or RegularExpressionAttribute, you might notice something that seems bizarre at first—these validators all indicate success when the field is blank.  You might ask, “If I’ve said my value must be between 2 and 100, why don’t I get an error message if the field is blank?”  The explanation for this is actually quite simple: Unless the field is marked as [Required], it is not required.  Furthermore, if [Range], [StringLength], and [RegularExpression] enforced non-blank values, then you’d have no way of validating optional field values.  Therefore it’s essential that the [Required] validator is the only one that ever indicates failure if the value is blank.</p>

<h3>RIA Services Validation Recap:</h3>

<ol>
  <li><a title="RIA Services Validation: Standard Validators" href="http://jeffhandley.com/archive/2010/09/22/RiaServicesStandardValidators.aspx">Standard Validators</a> </li>

  <li><a title="RIA Services Validation: Custom Validation Methods" href="/archive/2010/09/25/RiaServicesCustomValidationMethods.aspx">Custom Validation Methods</a> </li>

  <li><a title="RIA Services Validation: Custom Reusable Validators" href="/archive/2010/09/26/RiaServicesCustomReusableValidators.aspx" target="_blank">Custom Reusable Validators</a> </li>

  <li><a title="RIA Services Validation: Attribute Propagation" href="/archive/2010/09/30/RiaServicesValidationAttributePropagation.aspx">Attribute Propagation</a> </li>

  <li><a href="/archive/2010/10/06/RiaServicesValidationTriggers.aspx">Validation Triggers</a> </li>

  <li><a title="RIA Services Validation: Cross-Field Validation" href="/archive/2010/10/10/CrossFieldValidation.aspx">Cross-Field Validation</a> </li>

  <li><a title="RIA Services Validation: Entity-Level Validation" href="/archive/2010/10/12/EntityLevelValidation.aspx">Entity-Level Validation</a> </li>

  <li><a title="RIA Services Validation: Providing ValidationContext" href="/archive/2010/10/25/RiaServicesValidationContext.aspx">Providing ValidationContext</a> </li>

  <li><a title="RIA Services Validation: Using ValidationContext (Cross-Entity Validation)" href="/archive/2010/10/25/CrossEntityValidation.aspx">Using ValidationContext (Cross-Entity Validation)</a> </li>

  <li><a title="RIA Services Validation: ViewModel Validation with Entity Rules" href="http://jeffhandley.com/archive/2011/09/06/ViewModelValidation.aspx">ViewModel Validation with Entity Rules</a> </li>
</ol>

<p><strong><em>[9/6/2011] The source code for everything shown during the series is <a title="RIA Services Validation: Available on GitHub" href="http://jeffhandley.com/archive/2011/09/06/RIA-Services-Validation-Available-on-GitHub.aspx">available on GitHub</a>.</em></strong></p>

<h3>Digging Deeper</h3>

<p>I will be digging deeper into RIA Services Validation in upcoming blog posts, but I wanted to make sure the foundation was laid for how these standard validators work.  In future posts, we’ll be exploring how RIA Services actually propagates your validators to the client, how you can create custom validators by using [CustomValidation] and by deriving from ValidationAttribute directly, as well as when/how RIA Services will invoke each kind of validator.</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:275a5644-8516-484c-b8c4-96e2844fafde" class="wlWriterEditableSmartContent">Technorati Tags: <a href="http://technorati.com/tags/RiaServicesValidation" rel="tag">RiaServicesValidation</a>,<a href="http://technorati.com/tags/RiaServices" rel="tag">RiaServices</a>,<a href="http://technorati.com/tags/Validation" rel="tag">Validation</a>,<a href="http://technorati.com/tags/Silverlight" rel="tag">Silverlight</a>,<a href="http://technorati.com/tags/DataAnnotations" rel="tag">DataAnnotations</a></div>

