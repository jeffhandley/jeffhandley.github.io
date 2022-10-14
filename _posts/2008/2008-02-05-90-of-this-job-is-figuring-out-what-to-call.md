---
layout: post
title: "90% of this job is figuring out what to call stuff"
date: 2008-02-05 23:50:15 -0800
comments: true
tags: ["Naming Conventions", "Nullable Types"]
redirect_from: ["/archive/2008/02/05/90-of-this-job-is-figuring-out-what-to-call.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="209" alt="Dilbert 5/4/2004" src="/img/postimages/90ofthisjobisfiguringoutwhattocallstuff_DEB3/clip_image001.gif" width="604" border="0" /></p>  <p>This has always been one of my favorite Dilbert strips.  Why?  Because in our field, it's true.  Many times I've spent more time figuring out what to call something than I spent actually developing it.</p>  <p>This week, I've been gathering ideas from team members on how to name some methods that we use throughout our application.  The existing names are ambiguous and the methods have not always been used correctly, so I want to rename them to something that makes sense.</p>  <p>We have 2 sets of methods for working with "nullable" values.  Pretty standard stuff:</p>  <ol>   <li>Take a database value (object) and return a value of the desired type, using a magic value to represent null</li>  <li>Take a user-entered value (string) and return a value of the desired type, using a magic value to represent null</li> </ol>  <p>We have a pair of methods for each data type that we work with: Guid, String, Integer, Decimal, etc.  The methods are ubiquitous as all user input needs to (should) flow through one of these methods, and all database values need to (should) flow through the other.  So virtually every field entered or displayed for edit is using these methods.  Sadly, the methods have been inconsistently used and we have potential bugs out there.</p>  <p>Presently, these methods are named: IsNull* and IsStringEmpty*.  Since I like to talk about Guids, we'll show the examples for that data type.</p>  <div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.5%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; background-color: #f4f4f4">   <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">   <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   1:</span> <span style="color: #0000ff">Dim</span> StudentId <span style="color: #0000ff">As</span> Guid = IsNullGuid(drStudent(<span style="color: #006080">"StudentId"</span>))</pre>

  <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   2:</span>  </pre>

  <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   3:</span> ...</pre>

  <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   4:</span>  </pre>

  <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   5:</span> <span style="color: #0000ff">Dim</span> StudentId <span style="color: #0000ff">As</span> Guid = IsStringEmptyGuid(ddlStudent.SelectedValue)</pre>
  </div>
</div>

<p>
  <br />Since I created this nomenclature, it's always made sense to me; but to others, not so much.  What should these methods be called?  Here are some of the candidates we've had today: (using Guids for the example)</p>

<ol>
  <li>GuidFromDatabase &amp; GuidFromScreen</li>

  <li>NullableGuidFromDatabase &amp; NullableGuidFromUserInput</li>

  <li>ConvertDBValueToNullableGuid &amp; ConvertUserInputToNullableGuid</li>

  <li>ConvertDbToNullGuid &amp; ConvertUIToNullGuid</li>

  <li>DbToNullableGuid &amp; UIToNullableGuid</li>

  <li>CallThisFunctionToConvertADatabaseValueToANullableGuidForUseInApplicationCode (facetious of course)</li>
</ol>

<p>I want something succinct but unambiguous, so I think options 1 and 2 are at the top of my list.  What say you?</p>

<p>
  </p><hr /><em>Since we're using .NET 1.1, we can't actually use nullable types or generics.</em>

