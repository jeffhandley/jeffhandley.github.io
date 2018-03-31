---
layout: post
title: "TortoiseSVN Global Ignores"
date: 2008-01-15 23:37:26 -0800
comments: true
category: Archive
tags: ["TortoiseSVN", "Subversion"]
redirect_from: ["/archive/2008/01/15/tortoisesvn-global-ignores.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p>I have configured global ignores for <a href="http://tortoisesvn.net/" target="_blank">TortoiseSVN</a>.  This helps me omit the bin and obj folders as well as other user-level files.  There's no sense in putting those into the code trunk.</p>  <p><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="394" alt="Windows Explorer - TortoiseSVN - Settings" src="http://blog.jeffhandley.com/Images/PostImages/TortoiseSVNGlobalIgnores_DBAF/image.png" width="427" border="0" /> </p>  <p>Then enter: bin obj *.suo *.user Release Debug</p>  <p><img style="border-right: 0px; border-top: 0px; border-left: 0px; border-bottom: 0px" height="357" alt="bin obj *.suo *.user Release Debug" src="http://blog.jeffhandley.com/Images/PostImages/TortoiseSVNGlobalIgnores_DBAF/image_3.png" width="504" border="0" /> </p>
