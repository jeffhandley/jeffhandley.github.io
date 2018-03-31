---
layout: post
title: "Attention Login Forms, Control Your Focus"
date: 2009-01-06 07:28:43 -0800
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.github.io/archive/2009/01/05/attention-login-forms-control-your-focus.aspx"]
author: 0
---
<!-- more -->
<p>I remember back in 1999 when it was a <em>really</em> cool trick to automatically put focus into the first form field when the page finished loading.  That used to be an impressive bit of JavaScript.  But anymore, I am flabbergasted at how many sites implement this incorrectly.  I am tired of getting frustrated by the following series of events:</p>  <ol>   <li>Open a new browser window and navigate to your bank’s website, say for instance, <a href="http://www.citicards.com">www.citicards.com</a></li>    <li>As soon as the login form appears, you click your mouse into the username box and enter your username</li>    <li>You hit tab, shudder at the fact that you have to hit tab again to get to the password box, but nonetheless, you hit tab again to put focus into the password box</li>    <li>You type your cryptic, ultra-secure password that you never want anyone to see, maybe glancing down at the keyboard while you type it because it’s so hard to type the thing</li>    <li>You look back at the screen before hitting enter, and you see the screen shot below</li> </ol>  <p><img title="image" style="display: inline; margin: 0px 10px 10px 0px" height="313" alt="image" src="http://blog.jeffhandley.com/Images/PostImages/AttentionLoginFormsControlYourFocus_14A11/image.png" width="308" align="left" /> </p>  <p>For this demonstration, I put in my User ID as “username” then hit tab twice and entered my password of “super secret.”  As you can see, my super secret password isn’t much of a secret anymore.</p>  <p>How did this happen?</p>  <p>In between hitting tab for the 2nd time and beginning to enter my password, the page finished loading.  Upon load completion, a JavaScript method ran to force focus into the User ID textbox, without checking a precondition to see if I had already manually moved focus into the field myself and begun entering my credentials.</p>  <p>I see this crap all the time.  I’m tired of it.  If you’re the owner of a login form, or for that matter, any other form that automatically sets focus, please do some checks to make sure you’re not pissing your users off when you’re in fact trying to help them.</p>

