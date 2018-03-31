---
layout: post
title: "How To: Cause a Vista BSOD with VS 2008"
date: 2008-02-11 00:25:58 -0800
comments: true
tags: ["Vista", "BSOD", "VS 2008"]
redirect_from: ["/archive/2008/02/10/how-to-cause-a-vista-bsod-with-vs-2008.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p>Just in case you want to do this, here's a step by step guide.</p>  <ol>   <li>Start VS 2008 (no need to open a project or file) </li>    <li>Click on Tool-&gt;Attach to Process... </li>    <li>Select wininit.exe and click Attach </li>    <li>Wait for the debugger to initialize </li>    <li>Click the Stop Debugging button </li> </ol>  <p>When you attempt to attach to w3wp.exe, but it's not running, the keystrokes that you zip through in less than a second can cause you to be attached to wininit.exe.  Once attached, you cannot detach, you can only stop debugging, which will cause a blue screen of death, every time.</p>  <p>I submitted this to Microsoft Connect here: <a title="https://connect.microsoft.com/VisualStudio/feedback/ViewFeedback.aspx?FeedbackID=328016" href="https://connect.microsoft.com/VisualStudio/feedback/ViewFeedback.aspx?FeedbackID=328016">https://connect.microsoft.com/VisualStudio/feedback/ViewFeedback.aspx?FeedbackID=328016</a></p>  <p></p><hr />  <p></p>  <p><em>This is happening for me on my home workstation which is running Vista 32-bit on an AMD X64 processor.  Nothing else running.</em></p>

