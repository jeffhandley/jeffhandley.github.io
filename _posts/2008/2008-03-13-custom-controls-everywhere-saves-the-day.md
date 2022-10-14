---
layout: post
title: "Custom Controls Everywhere Saves the Day"
date: 2008-03-13 21:11:31 -0700
comments: true
tags: ["Custom Controls Everywhere", "Validation"]
redirect_from: ["/archive/2008/03/13/custom-controls-everywhere-saves-the-day.aspx/"]
author: "Jeff Handley"
---
<!-- more -->
<p>I just cannot advocate Custom Controls Everywhere strongly enough.  I find benefits for it all the time.  It saved the day again today.  Self-validating controls played into this one too.</p>  <p>Here's what a co-worker reported to me a few minutes ago:</p>  <p>Ron Ellis says (1:45 PM):   <br />on the textbox  <br />format = decimal  <br />Ron Ellis says (1:46 PM):  <br />if you enter just a "-" it bombs</p>  <p>To which, I replied, "Lovely.  It sounds like our regex is wrong."  Ron found that our UnsignedDecimal and Decimal formats were as follows:</p>  <ul>   <li>UnsignedDecimal As String = "[\d]*(\.[\d]*)?"</li>  <li>[Decimal] As String = "(\-)?" &amp; UnsignedDecimal</li> </ul>  <p>The flaw here is that the Decimal format just allows an optional sign in front of an optional number.  The expression doesn't validate that if you type in a sign, you must follow it with a number.  We need to correct our regular expression for our Decimal format.</p>  <p>The good news is that we have a single constant string defined in our textbox control for this.  Since the textbox is self-validating and exposes a property of Format that can be set to Decimal, that is all we have to do anywhere in the application to enforce a decimal entry.  So we'll change the constant string to a correct signed decimal expression (from regexlib.com no doubt), and validation will be fixed, application-wide.</p>  <p>Imagine finding this problem in a 700-screen application that didn't use Custom Controls Everywhere and Self-Validating controls.  Ick!</p>
