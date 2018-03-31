---
layout: post
title: "DomainDataSource DataPager PageSize Pitfall"
date: 2009-11-16 11:12:34 -0800
comments: true
category: Archive
tags: []
redirect_from: ["/archive/2009/11/16/domaindatasource-datapager-pagesize-pitfall.aspx"]
author: 0
---
<!-- more -->
<p>During the PDC release milestone of RIA Services, we discovered an error from DomainDataSource when using AutoLoad="True" and when using a DataPager bound to the DomainDataSource’s Data property.  We found that when the PageSize property is specified on the DataPager and not on the the DomainDataSource itself, an exception would often (but not always) be thrown from DomainDataSource, indicating that a load could not be invoked while another load was in progress.  The reason for this will actually interest you most if you use AutoLoad set to False.</p>  <p>The issue is easiest to explain with a series of events that occurs when auto-loading.  Consider the following XAML:</p>  <div style="border-bottom: silver 1px solid; text-align: left; border-left: silver 1px solid; padding-bottom: 4px; line-height: 12pt; background-color: #f4f4f4; margin: 20px 0px 10px; padding-left: 4px; width: 97.5%; padding-right: 4px; font-family: 'Courier New', courier, monospace; direction: ltr; max-height: 200px; font-size: 8pt; overflow: auto; border-top: silver 1px solid; cursor: text; border-right: silver 1px solid; padding-top: 4px" id="codeSnippetWrapper">   <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px" id="codeSnippet">     <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">&lt;</span><span style="color: #800000">dds:DomainDataSource</span> <span style="color: #ff0000">x:Name</span>=”<span style="color: #ff0000">myDDS</span>” <span style="color: #ff0000">QueryName</span>=”<span style="color: #ff0000">GetCustomers</span>”<span style="color: #0000ff">&gt;</span> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    <span style="color: #0000ff">&lt;</span><span style="color: #800000">dds.DomainDataSource.DomainContext</span><span style="color: #0000ff">&gt;</span></pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        <span style="color: #0000ff">&lt;</span><span style="color: #800000">my:CustomerContext</span> <span style="color: #0000ff">/&gt;</span></pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    <span style="color: #0000ff">&lt;/</span><span style="color: #800000">dds:DomainDataSource.DomainContext</span><span style="color: #0000ff">&gt;</span> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">&lt;/</span><span style="color: #800000">dds:DomainDataSource</span><span style="color: #0000ff">&gt;</span></pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">&lt;</span><span style="color: #800000">data:DataPager</span> <span style="color: #ff0000">x:Name</span>=”<span style="color: #ff0000">myPager</span>” <span style="color: #ff0000">Source</span>=”{<span style="color: #ff0000">Binding</span> <span style="color: #ff0000">Data</span>, <span style="color: #ff0000">ElementName</span>=<span style="color: #ff0000">myDDS</span>}” <span style="color: #ff0000">PageSize</span>=”<span style="color: #ff0000">10</span>” <span style="color: #0000ff">/&gt;</span></pre>
<!--CRLF--></div>
</div>

<p>
  <br />With this XAML, here’s what was happening before we fixed this bug:</p>

<ol>
  <li>myDDS gets instantiated and its properties get set </li>

  <li>myPager gets instantiated and its properties get set (except for its Dependency Properties) </li>

  <li>myDDS gets Loaded, during which it sees that it’s in AutoLoad mode, and it begins loading data </li>

  <li>myPager gets loaded, at which time its Source gets bound, which causes the PageSize property to get applied to myDDS.Data.PageSize </li>

  <li>The DomainDataSource.PageSize property gets set, and with AutoLoad set to True, this invokes a new load </li>

  <li>Exception is thrown because a load cannot be invoked while through the DomainDataSource while another load is being performed (unless the original load has already completed, in which case a second load is successfully invoked) </li>
</ol>

<p>In addition to the intermittent exception that this causes, an ostensibly worse problem also hides here.  The first load gets invoked <em>without a PageSize</em>.  That means that no paging is applied and <em>all </em>records are requested from the server.  Needless to say, that could be extremely expensive for both the client and the server.</p>

<h4>Mitigation</h4>

<p>We needed to prevent the first load from beginning until after the DataPager has been loaded and the element-to-element bindings have been applied.  But there’s no clean and safe way to know (from the DomainDataSource’s perspective) that the DataPager even exists, let alone when it has loaded.</p>

<p>From within an event handler for the DomainDataSource’s Control.Loaded event, we use Dispatcher.BeginInvoke to initiate the first auto load.  The dispatched call allows the control loading to finish and the PageSize property to be reflected on the DomainDataSource before our load is invoked.  To be honest, I’m not thrilled with this solution, but it does the trick.  We have been unable to recreate the double-load scenario since applying this fix.  And the alternative was to always advise everyone to specify the PageSize property on the DomainDataSource rather than on the DataPager, and that would have been very unfortunate.</p>

<h4>When AutoLoad is False</h4>

<p>I mentioned above that the explanation of this issue would interest you most when you have AutoLoad set to false.  With AutoLoad set to true, we address the issue for you.  But when you are calling DomainDataSource.Load() yourself, you must be aware of this PageSize pitfall.  Here are three ways it can bite you if you have PageSize set on a DataPager:</p>

<ol>
  <li>In your page’s constructor, you call InitializeComponent, and then call DomainDataSource.Load(); </li>

  <li>In the DomainDataSource.Loaded event (not LoadedData), you call DomainDataSource.Load(); </li>

  <li>In your page’s Loaded handler, you call DomainDataSource.Load(). </li>
</ol>

<p>With any of these three approaches, you will see probably see the double-load.  You will quite possibly get an exception when the DataPager is loaded and the PageSize property gets applied.  Even if you don’t see the exception though, you’ll be hitting your server twice, with the first hit requesting all records.  Not good.</p>

<p>When using AutoLoad set to false, you should utilize the same mechanism I have used for AutoLoad="True" and call Dispatcher.BeginInvoke(() =&gt; myDDS.Load()).  This will defer the load until the UI thread has completed the control loading and your PageSize has been set.  If you are stubborn and pushy and want to invoke the load without dispatching it, then you can always set the PageSize on the DomainDataSource instead.</p>

<p>I hope this information helps you avoid the DomainDataSource DataPager PageSize Pitfall.  And as always, please feel free to ping me with questions, comments, or concerns.  I love gathering your feedback!</p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:2ce30b98-f0c4-4392-82c5-5c0ab2b99fe2" class="wlWriterEditableSmartContent">Technorati Tags: <a href="http://technorati.com/tags/RIAServices" rel="tag">RIAServices</a>,<a href="http://technorati.com/tags/DomainDataSource" rel="tag">DomainDataSource</a>,<a href="http://technorati.com/tags/DataPager" rel="tag">DataPager</a>,<a href="http://technorati.com/tags/PageSize" rel="tag">PageSize</a>,<a href="http://technorati.com/tags/Silverlight" rel="tag">Silverlight</a></div>

