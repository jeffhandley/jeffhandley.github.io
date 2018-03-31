---
layout: post
title: "Why do I hate this code?"
date: 2016-05-02 06:02:03 -0700
comments: true
category: Archive
tags: []
redirect_from: ["http://jeffhandley.github.io/archive/2016/05/01/why-do-i-hate-this-code.aspx"]
author: 0
---
<!-- more -->
<p>
During a recent code review, I gave feedback asking for code like the following to be refactored:
</p>
<pre class="javascriptcode">
function getPreferenceLevelText(companyName, companyPreferenceLevel, segmentType) {
    var preferenceLevel;

    if (companyPreferenceLevel == PREFERENCE_LEVEL_MOST_PREFERRED) {
        preferenceLevel = getLocalizedMessage("Most preferred");
    } else if (companyPreferenceLevel == PREFERENCE_LEVEL_LESS_PREFERRED) {
        preferenceLevel = getLocalizedMessage("Less preferred");
    } else if (companyPreferenceLevel == PREFERENCE_LEVEL_PREFERRED) {
        preferenceLevel = getLocalizedMessage("Preferred");
    } else {
        return null;
    }

    if (segmentType == SEGMENT_TYPE_HOTEL) {
        return getLocalizedMessage("{0} hotel for {1}", preferenceLevel, companyName);
    } else {
        return getLocalizedMessage("{0} vendor for {1}", preferenceLevel, companyName);
    }
}

</pre>
<p>
My request was to avoid passing the segment type into the function and for the function to have hotel-specific code in it.  Instead, I wanted to see the message template passed in, like this:
</p>
<pre class="javascriptcode">
function getPreferenceLevelText(companyName, companyPreferenceLevel, messageTemplate) {
    var preferenceLevel;

    if (companyPreferenceLevel == PREFERENCE_LEVEL_MOST_PREFERRED) {
        preferenceLevel = getLocalizedMessage("Most preferred");
    } else if (companyPreferenceLevel == PREFERENCE_LEVEL_LESS_PREFERRED) {
        preferenceLevel = getLocalizedMessage("Less preferred");
    } else if (companyPreferenceLevel == PREFERENCE_LEVEL_PREFERRED) {
        preferenceLevel = getLocalizedMessage("Preferred");
    } else {
        return null;
    }

    return getLocalizedMessage(messageTemplate, preferenceLevel, companyName);
}

</pre>
<p>
This means that the callers will need to specify the message template and hotel displays will pass in the hotel-specific template whereas other segment types will pass in the "vendor" message.
</p>
<p>
The developer on the team working on this asked me why I wanted to see this change, commenting that this approach was easy and kept the calling code terse and even allowed the segment type argument to be optional.  I'll be honest, I had a hard time explaining all of the reasons why I wanted to see this change made.
</p>
<p>
Can you clearly explain the benefits of the change?
</p>


