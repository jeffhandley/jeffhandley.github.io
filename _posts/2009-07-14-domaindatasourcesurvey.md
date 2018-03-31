---
layout: post
title: "DomainDataSource &ndash; Defining Its Limits"
date: 2009-07-14 10:45:19 -0700
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.github.io/archive/2009/07/14/domaindatasourcesurvey.aspx"]
author: 0
---
<!-- more -->
<p>With the <a target="_blank" href="http://www.microsoft.com/downloads/details.aspx?FamilyID=76bb3a07-3846-4564-b0c3-27972bcaabce&amp;displaylang=en">.NET RIA Services July 2009 Preview</a>, the DomainDataSource now enables some scenarios that were previously blocked.  Most namely, we now allow you to change your current page while there are pending changes in the data.  Editing and paging seemed like a common enough scenario that we wanted to enable it, so we’ve done so in the recent drop.</p>
<p>There are actually many scenarios opened up right now that we’re reviewing.  I’ll be frank: many of the following scenarios are probably doing really wonky things in the current bits.  So here’s your chance to help us determine how these scenarios should behave by telling us how you’d use them in your applications!</p>
<h5>1. Editing and Paging</h5>
<p>Let’s start with the simple target scenario that we were going after.  The DDS is paging, and you have pulled down a couple of pages of data.  You edit a record.  Should you be able to page through the data and make other changes, or should you be stuck on the page containing the first edit?</p>
<h5>2. Adding and Paging</h5>
<p>You add a new record, what page does it get added to?  Can you move around through the pages, but always find the added record on the page it was added to?</p>
<h5>3. Editing and Sorting</h5>
<p>When a record is edited, should it be re-sorted to fit in based on its edited values, or does it maintain its sort position based on how it was loaded from the server?</p>
<h5>4. Editing, Sorting, and Paging</h5>
<p>If you’re viewing page 3, and you edit a record, and then you re-sort, what happens?  Are you taken to page 1?  Does the record get loaded onto the page that the server thinks it belongs to or does it stay assigned to the page it was edited on?  Or do we just disable sorting when there are pending changes because this seems too goofy?</p>
<h5>5. Adding, Sorting, and Paging</h5>
<p>If there is a pending add on page 3, and you change the sort, what happens?  Are you taken back to page 1?  Does the added record stay on page 3 or does it now display on page 1?  Or do we just disable sorting when there are pending changes because this seems too goofy?</p>
<h5>6. Editing and Filtering</h5>
<p>What does it mean when the filter changes to exclude the record as it exists on the server?  What does it mean when the filter changes to exclude the record based on it’s edited state on the client?  Or do we just disable filtering when there are pending changes because this seems too goofy?</p>
<h5>7. Adding and Filtering</h5>
<p>You’ve done a filter (cities in Washington), and you add a new record that doesn’t match your filter (Cincinnati, Ohio).  Does it hide immediately, or show up despite not meeting the filter?  What happens if you change the filter to where the record again doesn’t meet the filter (cities in California)?  Or do we just disable filtering when there are pending changes because this seems too goofy?</p>
<h4>Many, Many More Scenarios</h4>
<p>There are scores of questions like these.  Filtering and Sorting are causing me the most anxiety, so I’m leaning toward blocking filtering, sorting, and grouping (which does a sort) whenever there are pending changes.  The results are just too unpredictable.  Some of my team members have been voicing this concern as well, but I’ve been bull-headed, wanting to open these scenarios up.  But perhaps it’s not worth it.</p>
<p>So please, share with me any real-world scenarios you have where you need a very heavy mixture of editing, adding, deleting, sorting, grouping, filtering, and paging or incremental loads <em>(using LoadSize and LoadInterval, but not PageSize)</em>, or any combination of these.  Should we throw an InvalidOperationException if you attempt to sort, filter, or group when there are pending changes?  Should we stop performing incremental loads when there are changes?  We’d still allow paging (we have this pretty well covered), but none of the other server operations would be allowed.</p>
<p><strong>Also, please help me distinguish between actions the DomainDataSource should block and actions your applications would block, but you'd still like to have enabled in DomainDataSource, just in case.</strong></p>
<p>Thanks in advance for the feedback!</p>
<div style="PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; DISPLAY: inline; FLOAT: none; PADDING-TOP: 0px" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:d05d9961-e073-42f2-81c0-688269a12c3e" class="wlWriterEditableSmartContent">Technorati Tags: <a rel="tag" href="http://technorati.com/tags/RIAServices">RIAServices</a>,<a rel="tag" href="http://technorati.com/tags/DomainDataSource">DomainDataSource</a>,<a rel="tag" href="http://technorati.com/tags/Silverlight">Silverlight</a></div>
<p><em /></p>
<p><em>And for those of you that follow me on <a target="_blank" href="http://twitter.com/jeffhandley/status/2628627019">Twitter</a>… Yes, I did actually create a Silverlight-based survey with these questions, and it’s fully functional after about 2 hours work.  But as I was beginning to deploy it, I thought it would be better just to stick with comments on the blog post, as that will harbor more exchanges of thoughts, rather than just a blind survey submission where you can’t see any else’s responses.</em></p>

