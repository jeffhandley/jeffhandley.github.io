---
layout: post
title: "Replacing Luxafor's App with OSX Automator and Keyboard Shortcuts"
date: 2018-03-08 01:10:12 -0800
comments: true
category: Archive
tags: []
redirect_from: ["/archive/2018/03/07/node-luxafor-cli-with-keyboard-shortcuts.aspx/"]
author: 0
---
<!-- more -->
<p>
A couple years ago, we invested in <a href="http://www.luxafor.us" target="luxafor">Luxafor</a> flag lights for everyone on the team. These lights are attached to our monitors and we communicate with each other using them. If someone's light is green, they are "free" and you're welcome to drop by and interrupt what they're doing.  If someone's light is red, they are in do-not-disturb mode for one reason or another.  They might be on a zoom call or they might just not want to be interrupted.
</p>
<p>
The Luxafor lights come with an app that can control your flag light all sorts of ways. There are animated patterns. There's a pomodoro mode. It can integrate with other services to automatically set your color. And it can (sort of) let you program OS-wide keyboard shortcuts to set the flag color. When we first got our lights, this worked flawlessly. But Luxafor's app has degraded in stability over time and the keyboard shortcuts have taken a big hit. For many months, I've been unable to set up a shortcut for setting the flag to green. And my flag defaults to red whenever I disconnect and reconnect it. Since all we use the flags for is toggling between red and green, this regression has been painful.
</p>
<p>
I've <a href="https://twitter.com/search?q=from%3Ajeffhandley%20to%3Aluxafor" target="luxafor">pleaded with Luxafor</a> to fix the critical bug of keyboard shortcuts being broken. I've heard nothing back. It's time to cut out the middle man. Here's what I wanted:
</p>
<ol>
<li>An OS-wide shortcut that sets the light to green (^⌥⌘G)</li>
<li>An OS-wide shortcut that sets the light to red (^⌥⌘R)</li>
<li>For these shortcuts to reliably work every time I use them</li>
<li>No need to launch an app or click anything in the UI</li>
</ol>
<p>
I didn't feel like this was asking too much, but it took a little time to get it figured out. Thankfully, <a href="https://github.com/mattgoucher" target="matt">Matt Goucher</a> had already published a <a href="https://www.npmjs.com/package/node-luxafor" target="matt">node-luxafor</a> package to NPM that did all of the heavy lifting. With that in place, all I needed to do was:
</p>
<ol>
<li>Write a CLI over top of node-luxafor</li>
<li>Find a way to run the CLI from an OSX keyboard shortcut</li>
</ol>
<h2>The Node Luxafor CLI</h2>
<p>
I created <a href="https://github.com/jeffhandley/node-luxafor-cli" target="node-luxafor-cli">node-luxafor-cli</a> as a thin CLI wrapper around node-luxafor. Right now, it's just js files that can be invoked with node.
</p>
<ul>
<li><b>node green</b> - sets the flag color to green</li><li>
</li><li><b>node red</b> - sets the flag color to red</li>
<li><b>node index --color=blue</b> - sets the flag color to blue</li>
<li><b>node index -r 255 -g 255 -b 255</b> - sets the flag color to white</li>
</ul>
<p>
This package has plenty of room for maturation, but it gives me all I needed to start.
</p>
<h2>Keyboard Shortcuts</h2>
<p>
The keyboard shortcuts were where I had the most to learn. Here's what was involved:
</p>
<ol>
<li>Create Automator Services that run Shell Scripts to invoke node and run the node-luxafor-cli scripts</li>
<li>Configure Keyboard Shortcuts to run the Automator Services</li>
</ol>
<h3>Automator Services</h3>
<p>
An Automator Service can register an application in application menus. With the right configuration, the service can be registered to be available in the menu of <i>any application</i>.
</p>
<p>
Here are the steps to create the Automator Services for Luxafor-Red and Luxafor-Green.
</p>
<ol>
<li>git clone git@github.com:jeffhandley/node-luxafor-cli.git</li>
<li>Open Automator.app</li>
<li>Choose "Service" as the type of document</li>
<li>Select that the "Service receives: <no input=""> in <any application="">"</any></no></li>
<li>Select "Run Shell Script" from the actions library and drag it into the surface</li>
<li>Ensure an appropriate Shell is selected</li>
<li>In the script box, put in the equivalent of "node node-luxafor-cli/green", but you will need to provide your full path for node as well as the full path for where you cloned node-luxafor-cli - for me, it was /Users/jeffhandley/.nvm/version/node/v8.9.3/bin/node /Users/jeffhandley/code/node-luxafor-cli/green</li>
<li>Press the Run button to test the service - your light should turn green</li>
<li>Save the service as Luxafor-Color-Green</li>
</ol>
<p>
With this Automator Service created, follow the same steps to create one for setting the light to red.
</p>
<h3>Keyboard Shortcuts</h3>
<p>
This was finicky to figure out, but it turns out the biggest catch was how the Automator script was created. It <b>must be a Service</b> and it must be configured to use <b>all applications</b>. With that in place, the following should work for you.
</p>
<ol>
<li>Open your System Preferences</li>
<li>Go to your Keyboard preferences</li>
<li>Select Shortcuts</li>
<li>Choose Services on the left</li>
<li>Scroll to the very end and the Luxafor-Color-Green and Luxafor-Color-Red services should be listed</li>
<li>Click on the row at the right and get into the Add Shortcut mode</li>
<li>Press the key combination you want to assign to each</li>
<li>Close your Keyboard preferences window</li>
</ol>
<h3>Troubleshooting</h3>
<p>
With this in place, your keyboard shortcuts should work. If they don't, here are some settings to check that seem to be touchy.
</p>
<ul>
<li>The "Shell" selection in the Automator Service. Mine defaulted to /usr/bin/zsh, but that didn't save properly. When I opened the service back up in Automator (easily done from the Keyboard shortcuts list), the Shell field was blank. I set it to /bin/zsh and this has worked.</li>
<li>The Automator script was saved as a generic Workflow and it didn't show up in the General list of services. I had to use the Convert to... UI and choose to convert it to a Service.</li>
<li>The paths for node or the script were incorrect. Just be careful with these and test them inside the Automator UI.</li>
</ul>


