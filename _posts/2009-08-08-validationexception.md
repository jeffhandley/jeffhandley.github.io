---
layout: post
title: "Not Breaking on ValidationException (take 2)"
date: 2009-08-08 02:44:39 -0700
comments: true
tags: ["Silverlight", "Validation"]
redirect_from: ["/archive/2009/08/07/validationexception.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p>Awhile back, I <a href="http://jeffhandley.com/archive/2009/04/01/184.aspx">blogged</a> about how Silverlight uses Validation Exceptions, which can cause the debugger to break.  I showed how to prevent that from happening, but the solution was less than ideal.</p>  <p>Someone named <em>rlodina</em> <a href="http://jeffhandley.com/archive/2009/04/01/184.aspx#372">commented</a> on the post:</p>  <p>What about manual adding:  <br /><i>System.ComponentModel.DataAnnotation.ValidationException</i>   <br />in this list.</p>  <p><font>This comment has been sitting in my inbox for about a week, and I had wanted to follow up on this.  Well good gosh, this is <strong>easy</strong> and it works like a charm.  You can in fact tell VS to only ignore ValidationException instances, while still breaking on everything else.  Here’s how.</font></p>  <ol>   <li><font>Click on Debug-&gt;Exceptions (Ctrl+D, E for your keyboard folks)</font> </li>  <li><font>Click on Add…</font> </li>  <li><font>Select the Type as “Common Language Runtime Exceptions”</font> </li>  <li><font>Type the name as System.ComponentModel.DataAnnotations.ValidationException and </font><font>click OK.</font> </li>  <li><font>You’ll now see this exception in the list.  Uncheck “User-unhandled just for this exception, and click OK.</font> </li> </ol>  <p><img style="display: inline; margin-left: 0px; margin-right: 0px" title="image" alt="image" src="/img/postimages/NotBreakingonValidationExceptiontake2_11496/image_fa2212a8-a7c4-41a7-99ca-325231565eef.png" width="640" height="321" /> </p>  <p />  <p>This lets you keep all of the other exceptions turned on, but Visual Studio will no longer break when Silverlight hits a ValidationException.  Like I said, it works like a charm.  Thanks rlodina! :-)</p>

