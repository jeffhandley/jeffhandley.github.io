---
layout: post
title: "Writing a Custom Filter or Parameter for DomainDataSource"
date: 2010-03-18 23:14:15 -0700
comments: true
tags: ["DomainDataSource", "RIAServices", "ControlParameter", "FilterDescriptor", "Kyle McClellan"]
redirect_from: ["/archive/2010/03/18/custom-filter-parameter.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p><em>This post comes to you from a guest writer, <strong>Kyle McClellan</strong>.  Kyle works with me on the RIA Services team and he’s contributed to the DomainDataSource feature (among many other features in the framework).  Kyle made the changes that allowed us to remove ControlParameter and use ElementName bindings for FilterDescriptor and Parameter that I <a href="http://jeffhandley.com/archive/2010/03/15/filters-parameters.aspx" target="_blank">recently blogged about</a>.</em></p>  <hr />  <p>Now that the <b>ControlParameter</b> has been properly disposed of, you might have noticed that Parameter has changed substantially. Before, a <b>Parameter</b> was used for filtering, grouping, sorting, and querying. Now it is only used in the last case. If you had previously defined your own parameter types, you might be wondering how to leverage them in the RIA Services RC release.</p>  <p>A common request is to pass the user’s name or other profile information through to a <b>DomainService</b> operation. Please keep in mind this is not a substitute for authentication or authorization, but can be effectively used to shape the data that is being returned. In the RC release, you can write it like this.</p>  <div id="codeSnippetWrapper">   <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px" id="codeSnippet">   <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">&lt;</span><span style="color: #800000">dds:DomainDataSource</span> <span style="color: #ff0000">x:Name</span><span style="color: #0000ff">="DDS"</span> <span style="color: #ff0000">QueryName</span><span style="color: #0000ff">="GetEntitiesForUser"</span><span style="color: #0000ff">&gt;</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">&lt;</span><span style="color: #800000">dds:DomainDataSource.DomainContext</span><span style="color: #0000ff">&gt;</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">&lt;</span><span style="color: #800000">appweb:SampleContext</span> <span style="color: #0000ff">/&gt;</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">&lt;/</span><span style="color: #800000">dds:DomainDataSource.DomainContext</span><span style="color: #0000ff">&gt;</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">&lt;</span><span style="color: #800000">dds:DomainDataSource.QueryParameters</span><span style="color: #0000ff">&gt;</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">&lt;</span><span style="color: #800000">dds:Parameter</span> <span style="color: #ff0000">ParameterName</span><span style="color: #0000ff">="userName"</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">   <span style="color: #ff0000">Value</span><span style="color: #0000ff">="{Binding User.Name, Source={StaticResource WebContext}}"</span> <span style="color: #0000ff">/&gt;</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">&lt;/</span><span style="color: #800000">dds:DomainDataSource.QueryParameters</span><span style="color: #0000ff">&gt;</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">&lt;/</span><span style="color: #800000">dds:DomainDataSource</span><span style="color: #0000ff">&gt;</span></pre>
<!--CRLF--></div>
</div>

<br />

<p>However, you might find this gets tedious or want to encapsulate common functionality you use frequently. The solution in our RC release is to create your own derived filter or parameter type. A careful observer might notice we left the <b>FilterDescriptor</b>, <b>GroupDescriptor</b>, <b>Parameter</b>, and <b>SortDescriptor</b> unsealed for just this reason. This allows you to create a new <b>CurrentUserParameter</b> type and write the following.</p>

<div id="codeSnippetWrapper">
  <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px" id="codeSnippet">
  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">&lt;</span><span style="color: #800000">dds:DomainDataSource</span> <span style="color: #ff0000">x:Name</span><span style="color: #0000ff">="DDS"</span> <span style="color: #ff0000">QueryName</span><span style="color: #0000ff">="GetEntitiesForUser"</span><span style="color: #0000ff">&gt;</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">&lt;</span><span style="color: #800000">dds:DomainDataSource.DomainContext</span><span style="color: #0000ff">&gt;</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">&lt;</span><span style="color: #800000">appweb:SampleContext</span> <span style="color: #0000ff">/&gt;</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">&lt;/</span><span style="color: #800000">dds:DomainDataSource.DomainContext</span><span style="color: #0000ff">&gt;</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">&lt;</span><span style="color: #800000">dds:DomainDataSource.QueryParameters</span><span style="color: #0000ff">&gt;</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">&lt;</span><span style="color: #800000">app:CurrentUserParameter</span> <span style="color: #ff0000">ParameterName</span><span style="color: #0000ff">="userName"</span><span style="color: #0000ff">/&gt;</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">&lt;/</span><span style="color: #800000">dds:DomainDataSource.QueryParameters</span><span style="color: #0000ff">&gt;</span></pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">&lt;/</span><span style="color: #800000">dds:DomainDataSource</span><span style="color: #0000ff">&gt;</span></pre>
<!--CRLF--></div>
</div>

<br />

<p>In the constructor of the <b>CurrentUserParameter</b>, you can take care of binding and other initialization.</p>

<div id="codeSnippetWrapper">
  <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px" id="codeSnippet">
  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> CurrentUserParameter : Parameter</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">{</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">public</span> CurrentUserParameter()</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    {</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        Binding binding = <span style="color: #0000ff">new</span> Binding(<span style="color: #006080">"User.Name"</span>);</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        binding.Source = WebContext.Current;</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        BindingOperations.SetBinding(<span style="color: #0000ff">this</span>, Parameter.ValueProperty, binding);</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    }</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">}</pre>
<!--CRLF--></div>
</div>

<p>
  <br />The solution can be applied equally well to filters, groups, parameters, and sorts. If you find yourself writing the same filter over and over or discover you need a little more than standard binding, it’s probably worth your while to create a derived filter.</p>

<p />

<p />

<p>If you’d like to see this capability in action, download this <a href="http://jeffhandley.com/Files/DDS_FilterDescriptorSample.zip" target="_blank">sample solution that demonstrates it</a>.  This solution requires the Visual Studio 2010 RC and <a href="http://silverlight.net/riaservices" target="_blank">RIA Services Release Candidate</a>.</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:8de4908b-6af3-4c36-acf5-543e51a380d7" class="wlWriterEditableSmartContent">Technorati Tags: <a href="http://technorati.com/tags/DomainDataSource" rel="tag">DomainDataSource</a>,<a href="http://technorati.com/tags/RIAServices" rel="tag">RIAServices</a>,<a href="http://technorati.com/tags/ControlParameter" rel="tag">ControlParameter</a>,<a href="http://technorati.com/tags/FilterDescriptor" rel="tag">FilterDescriptor</a>,<a href="http://technorati.com/tags/Kyle+McClellan" rel="tag">Kyle McClellan</a></div>

