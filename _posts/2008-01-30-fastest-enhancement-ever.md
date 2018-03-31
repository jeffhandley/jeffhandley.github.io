---
layout: post
title: "Fastest Enhancement Ever!"
date: 2008-01-30 08:08:38 -0800
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.github.io/archive/2008/01/30/fastest-enhancement-ever.aspx"]
author: 0
---
<!-- more -->
<p>I think I just executed the fastest enhancement ever!  Here's my VPN status window as evidence:</p>  <p><img height="450" alt="Fastest Enhancement Ever!" src="http://blog.jeffhandley.com/Images/PostImages/FastestEnhancementEver_1CE/image.png" width="373" /> </p>  <p>During this 15:30 connectivity, I added support for specifying a Country on job postings on the DotNetNuke project I worked on this past weekend.  Here were the steps involved:</p>  <ol>   <li>SVN Update</li>    <li>Edit the DB schema to provide a CountryCode column, defaulting to US</li>    <li>Create an Enum for CountryCode, with descriptions for the 3 countries that needed to be in the list</li>    <li>Update the Fetch stored procedure to return that column</li>    <li>Update the Save stored procedure to accept the column and persist it</li>    <li>Update the List stored procedure to return the column</li>    <li>Edit the business object to give it the property for CountryCode</li>    <li>Edit the ManageJobs.ascx to provide an EnumList control for the CountryCode and display/save the value</li>    <li>Test</li>    <li>SVN Commit</li> </ol>  <p><a href="http://blog.jeffhandley.com/archive/2008/01/27/enum-list-dropdown-control.aspx" target="_blank">EnumList</a> and <a href="http://blog.jeffhandley.com/archive/2008/01/27/dotnetnuke-project-completed.aspx" target="_blank">DotNetNuke</a> made this happen.</p>  <div class="wlWriterSmartContent" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:f5d57611-aafa-40b5-adee-293585d34d64" style="padding-right: 0px; display: inline; padding-left: 0px; padding-bottom: 0px; margin: 0px; padding-top: 0px">Technorati Tags: <a href="http://technorati.com/tags/DotNetNuke" rel="tag">DotNetNuke</a>,<a href="http://technorati.com/tags/Subversion" rel="tag">Subversion</a></div>

