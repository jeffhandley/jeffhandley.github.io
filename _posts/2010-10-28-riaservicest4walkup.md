---
layout: post
title: "RIA Services T4: Walk-Up Experience"
date: 2010-10-28 09:44:19 -0700
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.com/archive/2010/10/28/RiaServicesT4WalkUp", "http://jeffhandley.com/archive/2010/10/28/riaservicest4walkup"]
author: 0
---
<!-- more -->
<h4><strong><em><font size="3">UPDATE: The RIA Services team released a </font></em></strong><a href="/archive/2010/12/02/ToolkitDecember2010.aspx" target="_blank"><strong><em><font size="3">December 2010 Toolkit</font></em></strong></a><strong><em><font size="3">, and that release fixes the build issues encountered below.  But this post still has value as it shows some ways to modify the code generated by our T4 Code Generator.  Be sure to check out </font></em></strong><a href="http://varunpuranik.wordpress.com/2010/12/02/t4-code-generator-dec-10-update/" target="_blank"><strong><em><font size="3">Varun Puranik’s Blog</font></em></strong></a><strong><em><font size="3"> for more details on the December 2010 update.</font></em></strong></h4>  <hr />  <p>The RIA Services T4 Code Generation feature was checked in about 3 hours before we published our MSI for <a href="http://jeffhandley.com/archive/2010/10/27/RiaServicesV1SP1Beta.aspx" target="_blank">today’s release</a>.  Talk about publishing an <u>experimental</u> feature!  So tonight, I decided to take the app that I’ve been working on for my <a href="http://jeffhandley.com/tags/RiaServicesValidation/" target="_blank">RIA Services Validation</a> series and flip it over to the T4 generator to see what the experience is like.  Here is my uncensored experience.</p>  <h4>Flipping the Switch</h4>  <p>In order to use our T4 code generator, you first need to add an assembly reference:</p>  <ul>   <li><strong>Microsoft.ServiceModel.DomainServices.Tools.TextTemplate</strong> (Our T4 code generator from the Toolkit) </li> </ul>  <p>Then you need to edit your Silverlight project file and add the following into the project properties:</p>  <pre style="font-family: "><font face="Consolas"><span><font color="#0000ff"><font size="2">      &lt;</font></font></span><font size="2"><span><font color="#a31515">RiaClientCodeGeneratorName</font></span><span><font color="#0000ff">&gt;</font></span><br /></font></font><font size="2"><font face="Consolas"><font color="#000000">          Microsoft.ServiceModel.DomainServices.Tools.TextTemplate.CSharpGenerators.CSharpClientCodeGenerator,<br />          Microsoft.ServiceModel.DomainServices.Tools.TextTemplate,<br />          Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35</font><br /><span><font color="#0000ff">      &lt;/</font></span><span><font color="#a31515">RiaClientCodeGeneratorName</font></span><span><font color="#0000ff">&gt;</font></span></font><br /></font></pre>

<pre style="font-family: "> </pre>

<p><em>We would like your project to flip over to T4 just by adding the reference; we’ve filed a bug for that.  Alternatively, it would be nice to only specify the class name here instead of the fully-qualified name.  As you’ll see below, when you add your own code generator, it actually gets simpler though.</em></p>

<p>At this point, your project is switched over to use the T4 code generator.  Compile and see how we did.  If you don’t have any compile errors, then you should be in good shape to use the T4 generator.  Some of you might experience build errors though, and if you do these are bugs and we need to hear about them.</p>

<h4>Getting Build Errors</h4>

<p>As a matter of fact, with my RudeValidation solution, after I flipped the switch, I got build errors.  I have found a bug already.  <em>Hey, I told you these were experimental bits!</em>  Here’s what I saw after my first T4 compile.</p>

<p><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="Build errors from T4 code generation" border="0" alt="Build errors from T4 code generation" src="http://jeffhandley.com/images/jeffhandley_com/Windows-Live-Writer/RIA-Services-T4-Code-Generation-Walk-Up-_14833/image_347ae6eb-c3a7-4469-b38d-30b3abdfbd5f.png" width="652" height="269" /></p>

<p>As you can see, my custom ValidationAttributes accept parameters of enum types, and the enum values are not being qualified properly.  Oh well, I guess this T4 stuff won’t work for me, huh?  Wait!  I have control over the generated code… maybe I can fix this!</p>

<h4>Providing a ClientCodeGenerator</h4>

<p>I want to introduce my own code generator to take control and try to fix this issue.  I need to create a new class and derive from <strong>CSharpClientCodeGenerator</strong>, and decorate my class with a <strong>DomainServiceClientCodeGenerator</strong> attribute.  Let’s start with that.</p>

<pre style="font-family: "><font face="Consolas"><font size="2"><font color="#000000">    </font><span><font color="#0000ff">using</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> Microsoft.ServiceModel.DomainServices.Tools;<br />    </font><span><font color="#0000ff">using</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> Microsoft.ServiceModel.DomainServices.Tools.TextTemplate.CSharpGenerators;<br /> <br />    </font><span><font color="#0000ff">namespace</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> RudeValidation.Web.T4<br />    {<br />        </font><span><font color="#008000">// Needed to add a reference to Microsoft.ServiceModel.DomainServices.Tools</font></span><br /><font color="#000000">        [</font><span><font color="#2b91af">DomainServiceClientCodeGenerator</font></span><font color="#000000">(</font><span><font color="#0000ff">typeof</font></span><font color="#000000">(</font><span><font color="#2b91af">RudeValidationClientCodeGenerator</font></span><font color="#000000">), </font><span><font color="#a31515">"C#"</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000">)]<br /> </font><font color="#000000">       </font><span><font color="#0000ff">public</font></span><font color="#000000"> </font><span><font color="#0000ff">class</font></span><font color="#000000"> </font><span><font color="#2b91af">RudeValidationClientCodeGenerator</font></span><font color="#000000"> : </font><span><font color="#2b91af">CSharpClientCodeGenerator</font></span><br /></font><font color="#000000" size="2">        {<br />        }<br />    }</font></font></pre>

<p> </p>

<p>You’ll notice that I needed to add a reference to <strong>Microsoft.ServiceModel.DomainServices.Tools</strong> for this to work.  That assembly is in our framework (not the Toolkit) and it’s where the <strong>DomainServiceClientCodeGeneratorAttribute</strong> class is defined.  Also, in order for this to compile, I needed to add a reference to <strong>System.ComponentModel.Composition</strong> (MEF) because that attribute class actually derives from <strong>ExportAttribute</strong>.</p>

<p>To switch from the default T4 code generator to our custom one, we’ll simply go back into the Silverlight project file and remove the &lt;RiaClientCodeGeneratorName&gt; tag completely.  Alternatively, we could specify the class name to the desired generator (RudeValidation.Web.T4.RudeValidationClientCodeGenerator), but since we only have 1 generator defined in our project it will be picked up by default.  After removing that tag and reloading the Silverlight project, our build is now using the custom code generator.  We still have the build error though, since we haven’t done anything to address the issue.</p>

<h4>Providing an EntityGenerator</h4>

<p>At this point, we need to find the right hook in the code generation to override behavior.  We can explore the virtual methods in <strong>CSharpClientCodeGenerator</strong> by typing “override” and letting IntelliSense lead us.  In doing so, I found that there’s a virtual property for <strong>EntityGenerator</strong>—that sounds promising, so let’s override that.  We can then derive from <strong>CSharpEntityGenerator</strong> and provide our own.  This is where we are now:</p>

<pre style="font-family: "><font face="Consolas"><font size="2"><font color="#000000">    </font><span><font color="#0000ff">using</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> Microsoft.ServiceModel.DomainServices.Tools;<br />    </font><span><font color="#0000ff">using</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> Microsoft.ServiceModel.DomainServices.Tools.TextTemplate;<br />    </font><span><font color="#0000ff">using</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> Microsoft.ServiceModel.DomainServices.Tools.TextTemplate.CSharpGenerators;<br /> <br />    </font><span><font color="#0000ff">namespace</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> RudeValidation.Web.T4<br />    {<br />        </font><span><font color="#008000">// Needed to add a reference to Microsoft.ServiceModel.DomainServices.Tools</font></span><br /><font color="#000000">        [</font><span><font color="#2b91af">DomainServiceClientCodeGenerator</font></span><font color="#000000">(</font><span><font color="#0000ff">typeof</font></span><font color="#000000">(</font><span><font color="#2b91af">RudeValidationClientCodeGenerator</font></span><font color="#000000">), </font><span><font color="#a31515">"C#"</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000">)]<br />        </font><span><font color="#0000ff">public</font></span><font color="#000000"> </font><span><font color="#0000ff">class</font></span><font color="#000000"> </font><span><font color="#2b91af">RudeValidationClientCodeGenerator</font></span><font color="#000000"> : </font><span><font color="#2b91af">CSharpClientCodeGenerator</font></span><br /></font></font><font face="Consolas"><font size="2"><font color="#000000">        {<br />            </font><span><font color="#0000ff">protected</font></span><font color="#000000"> </font><span><font color="#0000ff">override</font></span><font color="#000000"> </font><span><font color="#2b91af">EntityGenerator</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> EntityGenerator<br />            {<br />                </font><span><font color="#0000ff">get</font></span><br /></font></font><font face="Consolas"><font size="2"><font color="#000000">                {<br />                    </font><span><font color="#0000ff">return</font></span><font color="#000000"> </font><span><font color="#0000ff">new</font></span><font color="#000000"> </font><span><font color="#2b91af">RudeValidationEntityGenerator</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000">();<br />                }<br />            }<br /> <br />            </font><span><font color="#0000ff">public</font></span><font color="#000000"> </font><span><font color="#0000ff">class</font></span><font color="#000000"> </font><span><font color="#2b91af">RudeValidationEntityGenerator</font></span><font color="#000000"> : </font><span><font color="#2b91af">CSharpEntityGenerator</font></span><br /></font><font color="#000000" size="2">            {<br />            }<br />        }<br />    }</font></font></pre>

<p> </p>

<p>We’re still not customizing behavior, but we’re getting close.  We now have our own <strong>EntityGenerator</strong> and our custom <strong>DomainServiceClientCodeGenerator</strong> is set up to use it.</p>

<h4>Customizing the Code</h4>

<p>Let’s let IntelliSense guide us again.  From inside the derived <strong>EntityGenerator</strong> class, I typed “override” and discovered <strong>GenerateAttributes</strong> is a virtual method that sounds promising.  This method accepts a list of <strong>Attribute</strong> instances that have been instantiated based on what the server declares for every entity, and its job is to write out the client code to represent those attribute declarations.  Using T4, this would be done in a TT file; in a C# class file, this can be done using <strong>this.Write</strong>/<strong>this.WriteLine</strong>.</p>

<p>To be honest, I’m kind of stuck here though.  The logic required to transform server-side attribute instances into client-side attribute declarations is nontrivial at best.  For those seeking to take <em>full control</em> over the attribute declarations, we have given them exactly what they need, <em>full control</em>.  But those those like me who just need to tweak the current behavior ever so slightly, the barrier to entry is pretty high from here.</p>

<p>This is precisely the kind of feedback our team needs to hear.  When you are trying to take over on code gen, where are you getting stuck?  Technically, all of the hooks are in place for you to completely own the generated code, but what helpers can we provide to allow you to generate the code you desire?</p>

<h4>Implementing a Hack</h4>

<p>What, did you think I was going to give up?  No way!  I want my project to build using the T4 generator.  Even if I don’t have the right tools to tweak this through a nifty API, I still own the code that is getting generated, so let’s fix it.</p>

<p>In the end, each generator has a <strong>TransformText()</strong> method that returns the generated code.  We can override this method and massage the output as much as we want.  While the following code is by no means elegant, it gets the job done.</p>

<pre style="font-family: "><font face="Consolas"><font size="2"><font color="#000000">    </font><span><font color="#0000ff">using</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> Microsoft.ServiceModel.DomainServices.Tools;<br />    </font><span><font color="#0000ff">using</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> Microsoft.ServiceModel.DomainServices.Tools.TextTemplate;<br />    </font><span><font color="#0000ff">using</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> Microsoft.ServiceModel.DomainServices.Tools.TextTemplate.CSharpGenerators;<br /> <br />    </font><span><font color="#0000ff">namespace</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> RudeValidation.Web.T4<br />    {<br />        </font><span><font color="#008000">// Needed to add a reference to Microsoft.ServiceModel.DomainServices.Tools</font></span><br /><font color="#000000">        [</font><span><font color="#2b91af">DomainServiceClientCodeGenerator</font></span><font color="#000000">(</font><span><font color="#0000ff">typeof</font></span><font color="#000000">(</font><span><font color="#2b91af">RudeValidationClientCodeGenerator</font></span><font color="#000000">), </font><span><font color="#a31515">"C#"</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000">)]<br />        </font><span><font color="#0000ff">public</font></span><font color="#000000"> </font><span><font color="#0000ff">class</font></span><font color="#000000"> </font><span><font color="#2b91af">RudeValidationClientCodeGenerator</font></span><font color="#000000"> : </font><span><font color="#2b91af">CSharpClientCodeGenerator</font></span><br /></font></font><font face="Consolas"><font size="2"><font color="#000000">        {<br />            </font><span><font color="#0000ff">protected</font></span><font color="#000000"> </font><span><font color="#0000ff">override</font></span><font color="#000000"> </font><span><font color="#2b91af">EntityGenerator</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> EntityGenerator<br />            {<br />                </font><span><font color="#0000ff">get</font></span><br /></font></font><font face="Consolas"><font size="2"><font color="#000000">                {<br />                    </font><span><font color="#0000ff">return</font></span><font color="#000000"> </font><span><font color="#0000ff">new</font></span><font color="#000000"> </font><span><font color="#2b91af">RudeValidationEntityGenerator</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000">();<br />                }<br />            }<br /> <br />            </font><span><font color="#0000ff">public</font></span><font color="#000000"> </font><span><font color="#0000ff">class</font></span><font color="#000000"> </font><span><font color="#2b91af">RudeValidationEntityGenerator</font></span><font color="#000000"> : </font><span><font color="#2b91af">CSharpEntityGenerator</font></span><br /></font></font><font face="Consolas"><font size="2"><font color="#000000">            {<br />                </font><span><font color="#0000ff">public</font></span><font color="#000000"> </font><span><font color="#0000ff">override</font></span><font color="#000000"> </font><span><font color="#0000ff">string</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000"> TransformText()<br />                {<br />                    </font><span><font color="#0000ff">return</font></span><font color="#000000"> </font><span><font color="#0000ff">base</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000">.TransformText()<br />                            .Replace(</font><span><font color="#a31515">"(GreaterThan"</font></span><font color="#000000">, </font><span><font color="#a31515">"(RudeValidation.Web.Validators.CompareOperator.GreaterThan"</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000">)<br />                            .Replace(</font><span><font color="#a31515">"(LessThan"</font></span><font color="#000000">, </font><span><font color="#a31515">"(RudeValidation.Web.Validators.CompareOperator.LessThan"</font></span></font></font><font face="Consolas"><font size="2"><font color="#000000">)<br />                            .Replace(</font><span><font color="#a31515">"(Future"</font></span><font color="#000000">, </font><span><font color="#a31515">"(RudeValidation.Web.Validators.DateValidatorType.Future"</font></span></font><font color="#000000" size="2">);<br />                }<br />            }<br />        }<br />    }</font></font></pre>

<p> </p>

<p>Yes, I just did that.  I used 3 string replacements to fix a bug.  And you know what, I love it.  Why?  Because there was a bug in the RIA Services T4 code generation and I was able to fix it with very little code in my own project.  With this in place, my project now builds and works just as it did with the default CodeDom code generator.  I call that a Win!</p>

<h4>Reverting to CodeDom</h4>

<p><em>I’m sure you’ll need to know, so I wanted to go ahead and call this out.</em></p>

<p>We no longer have anything specified in our Silverlight project to indicate which code generator to use, but our custom generator is being picked up by convention.  There are a couple of ways of reverting back to the default CodeDom generator:</p>

<ol>
  <li>Comment out the <strong>DomainServiceClientCodeGenerator</strong> attribute on the custom class; or </li>

  <li>Open the Silverlight project file back up and supply a <strong>RiaClientCodeGeneratorName</strong> property using the full type name of the CodeDomClientCodeGenerator class:  <br /><font size="1"><font face="Consolas"><span><font color="#0000ff">&lt;</font></span><span><font color="#a31515">RiaClientCodeGeneratorName</font></span><span><font color="#0000ff">&gt;</font></span><font color="#000000">Microsoft.ServiceModel.DomainServices.Tools.CodeDomClientCodeGenerator</font><span><font color="#0000ff">&lt;/</font></span><span><font color="#a31515">RiaClientCodeGeneratorName</font></span><span><font color="#0000ff">&gt;</font></span></font> 

      <br /></font></li>
</ol>

<p>Notice that for this generator, only the class name is required and not the fully-qualified name.  You’ll only need the fully-qualified name for our T4 <strong>CSharpClientCodeGenerator</strong>.</p>

<p><em><strong>However, there is another bug here: I tried having a line breaks between the tags and the generator name, and it failed to strip those out.  So be sure to specify this on one line.</strong></em></p>

<h3>Call to Action</h3>

<p>If you are at all interested in controlling or modifying your generated code, please grab the new <a href="http://go.microsoft.com/fwlink/?LinkId=205085" target="_blank">SP1 Beta</a> and <a href="http://go.microsoft.com/fwlink/?LinkID=205088" target="_blank">Toolkit release</a> and flip the switch over to T4.  Let us know what bugs you find and let us know what APIs you want to have for modifying the generated code.  Any scenarios you can share with us for why and how you are seeking to modify the generated code will be greatly appreciated!</p>

<p><strong>You can report issues and open discussions on our forums: </strong><a href="http://forums.silverlight.net/forums/53.aspx"><strong>http://forums.silverlight.net/forums/53.aspx</strong></a></p>

<div style="padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; float: none; padding-top: 0px" id="scid:0767317B-992E-4b12-91E0-4F059A8CECA8:f140c4fc-c37f-4147-8ce7-2bd4aee7132b" class="wlWriterEditableSmartContent">Technorati Tags: <a href="http://technorati.com/tags/RIAServices" rel="tag">RIAServices</a>,<a href="http://technorati.com/tags/T4" rel="tag">T4</a>,<a href="http://technorati.com/tags/PDC10" rel="tag">PDC10</a></div>
