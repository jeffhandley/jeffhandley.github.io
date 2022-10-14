---
layout: post
title: "RIA Services Validation: ViewModel Validation with Entity Rules"
date: 2011-09-07 06:31:01 -0700
comments: true
tags: ["RiaServicesValidation", "RIAServicesValidation", "Validation", "Silverlight", "DataAnnotations"]
redirect_from: ["/archive/2011/09/06/ViewModelValidation.aspx/", "/archive/2011/09/06/viewmodelvalidation.aspx"]
author: "Jeff Handley"
---
<!-- more -->
<p>For those of you familiar with the ViewModel (or MVVM) pattern, you are likely also familiar with a typical pain point regarding validation: you often need to duplicate your entity validation metadata onto your ViewModel classes.  This can lead to burdensome dual maintenance of your validation rules, and it can seem very frustrating that with the server to client metadata propagation that RIA Services offers, your ViewModel classes are left dangling out there for you to manage yourself.  In this post, I’ll illustrate a utility I created that allows a ViewModel to assume validation metadata from model classes or properties, eliminating the dual maintenance.</p>  <h3>ModelPropertyValidator</h3>  <p>Virtually every ViewModel will have properties that actually represent properties from your model.  Let’s use the meeting invitation model from earlier RIA Services Validation posts as an example.  My meeting object has a bunch of properties such as Title, Start, End, Location, MinimumAttendees, MaximumAttendees, and Details.  It’s easy to imagine a ViewModel that could be used for managing meetings where the UI would have a subset or superset of the meeting properties.  For each field on the screen that represents a meeting property, I should be able to indicate which model property is associated with each ViewModel property so that the model validation can be imported automatically.  This is where ModelPropertyValidator comes in.</p>  <p>Here’s a subset of the Meeting class with its data annotations in my Web project:</p>

