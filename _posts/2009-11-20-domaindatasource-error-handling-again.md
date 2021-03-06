---
layout: post
title: "DomainDataSource Error Handling"
date: 2009-11-20 04:29:53 -0800
comments: true
tags: ["RIAServices", "DomainDataSource", "Silverlight", "Error Handling"]
redirect_from: ["/archive/2009/11/19/domaindatasource-error-handling-again.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p>With the RIA Services July 2009 Preview release, we heard significant feedback about the DomainDataSource error handling story.  The biggest problem was when errors occurred during Load() or SubmitChanges(), server-side errors would be silently swallowed unless you opted into the LoadError, LoadedData, and SubmittedChanges events, and explicitly checked for errors.  With the PDC release, we've change this behavior, among others related to error handling.</p>  <h4>Different Error Conditions</h4>  <p>The DomainDataSource can encounter errors in several different ways:</p>  <ol>   <li>Load() is called when its prerequisites are not yet met.  For instance, there is no DomainContext specified, the QueryName provided is invalid, or the QueryParameters aren't all supplied.  We'll refer to this condition as "Load Prerequisites." </li>  <li>Load() is called when another load is presently working, or when CanLoad is otherwise false.  We'll refer to this condition as "Cannot Load." </li>  <li>Load() is called and the query expression fails to build, perhaps because of an invalid cast when getting parameter values from controls.  We'll refer to this condition as "Query Exception." </li>  <li>Load() is called, the query is composed and invoked, but something fails on the server.  This could be authentication or authorization failures, or server-side exceptions. Let's call this a "Load Failure." </li>  <li>SubmitChanges() is called, but some of the entities being submitted have validation errors.  This is a "Validation Failure." </li>  <li>SubmitChanges() is called and the request is sent to the server, but something fails on the server.  Causes would be server-side validation failures, concurrency conflicts, authentication or authorization failures, or exceptions that occur on the server.  This is called a "Submit Error." </li> </ol>  <h4>Load Prerequisites and Cannot Load</h4>  <p>In these conditions, an exception will occur when you call Load().  The exception message will explain what prerequisite wasn't met or why Load could not be otherwise called.  When you're using AutoLoad="True" these conditions will not occur.</p>  <h4>Query Exception and Load Failure</h4>  <p>The Query Exception condition occurs purely client-side, without even hitting the server.  The Load Failure occurs when invoking the load method on the server.  Regardless of this difference, both conditions will result in a LoadedData event, with the LoadedDataEventArgs.HasError property set to true, and the Error property set to the exception that occurred .  <em>Breaking Change Alert: In the July release, Query Exceptions resulted in a LoadError event; that event has been removed.</em>  This greatly simplifies things because there are only two possibilities:</p>  <ol>   <li>Failure: LoadingData event followed by a LoadedData event with HasError = true and Error set to the exception that occurred.</li>  <li>Success: LoadingData event followed by a LoadedData event with HasError =.false. </li> </ol>  <p>Again, the LoadError event has been removed with the PDC release.</p>  <h4>Validation Failure and Submit Error</h4>  <p>The SubmitChanges() error handling mimics what we see above with Query Exception and Load Failure.  Even though one scenario is client-side and the other is server-side, we surface them in the same manner.  Both will result in a SubmittedChanges event, with the SubmittedChangesEventArgs.HasError property set to true, and the Error property set to the exception that occurred.  Similar to load errors, there are only two possibilities with submitting changes:</p>  <ol>   <li>Failure: SubmittingChanges event followed by a SubmittedChanges event with HasError = true and Error set to the exception that occurred.</li>  <li>Success: SubmittingChanges event followed by a SubmittedChanges event with HasError = false.</li> </ol>  <h4>No More Silent Failures</h4>  <p><em>Breaking Change Alert: DomainDataSource and RIA Services in general both aggressively report exceptions now.  If an error occurs in load or submit and you don't mark it as handled, an exception will be thrown, likely bringing down your application.</em>  This will accomplish three things:</p>  <ol>   <li>Put the errors in your face during development so that you don't beat your head against your desk because you have no idea why things aren't working.</li>  <li>Encourage you to handle errors in your applications, doing something explicit with them and marking them as handled.</li>  <li>If you don't handle errors, your frustrated end users will see the exception messages with useful information to pass on to your support team.</li> </ol>  <p>In both LoadedData and SubmittedChanges, you should have code to mark your errors as handled.  For example:</p>  <div id="codeSnippetWrapper">   <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px" id="codeSnippet">   <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> MyDomainDataSource_LoadedData(<span style="color: #0000ff">object</span> sender, LoadedDataEventArgs e)</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">{</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">if</span> (e.HasError)</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    {</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        MessageBox.Show(e.Error.ToString(), <span style="color: #006080">"Load Error"</span>, MessageBoxButton.OK);</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        e.MarkErrorAsHandled();</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    }</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">}</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"> </pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> MyDomainDataSource_SubmittedChanges(<span style="color: #0000ff">object</span> sender, SubmittedChangesEventArgs e)</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">{</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">  <span style="color: #0000ff">if</span> (e.HasError)</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    {</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        MessageBox.Show(e.Error.ToString(), <span style="color: #006080">"Submit Error"</span>, MessageBoxButton.OK);</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">        e.MarkErrorAsHandled();</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">    }</pre>
<!--CRLF-->

  <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px">}</pre>
<!--CRLF--></div>
</div>

<p />

<p>When you use the Data Sources window, the LoadedData event handler is generated automatically.  But you should do more than just show the stock message box, perhaps log the error to a server and show your users a customized message.  In both LoadedData and SubmittedChanges events, calling e.MarkErrorAsHandled() will prevent the exception from being thrown from the DomainDataSource after the event is raised.</p>

<h4>You, Less Frustrated</h4>

<p>As I mentioned, we heard a lot of feedback about error handling with the DomainDataSource, resulting in the changes made as described herein.  I'd love to hear your feedback on these changes.  I do hope that this makes DomainDataSource usage a lot less frustrating when things go wrong.</p>



