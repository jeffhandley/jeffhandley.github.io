---
layout: post
title: "Multi-Monitor Support - A New Clue"
date: 2008-01-13 02:59:45 -0800
comments: true
tags: []
redirect_from: ["/archive/2008/01/12/multi-monitor-support---a-new-clue.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p>My good friend <a href="http://dyardy.spaces.live.com/default.aspx" target="_blank">David Yardy</a> posted something about <a href="http://dyardy.spaces.live.com/blog/cns!812B0DF85863A595!284.entry" target="_blank">MaxiVista and Windows Vista</a>.  He had a link to <a href="http://www.microsoft.com/whdc/device/display/multimonVista.mspx" target="_blank">a support article</a> from Microsoft discussing multiple monitor support in Windows Vista.</p>  <p>This support article has the following information:</p>  <p> </p>  <p><code>Two, three, or more monitors:</p>  <p>•Graphics adapter A with two outputs in an x16 PCIe slot, plus another graphics adapter B with one or more outputs in another x16 PCIe slot.     <br /><i>Both A and B use the same WDDM driver.</i></p>  <p>•Graphics adapter A with two outputs in an x16 PCIe slot, plus another graphics adapter B with one or more outputs in an x1 PCIe slot.     <br /><i>Both A and B use the same WDDM driver.</i></p>  <p>•Graphics adapter A with two outputs in an x16 PCIe slot, plus another graphics adapter B with one or more outputs in a conventional PCI slot.     <br /><i>Both A and B use the same WDDM driver.</i></p>  <p>•Graphics adapter A with two outputs in an AGP slot, plus another graphics adapter B with one or more outputs in a conventional PCI slot.     <br /><i>Both A and B use the same WDDM driver.</i></p>  <p>•A mobile PC with an internal graphics adapter A, connected to a docking station that includes an external graphics adapter B.     <br /><i>Both the internal graphics adapter A and external graphics adapter B use the same WDDM driver.</i></code></p>  <p>Notice that there's nothing listed for two traditional PCI cards.  Maybe this is the piece of the <a href="http://blog.jeffhandley.com/archive/2008/01/04/video-card-update-still-unresolved.aspx" target="_blank">puzzle</a> that I was missing.</p>  <p>I am going to try a PCIe/PCI combination of nVidia cards.  I think this will do the trick after seeing this information from Microsoft.</p>  <p>Thanks Dave!</p>

