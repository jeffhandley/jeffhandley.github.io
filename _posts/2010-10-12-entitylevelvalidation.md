---
layout: post
title: "RIA Services Validation: Entity-Level Validation"
date: 2010-10-12 08:31:05 -0700
comments: true
tags: ["RiaServicesValidation", "RiaServices", "Validation", "Silverlight", "DataAnnotations"]
redirect_from: ["/archive/2010/10/12/EntityLevelValidation.aspx/", "/archive/2010/10/12/entitylevelvalidation.aspx"]
author: "Jeff Handley"
---
<!-- more -->
<p>In my last post, I went over some <a title="RIA Services Validation: Cross-Field Validation" href="/archive/2010/10/10/CrossFieldValidation.aspx" target="_blank">cross-field validation</a> scenarios and provided some sample code, including a CompareValidatorAttribute.  We’ve now covered single-field validation and cross-field validation, but there’s yet another level of validation supported by RIA Services—Entity-Level validation.  As you’ll see in this post, entity-level validation is very similar to what we’ve already seen.</p>  <h3>Entity-Level Validation Declaration</h3>  <p>Your entity types can declare entity-level validation using either the <a title="MSDN: CustomValidationAttribute Class" href="http://msdn.microsoft.com/en-us/library/system.componentmodel.dataannotations.customvalidationattribute(VS.95).aspx" target="_blank">[CustomValidation] attribute</a> approach where a <a title="RIA Services Validation: Custom Validation Methods" href="/archive/2010/09/25/RiaServicesCustomValidationMethods.aspx" target="_blank">custom validation method</a> is supplied, or by having an attribute that <a title="RIA Services Validation: Custom Reusable Validators" href="/archive/2010/09/26/RiaServicesCustomReusableValidators.aspx" target="_blank">derives from ValidationAttribute</a>.  Either way, to indicate that a validation rule applies at the entity-level (or type-level) as opposed to the property-level, you simply put the attribute on the class itself instead of on a specific property.  See how simple this is:</p>  <pre style="font-family: "><font face="Consolas"><font size="2"><font color="#000000">    [</font><span style="color: "><font color="#2b91af">CustomValidation</font></span><font color="#000000">(</font><span style="color: "><font color="#0000ff">typeof</font></span><font color="#000000">(</font><span style="color: "><font color="#2b91af">MeetingValidators</font></span><font color="#000000">), </font><span style="color: "><font color="#a31515">"PreventExpensiveMeetings"</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000">)]<br />    </font><span style="color: "><font color="#0000ff">public</font></span><font color="#000000"> </font><span style="color: "><font color="#0000ff">partial</font></span><font color="#000000"> </font><span style="color: "><font color="#0000ff">class</font></span><font color="#000000"> </font><span style="color: "><font color="#2b91af">Meeting</font></span><br /></font><font color="#000000" size="2">    {<br />        ...<br />    }</font></font><br /></pre>

<p>
  <br />In this example, I’m using the [CustomValidation] attribute approach.  Because I rarely find entity-level validation to be reusable across entities, I typically go that route.  But if your business rules lead to scenarios where you do in fact have common entity-level validation, you might benefit from creating a derived validation attribute.</p>

<p>Here’s the implementation of my <strong>PreventExpensiveMeetings</strong> validation method.</p>

<pre style="font-family: "><font face="Consolas"><font color="#000000"><font size="2">    </font></font><font size="2"><span style="color: "><font color="#808080">///</font></span><span style="color: "><font color="#008000"> </font></span><span style="color: "><font color="#808080">&lt;summary&gt;</font></span><br /><font color="#000000">    </font><span style="color: "><font color="#808080">///</font></span><span style="color: "><font color="#008000"> Ensure that long meetings don't include too many attendees.</font></span><br /><font color="#000000">    </font><span style="color: "><font color="#808080">///</font></span><span style="color: "><font color="#008000"> </font></span><span style="color: "><font color="#808080">&lt;/summary&gt;</font></span><br /><font color="#000000">    </font><span style="color: "><font color="#808080">///</font></span><span style="color: "><font color="#008000"> </font></span><font color="#808080"><span style="color: ">&lt;param name=</span><span style="color: ">"meeting"</span><span style="color: ">&gt;</span></font><span style="color: "><font color="#008000">The meeting to validate.</font></span><span style="color: "><font color="#808080">&lt;/param&gt;</font></span><br /><font color="#000000">    </font><span style="color: "><font color="#808080">///</font></span><span style="color: "><font color="#008000"> </font></span><span style="color: "><font color="#808080">&lt;returns&gt;</font></span><br /><font color="#000000">    </font><span style="color: "><font color="#808080">///</font></span><span style="color: "><font color="#008000"> A </font></span><font color="#808080"><span style="color: ">&lt;see cref=</span><span style="color: ">"ValidationResult"</span><span style="color: ">/&gt;</span></font><span style="color: "><font color="#008000"> with an error or </font></span><font color="#808080"><span style="color: ">&lt;see cref=</span><span style="color: ">"ValidationResult.Success"</span><span style="color: ">/&gt;</span></font><span style="color: "><font color="#008000">.</font></span><br /><font color="#000000">    </font><span style="color: "><font color="#808080">///</font></span><span style="color: "><font color="#008000"> </font></span><span style="color: "><font color="#808080">&lt;/returns&gt;</font></span><br /><font color="#000000">    </font><span style="color: "><font color="#0000ff">public</font></span><font color="#000000"> </font><span style="color: "><font color="#0000ff">static</font></span><font color="#000000"> </font><span style="color: "><font color="#2b91af">ValidationResult</font></span><font color="#000000"> PreventExpensiveMeetings(</font><span style="color: "><font color="#2b91af">Meeting</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> meeting)<br />    {<br />        </font><span style="color: "><font color="#2b91af">TimeSpan</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> duration = meeting.End - meeting.Start;<br />        </font><span style="color: "><font color="#0000ff">int</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> attendees = (meeting.MaximumAttendees + meeting.MinimumAttendees) / 2;<br />        </font><span style="color: "><font color="#0000ff">int</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> cost = attendees * 50 * duration.Hours;<br /> <br />        </font><span style="color: "><font color="#0000ff">if</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> (cost &gt; 10000)<br />        {<br />            </font><span style="color: "><font color="#0000ff">return</font></span><font color="#000000"> </font><span style="color: "><font color="#0000ff">new</font></span><font color="#000000"> </font><span style="color: "><font color="#2b91af">ValidationResult</font></span><font color="#000000">(</font><span style="color: "><font color="#a31515">"Meetings cannot cost the company more than $10,000."</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000">);<br />        }<br /> <br />        </font><span style="color: "><font color="#0000ff">return</font></span><font color="#000000"> </font><span style="color: "><font color="#2b91af">ValidationResult</font></span></font><font color="#000000" size="2">.Success;<br />    }</font></font><br /></pre>

<p>
  <br />There are some differences between this validation method and the ones we saw for single-field and cross-field validation:</p>

<ol>
  <li>The value parameter is strongly-typed to our Meeting type; </li>

  <li>The <a title="MSDN: ValidationContext Class" href="http://msdn.microsoft.com/en-us/library/system.componentmodel.dataannotations.validationcontext(VS.95).aspx" target="_blank">ValidationContext</a> parameter is not accepted as it doesn’t need to be used; </li>

  <li>The <a title="MSDN: ValidationResult Class" href="http://msdn.microsoft.com/en-us/library/system.componentmodel.dataannotations.validationresult(VS.95).aspx" target="_blank">ValidationResult</a> instance returned does not specify any member names; </li>
</ol>

<p>If you were creating a reusable entity-level validator, you might find that you want to accept the ValidationContext parameter so that you can use the ValidationContext.ObjectType property, or quite possibly additional state information that can be provided by ValidationContext.  Similarly, there’s no reason why you can’t have your method specify the MemberName(s) for the ValidationResult; this should be done if you have clear direction to give the user on what field(s) to change to correct the error.</p>

<h3>Entity-Level Validation Triggers</h3>

<p>It can be tricky to differentiate between cross-field validation and entity-level validation.  In fact, the PreventExpensiveMeetings example is performing cross-field validation.  It’s validating values across the Start, End, MinimumAttendees, and MaximumAttendees fields.  Previously, we saw validation rules defined that validated the Start/End property pairs and the MinimumAttendees/MaximumAttendees properties.  Each of those validators was applied to both properties and users got notification of errors as soon as one of the fields was put into conflict with the other.  The PreventExpensiveMeetings scenario is different for a few reasons though, and these are what I look for when deciding whether to implement validation at the property-level or the entity-level.</p>

<ol>
  <li><strong>There’s no certain data entry path that will lead to the validation error.</strong>  Because PreventExpensiveMeetings is based on 4 disjoint fields, it is unclear what property we’d want to declare the validation rule for.  The model is unaware of what order the user will enter values in, so we cannot simply put the validation rule on the “last” field.  We could apply the validator to all four properties, but this leads to a few issues.

  <ol>
  <li>The value parameter could represent either a DateTime or an Integer, depending on which member is being validated.  This will complicate the validation code. </li>

  <li>Because property validation occurs before the value is set on the property, you must use the value parameter conditionally, based on ValidationContext.MemberName, further complicating the code. </li>

  <li>The validation attribute would be repeated on your model, which causes a headache and can lead to maintenance mistakes. </li>
  </ol>
  </li>

  <li><strong>There’s no clear user guidance on how to correct the error.</strong>  If users hit this error, would you advise them to shorten the meeting, or decrease the number of attendees?  Furthermore, would you suggest changing the Start time or the End time; or the Minimum Attendees, or the Maximum Attendees?  Sometimes, only the end user knows how to correct complex errors. </li>

  <li><strong>Property-Level validation could lead to “noise” for the end user, while the properties are being edited.</strong>  With validation rules that involve many fields, it becomes quite probable that users will hit situations where changes temporarily violate validation rules.  If these rules are executed too aggressively, users will become frustrated by errors they know will go away as soon as they finish making their changes.  Just think about how annoyed you get when Visual Studio tells you about build errors while you’re refactoring something. </li>

  <li><strong>The validation rule relies upon property-level validation being successful.</strong>  If you look closely at the validation logic for PreventExpensiveMeetings, you’ll realize that a meeting that lasts <em>-6 hours</em> and has <em>between 10 and -200 attendees</em> would cost the company $28,500 and display a validation error.  This of course isn’t right.  Before invoking this validation rule, we should ensure that the meeting doesn’t result in time travel and that the min/max attendees range is valid. </li>
</ol>

<p>In the <a title="RIA Services Validation: Validation Triggers" href="/archive/2010/10/06/RiaServicesValidationTriggers.aspx" target="_blank">Validation Triggers</a> article, we learned that entity-level validation occurs in a few places:</p>

<ol>
  <li>Ending Edit Sessions - Entity.EndEdit() </li>

  <li>Submitting Changes - DomainContext.SubmitChanges() </li>

  <li>Custom Entity Update Methods </li>
</ol>

<p>For each of those triggers, property-level validation is performed first, and only if all properties are valid are entity-level validators invoked.  In light of our validation rule relying upon property-level validation being successful, it now makes a lot more sense why this short circuit is in place.  Here’s a reminder of the validation stages:</p>

<ol>
  <li>Execute all [Required] validators on the entity’s properties.  If any required properties are missing values, validation fails and stops (but multiple required-field validation errors can occur). </li>

  <li>Execute the remainder of the property-level validators.  If any property is found to be invalid, validation fails and stops (but multiple property validation errors can occur). </li>

  <li>Execute all entity-level validators.  If any entity-level validator is found to be invalid, validation fails and stops (but multiple validation errors can occur). </li>

  <li><em>(Server Only) </em>Check the entity for an IValidatableObject implementation; if implemented, execute the Validate() method.  If any validation errors are returned, validation fails. </li>
</ol>

<h3>Displaying Entity-Level Validation Errors</h3>

<p>Also mentioned in the Validation Triggers post, DataGrid and DataForm have deep support for validation; this includes entity-level validation.  Both of these controls are able to display entity-level validation right out of the box.  Here’s what you will see when an entity-level validation error occurs in each of these controls.</p>

<p><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="DataGrid Entity-Level Validation" border="0" alt="DataGrid Entity-Level Validation" src="/img/postimages/RIA-Services-Validation-Entity-Level-Val_1436B/image_e0aa9c13-f143-44a1-86d7-7e89b64d9278.png" width="508" height="110" /></p>

<p><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="DataForm Entity-Level Validation" border="0" alt="DataForm Entity-Level Validation" src="/img/postimages/RIA-Services-Validation-Entity-Level-Val_1436B/image_3102450d-999b-4660-8daf-0582c86a41ec.png" width="503" height="331" /></p>

<p>If you are not using the DataGrid or DataForm, there’s a trick that can be applied to display a single entity-level validation error when one occurs.  This is to have a control on your page that has a binding to the entity itself, and not to a property on the entity.  For instance, the following XAML would lead to having a TextBox that will show the first entity-level validation error that occurs on the Meeting that is set to be the DataContext of the Grid.</p>

<pre style="font-family: "><font face="Consolas"><span style="color: "><font color="#a31515"><font size="2">    </font></font></span><font size="2"><span style="color: "><font color="#0000ff">&lt;</font></span><span style="color: "><font color="#a31515">Grid</font></span><span style="color: "><font color="#0000ff">&gt;</font></span><br /><span style="color: "><font color="#a31515">        </font></span><span style="color: "><font color="#0000ff">&lt;</font></span><span style="color: "><font color="#a31515">Grid.DataContext</font></span><span style="color: "><font color="#0000ff">&gt;</font></span><br /><span style="color: "><font color="#a31515">            </font></span><span style="color: "><font color="#0000ff">&lt;</font></span><span style="color: "><font color="#a31515">my</font></span><span style="color: "><font color="#0000ff">:</font></span><span style="color: "><font color="#a31515">Meeting</font></span><span style="color: "><font color="#0000ff"> /&gt;</font></span><br /><span style="color: "><font color="#a31515">        </font></span><span style="color: "><font color="#0000ff">&lt;/</font></span><span style="color: "><font color="#a31515">Grid.DataContext</font></span><span style="color: "><font color="#0000ff">&gt;</font></span><br /><span style="color: "><font color="#a31515">        </font></span><span style="color: "><font color="#0000ff">&lt;</font></span><span style="color: "><font color="#a31515">TextBox</font></span><span style="color: "><font color="#ff0000"> Text</font></span><font color="#0000ff"><span style="color: ">=</span><span style="color: ">"Schedule a Meeting"</span></font><br /><font color="#000000">                   </font><span style="color: "><font color="#ff0000"> DataContext</font></span><span style="color: "><font color="#0000ff">="{</font></span><span style="color: "><font color="#a31515">Binding</font></span><font color="#0000ff"><span style="color: ">}</span><span style="color: ">"</span></font><br /><font color="#000000">                   </font><span style="color: "><font color="#ff0000"> BorderThickness</font></span><font color="#0000ff"><span style="color: ">=</span><span style="color: ">"0"</span></font><br /><font color="#000000">                   </font><span style="color: "><font color="#ff0000"> IsReadOnly</font></span><font color="#0000ff"><span style="color: ">=</span><span style="color: ">"True"</span></font><br /><font color="#000000">                   </font><span style="color: "><font color="#ff0000"> HorizontalAlignment</font></span><font color="#0000ff"><span style="color: ">=</span><span style="color: ">"Left"</span><span style="color: "> /&gt;</span></font><br /><span style="color: "><font color="#a31515">    </font></span><span style="color: "><font color="#0000ff">&lt;/</font></span><span style="color: "><font color="#a31515">Grid</font></span><span style="color: "><font color="#0000ff">&gt;</font></span></font></font><br /></pre>

<p><font size="2" />

  </p><p>
  <br />The key is having something on the TextBox bound to the Meeting instance using a {Binding} without a Path.  This binding can exist on any property, not just Text; in this case, I used the DataContext property.  Of course, this XAML is contrived and won’t actually set up the ability to edit a meeting.  But using this TextBox declaration in a different context, my page shows the following when I end editing on the meeting:</p>

  <p><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="Entity-Level Validation" border="0" alt="Entity-Level Validation" src="/img/postimages/RIA-Services-Validation-Entity-Level-Val_1436B/image_f0645387-e05f-49e8-957b-a3b8f65de8bc.png" width="380" height="313" /></p>

  <p>I am by no means a designer though (can you tell?), so I will stop short of advising you on how best to show your entity-level errors to your end users.  If you are interested, Regis Brid’s <a title="Implementing Data Validation in Silverlight with INotifyDataErrorInfo" href="http://www.silverlight.net/learn/whitepapers/introducing-new-inotifydataerrorinfo-interface" target="_blank">whitepaper on INotifyDataErrorInfo</a> includes a reusable ValidationErrorViewer control that can be used to show a list of entity-level validation errors, using a trick similar to the {Binding} markup shown above.</p>

  <h3>RIA Services Validation Recap</h3>

  <p>We can now see that some occurrences of cross-field validation should really be broken out to the entity-level stage of validation.  This allows the validation rule to execute on the entity in a state where all property values are known to be valid, and the logic can be implemented very easily.  Declaring the entity-level validation is simple too: just apply a [CustomValidation] attribute to the entity’s class rather than on a property.  DataGrid and DataForm will both display entity-level validation errors by default, and you can use a {Binding} trick to get some primitive controls to display an entity-level validation error too.</p>

  <p>This article is part of an in-depth series on RIA Services Validation.  Here’s the full series:</p>

  <ol>
  <ol>
  <li><a href="http://jeffhandley.com/archive/2010/09/22/RiaServicesStandardValidators.aspx">Standard Validators</a></li>

  <li><a href="http://jeffhandley.com/archive/2010/09/25/RiaServicesCustomValidationMethods.aspx">Custom Validation Methods</a></li>

  <li><a href="http://jeffhandley.com/archive/2010/09/26/RiaServicesCustomReusableValidators.aspx">Custom Reusable Validators</a></li>

  <li><a href="http://jeffhandley.com/archive/2010/09/30/RiaServicesValidationAttributePropagation.aspx">Attribute Propagation</a></li>

  <li><a href="http://jeffhandley.com/archive/2010/10/06/RiaServicesValidationTriggers.aspx">Validation Triggers</a></li>

  <li><a href="http://jeffhandley.com/archive/2010/10/10/CrossFieldValidation.aspx">Cross-Field Validation</a></li>

  <li><a href="http://jeffhandley.com/archive/2010/10/12/EntityLevelValidation.aspx">Entity-Level Validation</a></li>

  <li><a href="http://jeffhandley.com/archive/2010/10/25/RiaServicesValidationContext.aspx">Providing ValidationContext</a></li>

  <li><a href="http://jeffhandley.com/archive/2010/10/25/CrossEntityValidation.aspx">Using ValidationContext (Cross-Entity Validation)</a></li>

  <li><a href="http://jeffhandley.com/archive/2011/09/06/ViewModelValidation.aspx">ViewModel Validation with Entity Rules</a></li>
  </ol>
  </ol>

  <p><strong><em>[9/6/2011] The source code for everything shown during the series is <a href="http://jeffhandley.com/archive/2011/09/06/RIA-Services-Validation-Available-on-GitHub.aspx">available on GitHub</a>.</em></strong></p>

  <h3>Digging Deeper</h3>

  <p>We have already covered a great deal, but there are plenty of validation topics left to cover.  Still to come, we’ll be exploring the power of ValidationContext and I’ll also provide a validator factory implementation that can consume validation rules from other types so that validation rules from entities can be inherited into a ViewModel!</p>



