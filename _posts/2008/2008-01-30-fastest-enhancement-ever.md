---
layout: post
title: "Fastest Enhancement Ever!"
date: 2008-01-30 08:08:38 -0800
comments: true
tags: ["DotNetNuke", "Subversion"]
redirect_from: ["/archive/2008/01/30/fastest-enhancement-ever.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p>I think I just executed the fastest enhancement ever!  Here's my VPN status window as evidence:</p>  <p><img height="450" alt="Fastest Enhancement Ever!" src="/img/postimages/FastestEnhancementEver_1CE/image.png" width="373" /> </p>  <p>During this 15:30 connectivity, I added support for specifying a Country on job postings on the DotNetNuke project I worked on this past weekend.  Here were the steps involved:</p>  <ol>   <li>SVN Update</li>  <li>Edit the DB schema to provide a CountryCode column, defaulting to US</li>  <li>Create an Enum for CountryCode, with descriptions for the 3 countries that needed to be in the list</li>  <li>Update the Fetch stored procedure to return that column</li>  <li>Update the Save stored procedure to accept the column and persist it</li>  <li>Update the List stored procedure to return the column</li>  <li>Edit the business object to give it the property for CountryCode</li>  <li>Edit the ManageJobs.ascx to provide an EnumList control for the CountryCode and display/save the value</li>  <li>Test</li>  <li>SVN Commit</li> </ol>  <p><a href="http://jeffhandley.com/archive/2008/01/27/enum-list-dropdown-control.aspx" target="_blank">EnumList</a> and <a href="http://jeffhandley.com/archive/2008/01/27/dotnetnuke-project-completed.aspx" target="_blank">DotNetNuke</a> made this happen.</p>
