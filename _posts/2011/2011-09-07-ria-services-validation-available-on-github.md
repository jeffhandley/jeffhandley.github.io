---
layout: post
title: "RIA Services Validation: Available on GitHub"
date: 2011-09-07 06:50:15 -0700
comments: true
tags: ["RiaServicesValidation", "RIAServices", "Validation", "Silverlight", "DataAnnotations"]
redirect_from: ["/archive/2011/09/06/RIA-Services-Validation-Available-on-GitHub.aspx/", "/archive/2011/09/06/ria-services-validation-available-on-github.aspx"]
author: "Jeff Handley"
---
<!-- more -->
<p>I’ve gotten quite a few requests for the source code behind the RIA Services Validation blog post series.  I am pleased to announce that the code is now published on GitHub.</p>  <p><a href="http://github.com/jeffhandley/RIAServicesValidation">http://github.com/jeffhandley/RIAServicesValidation</a></p>  <p>Within that repository, you’ll find:</p>  <ol>   <li>RudeValidation.Web/Models – Server-side model classes </li>  <li>RudeValidation.Web/Validators – Custom validators including CompareValidator, ConditionallyRequired, and DateValidator </li>  <li>RudeValidation/Views – Sample screens showing the validation in action </li>  <li>RudeValidation/ViewModels - Where you’ll find the sample ViewModel as well as the very simple ViewModelBase </li> </ol>  <p>If you’re not familiar with Git, don’t be intimidated.  You can easily view the code directly in your browser by starting out at <a href="http://github.com/jeffhandley/RIAServicesValidation">http://github.com/jeffhandley/RIAServicesValidation</a> and just clicking through the folders and files.  To download all of the source, just click the Downloads button, and click to download the Zip file.  As always when downloading a Zip from the tubes, be sure to Unblock the Zip file through the Properties window before you extract the contents.  Then, be sure to set the RudeValidation.Web project as the startup.  After that, you are welcome to do whatever you want with the source code included.</p>  <h3>RIA Services Validation Recap</h3>  <p>Over the course of a 10-post series, we learned about the standard validators, how to create different types of custom validators, how the validation attributes get propagated, how to perform common cross-field and cross-entity validation, and now we have a utility for importing model rules into ViewModel classes.  Here’s the full series:</p>  <ol>   <ol>   <li><a href="http://jeffhandley.com/archive/2010/09/22/RiaServicesStandardValidators.aspx">Standard Validators</a> </li>  <li><a href="http://jeffhandley.com/archive/2010/09/25/RiaServicesCustomValidationMethods.aspx">Custom Validation Methods</a> </li>  <li><a href="http://jeffhandley.com/archive/2010/09/26/RiaServicesCustomReusableValidators.aspx">Custom Reusable Validators</a> </li>  <li><a href="http://jeffhandley.com/archive/2010/09/30/RiaServicesValidationAttributePropagation.aspx">Attribute Propagation</a> </li>  <li><a href="http://jeffhandley.com/archive/2010/10/06/RiaServicesValidationTriggers.aspx">Validation Triggers</a> </li>  <li><a href="http://jeffhandley.com/archive/2010/10/10/CrossFieldValidation.aspx">Cross-Field Validation</a> </li>  <li><a href="http://jeffhandley.com/archive/2010/10/12/EntityLevelValidation.aspx">Entity-Level Validation</a> </li>  <li><a href="http://jeffhandley.com/archive/2010/10/25/RiaServicesValidationContext.aspx">Providing ValidationContext</a> </li>  <li><a href="http://jeffhandley.com/archive/2010/10/25/CrossEntityValidation.aspx">Using ValidationContext (Cross-Entity Validation)</a> </li>  <li><a href="http://jeffhandley.com/archive/2011/09/06/ViewModelValidation.aspx">ViewModel Validation with Entity Rules</a> </li>   </ol> </ol>
