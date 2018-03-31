---
layout: post
title: "A Fun ValidationAttribute Bug"
date: 2014-04-15 08:29:14 -0700
comments: true
tags: ["RIAServices", "Validation", "DataAnnotations"]
redirect_from: ["/archive/2014/04/15/A-Fun-ValidationAttribute-Bug.aspx/", "/archive/2014/04/15/a-fun-validationattribute-bug.aspx"]
author: "Jeff Handley"
---
<!-- more -->
I tweeted about a bug that I recently helped fix in System.ComponentModel.DataAnnotations.ValidationAttribute. As I said, it's a bug resulting from code I wrote for that class years ago. I was honestly surprised there was any interest in this, but there was! Since I piqued your interest, I thought it only fair that I quench your thirst and show you the details of the bug.
<blockquote class="twitter-tweet" lang="en"><p>I helped fix a bug in System.ComponentModel.DataAnnotations.ValidationAttribute today. A threading bug I introduced a long time ago. :-(</p>— Jeff Handley (@JeffHandley) <a href="https://twitter.com/JeffHandley/statuses/455887240602726400">April 15, 2014</a></blockquote>
<script async="" src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
<h2>History and Backwards Compatibility</h2> <p>The first implementation of ValidationAttribute had a method with the following signature:</p><pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">abstract</span> <span class="kwrd">bool</span> IsValid(<span class="kwrd">object</span> <span class="kwrd">value</span>);</pre>
<style type="text/css"><![CDATA[csharpcode, .csharpcode pre
{
	font-size: small;
	color: black;
	font-family: consolas, "Courier New", courier, monospace;
	background-color: #ffffff;
	/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt
{
	background-color: #f4f4f4;
	width: 100%;
	margin: 0em;
}
.csharpcode .lnum { color: #606060; }
]]></style>

<p> </p>
<p>Any class that inherited from ValidationAttribute had to override the IsValid method and put the validation logic in place.  This was fine and dandy until .NET 4.0 when I worked on a set of features to introduce context-aware validation attributes using new classes called ValidationContext and ValidationResult.  Using ValidationContext, validation attributes could perform complex business logic using application services or even calls into a database.  With this, we wanted to add an overload to IsValid to allow the following signature:</p><pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">abstract</span> ValidationResult IsValid(<span class="kwrd">object</span> <span class="kwrd">value</span>, ValidationContext validationContext);</pre><pre class="csharpcode"> </pre>
<style type="text/css"><![CDATA[csharpcode, .csharpcode pre
{
	font-size: small;
	color: black;
	font-family: consolas, "Courier New", courier, monospace;
	background-color: #ffffff;
	/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt
{
	background-color: #f4f4f4;
	width: 100%;
	margin: 0em;
}
.csharpcode .lnum { color: #606060; }
]]></style>

<p>Of course we couldn’t add a new abstract method to a class, as that would break existing implementations.  So instead, we looked into adding the following:</p><pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">virtual</span> ValidationResult IsValid(<span class="kwrd">object</span> <span class="kwrd">value</span>, ValidationContext validationContext) {
    ValidationResult result = ValidationResult.Success;

  <span class="kwrd">if</span> (!<span class="kwrd">this</span>.IsValid(<span class="kwrd">value</span>)) {
  <span class="kwrd">string</span>[] memberNames = validationContext.MemberName != <span class="kwrd">null</span> ? <span class="kwrd">new</span> <span class="kwrd">string</span>[] {
            validationContext.MemberName
        } : <span class="kwrd">null</span>;

        result = <span class="kwrd">new</span> ValidationResult(
  <span class="kwrd">this</span>.FormatErrorMessage(validationContext.DisplayName),
            memberNames);
    }

   <span class="kwrd">return</span> result;
}</pre>
<style type="text/css"><![CDATA[csharpcode, .csharpcode pre
{
	font-size: small;
	color: black;
	font-family: consolas, "Courier New", courier, monospace;
	background-color: #ffffff;
	/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt
{
	background-color: #f4f4f4;
	width: 100%;
	margin: 0em;
}
.csharpcode .lnum { color: #606060; }
]]></style>

<p> </p>
<p>This introduced a new problem: new attributes that want to use the ValidationContext must now override both overloads of IsValid, and that would be rather confusing.  We wanted new attributes to only have to override the ValidationContext-based IsValid overload and add documentation that the old boolean-based IsValid method should not be overridden—changing it from abstract to virtual.  We’d change that method to the following:</p><pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">virtual</span> <span class="kwrd">bool</span> IsValid(<span class="kwrd">object</span> <span class="kwrd">value</span>) {
  <span class="rem">// Call the ValidationContext-based method and if it's successful, return true</span>
  <span class="kwrd">return</span> <span class="kwrd">this</span>.IsValid(<span class="kwrd">value</span>, validationContext: <span class="kwrd">null</span>) == ValidationResult.Success;
}</pre>
<style type="text/css"><![CDATA[csharpcode, .csharpcode pre
{
	font-size: small;
	color: black;
	font-family: consolas, "Courier New", courier, monospace;
	background-color: #ffffff;
	/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt
{
	background-color: #f4f4f4;
	width: 100%;
	margin: 0em;
}
.csharpcode .lnum { color: #606060; }
]]></style>

<p> </p>
<p>This is where I got in the code before I introduced the bug.  We’ll cover that next.</p>
<h2>Ensuring One Overload is Overridden</h2>
<p>This is an unusual situation.  We want to introduce a new overload that calls into the original method if it’s overridden.  But we want to make the original method virtual and have it call into the new overload if it’s overridden.</p>
<p>Let’s state that again, because it can be confusing:</p>
<ol>
<li>If the original method is overridden, have the new overload’s base implementation call into it</li>
<li>If the new overload is overridden, have the original method’s base implementation call into it</li></ol>
<p>A third way of stating it is: </p>
<ol>
<li>Allow implementers to override either method</li>
<li>Call into the overridden method from whichever base implementation remains</li></ol>
<p>Needless to say, there’s a risk of a circular reference that we need to prevent too.  The way I solved this was to use a private field and a lock to track the state of whether a base implementation was in the middle of making a call to an overridden implementation.  You can see this in the .NET Framework reference source for the <a href="http://referencesource.microsoft.com/#System.ComponentModel.DataAnnotations/DataAnnotations/ValidationAttribute.cs#279" target="_blank">System.ComponentModel.DataAnnotations assembly’s ValudationAttribute class</a>.  Here’s the snippet too:</p><pre class="csharpcode"><span class="rem">/// &lt;summary&gt;</span>
<span class="rem">/// Gets the value indicating whether or not the specified &lt;paramref name="value"/&gt; is valid</span>
<span class="rem">/// with respect to the current validation attribute.</span>
<span class="rem">/// &lt;para&gt;</span>
<span class="rem">/// Derived classes should not override this method as it is only available for backwards compatibility.</span>
<span class="rem">/// Instead, implement &lt;see cref="IsValid(object, ValidationContext)"/&gt;.</span>
<span class="rem">/// &lt;/para&gt;</span>
<span class="rem">/// &lt;/summary&gt;</span>
<span class="rem">/// &lt;remarks&gt;</span>
<span class="rem">/// The preferred public entry point for clients requesting validation is the &lt;see cref="GetValidationResult"/&gt; method.</span>
<span class="rem">/// &lt;/remarks&gt;</span>
<span class="rem">/// &lt;param name="value"&gt;The value to validate&lt;/param&gt;</span>
<span class="rem">/// &lt;returns&gt;&lt;c&gt;true&lt;/c&gt; if the &lt;paramref name="value"/&gt; is acceptable, &lt;c&gt;false&lt;/c&gt; if it is not acceptable&lt;/returns&gt;</span>
<span class="rem">/// &lt;exception cref="InvalidOperationException"&gt; is thrown if the current attribute is malformed.&lt;/exception&gt;</span>
<span class="rem">/// &lt;exception cref="NotImplementedException"&gt; is thrown when neither overload of IsValid has been implemented</span>
<span class="rem">/// by a derived class.</span>
<span class="rem">/// &lt;/exception&gt;</span>
<span class="preproc">#if</span> !SILVERLIGHT
<span class="kwrd">public</span>
<span class="preproc">#else</span>
<span class="kwrd">internal</span>
<span class="preproc">#endif</span>
<span class="kwrd">virtual</span> <span class="kwrd">bool</span> IsValid(<span class="kwrd">object</span> <span class="kwrd">value</span>) {
  <span class="kwrd">lock</span> (<span class="kwrd">this</span>._syncLock) {
  <span class="kwrd">if</span> (<span class="kwrd">this</span>._isCallingOverload) {
  <span class="kwrd">throw</span> <span class="kwrd">new</span> NotImplementedException(DataAnnotationsResources.ValidationAttribute_IsValid_NotImplemented);
        } <span class="kwrd">else</span> {
  <span class="kwrd">this</span>._isCallingOverload = <span class="kwrd">true</span>;

  <span class="kwrd">try</span> {
  <span class="kwrd">return</span> <span class="kwrd">this</span>.IsValid(<span class="kwrd">value</span>, <span class="kwrd">null</span>) == <span class="kwrd">null</span>;
            } <span class="kwrd">finally</span> {
  <span class="kwrd">this</span>._isCallingOverload = <span class="kwrd">false</span>;
            }
        }
    }
}

<span class="preproc">#if</span> !SILVERLIGHT
<span class="rem">/// &lt;summary&gt;</span>
<span class="rem">/// Protected virtual method to override and implement validation logic.</span>
<span class="rem">/// &lt;para&gt;</span>
<span class="rem">/// Derived classes should override this method instead of &lt;see cref="IsValid(object)"/&gt;, which is deprecated.</span>
<span class="rem">/// &lt;/para&gt;</span>
<span class="rem">/// &lt;/summary&gt;</span>
<span class="rem">/// &lt;param name="value"&gt;The value to validate.&lt;/param&gt;</span>
<span class="rem">/// &lt;param name="validationContext"&gt;A &lt;see cref="ValidationContext"/&gt; instance that provides</span>
<span class="rem">/// context about the validation operation, such as the object and member being validated.&lt;/param&gt;</span>
<span class="rem">/// &lt;returns&gt;</span>
<span class="rem">/// When validation is valid, &lt;see cref="ValidationResult.Success"/&gt;.</span>
<span class="rem">/// &lt;para&gt;</span>
<span class="rem">/// When validation is invalid, an instance of &lt;see cref="ValidationResult"/&gt;.</span>
<span class="rem">/// &lt;/para&gt;</span>
<span class="rem">/// &lt;/returns&gt;</span>
<span class="rem">/// &lt;exception cref="InvalidOperationException"&gt; is thrown if the current attribute is malformed.&lt;/exception&gt;</span>
<span class="rem">/// &lt;exception cref="NotImplementedException"&gt; is thrown when &lt;see cref="IsValid(object, ValidationContext)" /&gt;</span>
<span class="rem">/// has not been implemented by a derived class.</span>
<span class="rem">/// &lt;/exception&gt;</span>
<span class="preproc">#else</span>
<span class="rem">/// &lt;summary&gt;</span>
<span class="rem">/// Protected virtual method to override and implement validation logic.</span>
<span class="rem">/// &lt;/summary&gt;</span>
<span class="rem">/// &lt;param name="value"&gt;The value to validate.&lt;/param&gt;</span>
<span class="rem">/// &lt;param name="validationContext"&gt;A &lt;see cref="ValidationContext"/&gt; instance that provides</span>
<span class="rem">/// context about the validation operation, such as the object and member being validated.&lt;/param&gt;</span>
<span class="rem">/// &lt;returns&gt;</span>
<span class="rem">/// When validation is valid, &lt;see cref="ValidationResult.Success"/&gt;.</span>
<span class="rem">/// &lt;para&gt;</span>
<span class="rem">/// When validation is invalid, an instance of &lt;see cref="ValidationResult"/&gt;.</span>
<span class="rem">/// &lt;/para&gt;</span>
<span class="rem">/// &lt;/returns&gt;</span>
<span class="rem">/// &lt;exception cref="InvalidOperationException"&gt; is thrown if the current attribute is malformed.&lt;/exception&gt;</span>
<span class="rem">/// &lt;exception cref="NotImplementedException"&gt; is thrown when &lt;see cref="IsValid(object, ValidationContext)" /&gt;</span>
<span class="rem">/// has not been implemented by a derived class.</span>
<span class="rem">/// &lt;/exception&gt;</span>
<span class="preproc">#endif</span>
<span class="kwrd">protected</span> <span class="kwrd">virtual</span> ValidationResult IsValid(<span class="kwrd">object</span> <span class="kwrd">value</span>, ValidationContext validationContext) {
  <span class="kwrd">lock</span> (<span class="kwrd">this</span>._syncLock) {
  <span class="kwrd">if</span> (<span class="kwrd">this</span>._isCallingOverload) {
  <span class="kwrd">throw</span> <span class="kwrd">new</span> NotImplementedException(DataAnnotationsResources.ValidationAttribute_IsValid_NotImplemented);
        } <span class="kwrd">else</span> {
  <span class="kwrd">this</span>._isCallingOverload = <span class="kwrd">true</span>;

  <span class="kwrd">try</span> {
                ValidationResult result = ValidationResult.Success;

  <span class="kwrd">if</span> (!<span class="kwrd">this</span>.IsValid(<span class="kwrd">value</span>)) {
  <span class="kwrd">string</span>[] memberNames = validationContext.MemberName != <span class="kwrd">null</span> ? <span class="kwrd">new</span> <span class="kwrd">string</span>[] { validationContext.MemberName } : <span class="kwrd">null</span>;
                    result = <span class="kwrd">new</span> ValidationResult(<span class="kwrd">this</span>.FormatErrorMessage(validationContext.DisplayName), memberNames);
                }
  <span class="kwrd">return</span> result;
            } <span class="kwrd">finally</span> {
  <span class="kwrd">this</span>._isCallingOverload = <span class="kwrd">false</span>;
            }
        }
    }
}
</pre>
<p>
</p><style type="text/css"><![CDATA[csharpcode, .csharpcode pre
{
	font-size: small;
	color: black;
	font-family: consolas, "Courier New", courier, monospace;
	background-color: #ffffff;
	/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt
{
	background-color: #f4f4f4;
	width: 100%;
	margin: 0em;
}
.csharpcode .lnum { color: #606060; }
]]></style>

<p>You’ll notice a fun detail in that for Silverlight code (we cross-compile this code to .NET and Silverlight), we made the original method internal instead of public, because it was a new class for Silverlight—therefore there was no reason to even introduce the method on the public surface area.  Instead, we’d only have the ValidationContext-based approach.</p>
<h2>Locks Are Bad</h2>
<p>So this is where the code landed.  I had it code reviewed by about a dozen smart people—all much smarter than me in fact.  We all felt sick to our stomachs about it, but we couldn’t think of a better way to accomplish it.  I got code review sign-off, checked in, and this code has been in place for several years now.</p>
<p>Recently though, our team that helps service older code found that this lock I created is quite the bottleneck when validating a lot of attributes.  I don’t know the specific scenario, but it doesn’t really matter—that lock that I used was a bad idea and it’s causing a performance bottleneck for some customers.  It needed to be fixed.</p>
<h2>A Cleaner Approach</h2>
<p>A couple of weeks ago, Miguel Lacouture worked up a much cleaner approach to solving this problem that doesn’t use locks.  He asked if I would code review his fix since I had written the original code.  I had some review feedback for him, but his approach seems significantly superior to what I had come up with long ago.  With the feedback I sent him, here’s the proposed new implementation for these two methods:</p><pre class="csharpcode"><span class="kwrd">private</span> <span class="kwrd">bool</span> _hasBaseIsValid = <span class="kwrd">false</span>;
<span class="kwrd">private</span> <span class="kwrd">bool</span> _hasBaseIsValidWithContext = <span class="kwrd">false</span>;

<span class="kwrd">virtual</span> <span class="kwrd">bool</span> IsValid(<span class="kwrd">object</span> <span class="kwrd">value</span>) {
  <span class="rem">// Track that this overload wasn't overridden</span>
  <span class="kwrd">if</span> (!_hasBaseIsValid) {
        _hasBaseIsValid = <span class="kwrd">true</span>;
    }

  <span class="rem">// That means that the other overload must be overridden</span>
  <span class="rem">// And if it hasn't been, then throw a NotImplementedException</span>
  <span class="kwrd">if</span> (_hasBaseIsValidWithContext) {
  <span class="kwrd">throw</span> <span class="kwrd">new</span> NotImplementedException(DataAnnotationsResources.ValidationAttribute_IsValid_NotImplemented);
    }

  <span class="rem">// We know the other overload was overridden</span>
  <span class="rem">// So call it to produce the result</span>
  <span class="kwrd">return</span> <span class="kwrd">this</span>.IsValid(<span class="kwrd">value</span>, <span class="kwrd">null</span>) == <span class="kwrd">null</span>;
}

<span class="kwrd">virtual</span> ValidationResult IsValid(<span class="kwrd">object</span> <span class="kwrd">value</span>, ValidationContext validationContext) {
  <span class="rem">// Track that this overload wasn't overridden</span>
  <span class="kwrd">if</span> (!_hasBaseIsValidWithContext) {
        _hasBaseIsValidWithContext = <span class="kwrd">true</span>;
    }

  <span class="rem">// That means that the other overload must be overridden</span>
  <span class="rem">// And if it hasn't been, then throw a NotImplementedException</span>
  <span class="kwrd">if</span> (_hasBaseIsValid) {
  <span class="kwrd">throw</span> <span class="kwrd">new</span> NotImplementedException(DataAnnotationsResources.ValidationAttribute_IsValid_NotImplemented);
    }

  <span class="rem">// We know the other overload was overridden</span>
  <span class="rem">// So call it to produce the result</span>
    ValidationResult result = ValidationResult.Success;

  <span class="kwrd">if</span> (!<span class="kwrd">this</span>.IsValid(<span class="kwrd">value</span>)) {
  <span class="kwrd">string</span>[] memberNames = validationContext.MemberName != <span class="kwrd">null</span> ? <span class="kwrd">new</span> <span class="kwrd">string</span>[] {
        validationContext.MemberName
    } : <span class="kwrd">null</span>;

    result = <span class="kwrd">new</span> ValidationResult(
  <span class="kwrd">this</span>.FormatErrorMessage(validationContext.DisplayName),
        memberNames);

  <span class="kwrd">return</span> result;
}
</pre>
<p>
</p><style type="text/css"><![CDATA[csharpcode, .csharpcode pre
{
	font-size: small;
	color: black;
	font-family: consolas, "Courier New", courier, monospace;
	background-color: #ffffff;
	/*white-space: pre;*/
}
.csharpcode pre { margin: 0em; }
.csharpcode .rem { color: #008000; }
.csharpcode .kwrd { color: #0000ff; }
.csharpcode .str { color: #006080; }
.csharpcode .op { color: #0000c0; }
.csharpcode .preproc { color: #cc6633; }
.csharpcode .asp { background-color: #ffff00; }
.csharpcode .html { color: #800000; }
.csharpcode .attr { color: #ff0000; }
.csharpcode .alt
{
	background-color: #f4f4f4;
	width: 100%;
	margin: 0em;
}
.csharpcode .lnum { color: #606060; }
]]></style>

<p>The general idea is that the lock was simply unnecessary because we can easily just record which of the base implementations still exist, and then determine if they both exist.  The lock was guarding against multiple threads calling into one of the IsValid implementations and temporarily flipping a bit to true when we were calling an overload.  But this new approach just turns switches on and if multiple threads come in it won’t cause any problems.</p>
<h2>Look Good?</h2>
<p>This code is unique—ensuring that 1 of 2 overloads is overridden—and the existing bug has been there for years.  What do you think of the new implementation?  See any holes in it?  Of course, Miguel and the rest of his team will test the heck out of the new implementation, but if you see any issues with it, let me know.</p>
<p>Kudos to Miguel for finding a novel approach to solving the problem.  I wish I’d thought of this approach back when I was writing this code for RIA Services.</p>
<div id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:323afdd4-7645-4d96-92b8-6ffac840f455" class="wlWriterEditableSmartContent" style="float: none; padding-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; display: inline; padding-right: 0px">Technorati Tags: <a href="http://technorati.com/tags/RIAServices" rel="tag">RIAServices</a>,<a href="http://technorati.com/tags/Validation" rel="tag">Validation</a>,<a href="http://technorati.com/tags/DataAnnotations" rel="tag">DataAnnotations</a></div>

