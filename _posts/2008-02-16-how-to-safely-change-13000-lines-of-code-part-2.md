---
layout: post
title: "How to safely change 13,000 lines of code, part 2"
date: 2008-02-16 07:28:12 -0800
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.com/archive/2008/02/15/how-to-safely-change-13000-lines-of-code-part-2.aspx"]
author: 0
---
<!-- more -->
<p>Frankly, this isn't going as well as I hoped it would.  I'm pretty happy with the naming convention that I <a href="http://blog.jeffhandley.com/archive/2008/02/09/how-to-safely-change-13000-lines-of-code-part-1.aspx" target="_blank">ended up with</a>, but the search and replace isn't going so well to this point.</p>  <p>I had estimated that 30% of the usage of the previous methods would be incorrect.  But then I stated that was a pessimistic estimate.  I don't have numbers, but so far it feels like we were wrong more often than we were right.  What's <em>kind of</em> reassuring is that in most places where mistakes were made, 2 mistakes were made, and, well, 2 wrongs made a right.  This allowed the application to work, even though the code wasn't what I would have wanted.</p>  <p>Here's what I mean by the 2 wrongs making a right:</p>  <div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.5%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; background-color: #f4f4f4">   <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">     <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   1:</span> txtSectionNumber.Text = Formatting.IsStringEmptyString(CourseSection(<span style="color: #006080">"SectionNumber"</span>).ToString)</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   2:</span>  </pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   3:</span> ddlAdministrativeSchool.SelectedIndex = _</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   4:</span>     ddlAdministrativeSchool.Items.IndexOf( _</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   5:</span>         ddlAdministrativeSchool.Items.FindByValue( _</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   6:</span>             IsNullString(Trim(<span style="color: #0000ff">CType</span>(ContentRow(<span style="color: #006080">"AdministrativeSchoolId"</span>), Guid).ToString))))</pre>
  </div>
</div>

<p>
  <br />That code should have been (using the old methods):</p>

<div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.5%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; background-color: #f4f4f4">
  <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">
    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   1:</span> txtSectionNumber.Text = Formatting.DisplayIsNullInteger(CourseSection(<span style="color: #006080">"SectionNumber"</span>))</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   2:</span>  </pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   3:</span> ddlAdministrativeSchool.SelectByGuid(IsNullGuid(ContentRow(<span style="color: #006080">"AdministrativeSchoolId"</span>)))</pre>
  </div>
</div>

<p>
  <br />On the section number line, it was following this path:</p>

<ol>
  <li>Convert the database value to a string (wrong)</li>

  <li>Convert the string to a string (wrong)</li>
</ol>

<p>In the case of a value being specified, it would be a numeric string.  In the case of a DBNull, it would be an empty string.  This worked.  But here's what it should've done:</p>

<ol>
  <li>Convert the database value to an integer, using a constant (Integer.MinValue) to represent DBNull</li>

  <li>Format that integer for display, which will replace the constant with an empty string</li>
</ol>

<p>On the administrative school dropdown... well, yuck!!  It was doing the following:</p>

<ol>
  <li>Convert the database value to a Guid (would barf if it was null, wrong)</li>

  <li>Convert the Guid to a string</li>

  <li>Trim the string (because Guids often have padding coming out of the database!?, wrong)</li>

  <li>Ensure that string isn't DBNull (which is superfluous because that's impossible, wrong)</li>

  <li>Find the dropdown item having a value matching that string (should be finding it by Guid, wrong)</li>

  <li>Get the index of that dropdown item (why do it this way?, wrong)</li>

  <li>Set the selected index to that index (why do it this way?, wrong)</li>
</ol>

<p>That's just all kinds of wrong.  By some miracle, it worked though.  Here's what it should've done:</p>

<ol>
  <li>Convert the database value to a Guid, using Guid.Empty (the constant defined) to represent DBNull</li>

  <li>Select the dropdown item that has a value matching that Guid</li>
</ol>

<p>Using the new nullable types classes (remember, I'm in .NET 1.1 here), here's what the code looks like:</p>

<div style="border-right: gray 1px solid; padding-right: 4px; border-top: gray 1px solid; padding-left: 4px; font-size: 8pt; padding-bottom: 4px; margin: 20px 0px 10px; overflow: auto; border-left: gray 1px solid; width: 97.5%; cursor: text; max-height: 200px; line-height: 12pt; padding-top: 4px; border-bottom: gray 1px solid; font-family: consolas, 'Courier New', courier, monospace; background-color: #f4f4f4">
  <div style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none">
    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   1:</span> txtSectionNumber.Text = NullableInt32.ForDisplay(CourseSection(<span style="color: #006080">"SectionNumber"</span>))</pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: #f4f4f4; border-bottom-style: none"><span style="color: #606060">   2:</span>  </pre>

    <pre style="padding-right: 0px; padding-left: 0px; font-size: 8pt; padding-bottom: 0px; margin: 0em; overflow: visible; width: 100%; color: black; border-top-style: none; line-height: 12pt; padding-top: 0px; font-family: consolas, 'Courier New', courier, monospace; border-right-style: none; border-left-style: none; background-color: white; border-bottom-style: none"><span style="color: #606060">   3:</span> ddlAdministrativeSchool.SelectByGuid(NullableGuid.From(ContentRow(<span style="color: #006080">"AdministrativeSchoolId"</span>)))</pre>
  </div>
</div>

<p>
  <br />A couple of sidebar notes:</p>

<ol>
  <li>I <em>did</em> end up needing a separate method of ForDisplay.  I was previously thinking that the From method would do all of the work, but that fell short of formatting for display.  I had forgotten about the DisplayIsNull* methods.  During the search and replace, I remembered that I'd need to be able to display values, replacing their magic numbers with empty strings.  I originally implemented the ForDisplay method as ToString, but this felt like I was building a whole new IsStringEmpty method which would still be misused.</li>

  <li>I also have a ForDatabase method that will return DBNull.value when a value is null, ensuring that we don't pass a constant like Integer.MinValue into the database.  The core of the data access layer calls into this when any parameter value is specified, so the developers never touch this method.</li>

  <li>Our dropdown control supports a method for SelectByGuid.  We also have other methods similar to this, but since we use Guids ubiquitously, it is very helpful to have this method.  Just one of the many reasons why I swear by <a href="http://blog.jeffhandley.com/archive/2008/02/13/custom-controls-everywhere-and-asp.net-mvc-part-0.aspx" target="_blank">Custom Controls Everywhere</a>.</li>
</ol>

<p>I have finished implementing the NullableString class throughout the application.  I think I'll do the Guids next because I love Guids, and yesterday was Valentine's Day.</p>

<div class="wlWriterSmartContent" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:cc72488c-fa6f-43c3-8690-7a98d1e86e42" style="padding-right: 0px; display: inline; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px">Technorati Tags: <a href="http://technorati.com/tags/Nullable%20Types" rel="tag">Nullable Types</a>,<a href="http://technorati.com/tags/.NET%201.1" rel="tag">.NET 1.1</a>,<a href="http://technorati.com/tags/ASP.NET" rel="tag">ASP.NET</a>,<a href="http://technorati.com/tags/Custom%20Controls%20Everywhere" rel="tag">Custom Controls Everywhere</a></div>

