---
layout: post
title: "SQL CLR Types"
date: 2008-04-24 04:31:07 -0700
comments: true
tags: []
redirect_from: ["/archive/2008/04/23/sql-clr-types.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<div><a href="http://dyardy.spaces.live.com/default.aspx">Dave Yardy</a> wrote a post <a href="http://dyardy.spaces.live.com/blog/cns!812B0DF85863A595!334.entry">questioning SQL CLR Types</a>.  I posted the following response:</div>
<div><hr />
</div>
<div>I don't know why you would want to store a serialized UDT in the database.  Having to drop the type if it changes is really, really scary.</div>
<div> </div>
<div>However, I had some outstanding results using the following pattern:</div>
<div> </div>
<div><strong>Need</strong></div>
<div>Perform a calculation that spans thousands or tens of thousands of records, with a single scalar result.</div>
<div> </div>
<div><strong>Approach</strong> (it's been almost 2 years since I wrote this code, so I don't remember details)</div>
<ol>
    <li>Create a custom type that has fields for each aspect of the records that need to be analyzed during the calculation</li>
    <li>Create a custom aggregate of that custom type that returns the scalar result</li>
    <li>Create a shared method on the custom type that accepts parameters to match the fields and returns a new instance of the type (a factory basically)</li>
    <li>Create a stored procedure (or direct SQL) that selects the fields from the tables that store the fields from the custom type, which may or may not root from the same table</li>
    <li>Use the fields from that select to pass the values into the shared method that returns and instance of the custom type</li>
    <li>Use the custom aggregate, aggregating the custom types</li>
    <li>Return the result</li>
</ol>
<div> </div>
<div>This approach worked wonderfully, for about a half-dozen processes on a project a couple of years ago.  Once I had the pattern down, I found that the pattern was very, very powerful, and insanely fast.  IIRC, you can even tell the aggregate to abort if you hit a scenario where no further records would impact the results.  I remember specifically sorting the resultset so that the aggregate would get the data in the most eager manner, where it could most often abort very soon.</div>
<div> </div>
<div>Unfortunately, I don't have any metrics, but I have remembered the concept behind this pattern, knowing that someday I'll need to pull this off my tool belt and apply it again.</div>

