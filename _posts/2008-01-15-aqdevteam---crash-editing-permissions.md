---
layout: post
title: "AQdevTeam - Crash Editing Permissions"
date: 2008-01-15 01:45:44 -0800
comments: true
category: Archive
tags: ["AQdevTeam"]
redirect_from: ["/archive/2008/01/14/aqdevteam---crash-editing-permissions.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p>We use AQdevTeam for internal task tracking as well as for Quality Assurance Problem Report (QAPR) items.  Not long ago, we started getting an error whenever we try to edit item permissions.</p>  <p>Here are the reproduction steps:</p>  <ol>   <li>Click on Administration-&gt;Permissions</li>    <li>Select a project</li>    <li>Click on Permissions</li> </ol>  <p><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="362" alt="AQdevTeam has encountered a problem and needs to close." src="http://blog.jeffhandley.com/Images/PostImages/AQdevTeamCrashEditingPermissions_F9C4/image.png" width="380" border="0" /> </p>  <p>After clicking leaving this dialog with "Don't terminate the application" selected, we get another error:</p>  <p><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="173" alt="Access violation at address 05A14305 in module 'AdminPack.PLA'.  Read of address 00000000." src="http://blog.jeffhandley.com/Images/PostImages/AQdevTeamCrashEditingPermissions_F9C4/image_3.png" width="500" border="0" /></p>  <p>I think we're pretty much hosed. </p>  <p>   </p>
