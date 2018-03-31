---
layout: post
title: "The workaround that doesn't work"
date: 2008-01-24 02:51:07 -0800
comments: true
category: Archive
tags: []
redirect_from: ["/archive/2008/01/23/the-workaround-that-doesnt-work.aspx/"]
author: 0
---
<!-- more -->
<p><em>Please excuse the fact that I have to use general terms and vague references here.  I hope that this story is entertaining despite the removed specifics.</em></p>  <hr />  <p>Before a recent release, our software allowed the user to do X.  There was a bug reported that the user shouldn't be able to do X.  We fixed the bug as part of the aforementioned release.  Then all of a sudden our users were freaking out because they could no longer do X.  We now have conflicting requirements.</p>  <ol>   <li>Don't allow user to do X </li>    <li>User must be able to do X </li> </ol>  <p>We decided not to make a quick change to allow the user to do X again; we knew this would just result in a never-ending cycle of bug reports.  Instead, we concocted a workaround that uses a different configuration to allow the user to do X again.</p>  <p>Release notes were updated and users were informed that a known issue exists, but there is a workaround.  The documentation explicitly states that Configuration A will not allow the user to do X, per requirements.  Configuration B on the other hand will.  Configurations A and B are subtly different, and would logically seem to be the same--but they are not the same.</p>  <p>Despite the published workaround, this issue was still being communicated as extremely critical, causing a work stoppage.  We were then told that the workaround doesn't actually work.  Perplexed, I asked for details on what specifically failed with the workaround.  The response was something like this:</p>  <p><code><font style="background-color: #ffffff">Our configuration is just like what the workaround shows.  Except instead of using Configuration B, we used Configuration A because it should have the same result.</font></code></p>  <p>I then had to send a note stating that the known issue document specifically states that Configuration A will not allow the user to perform X.  Hence the known issue and the workaround.</p>

