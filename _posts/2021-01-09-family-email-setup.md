---
layout: post
title: "Our Family Email Setup"
date: 2021-01-09 22:00:00 -0800
comments: true
author: "Jeff Handley"
---
Over the years, our family's technology setup has grown and evolved. I'm married and we have 2 children who have been online for several years. When they first needed email addresses, we wanted to grant them autonomy while being able to monitor what they received and coach them to identify suspicious activity. While our setup has been tweaked a few times, it's proven to durably meet our needs.

## Setup Goals

We had several goals in mind when we devised the setup. These goals include aspects of the children's email as well as other use cases.

1. Each parent retains their existing account and email address
1. Each family member gets their own catch-all inbox
    * Each family member can give out unique or disposable email addresses
    * This guards against compromised accounts since email addresses are never reused across sites
    * We also use [1Password](https://1password.com) to create strong, unique passwords for websites
    * The addresses route to the right person
1. Default catch-all routing (if not addressed to anyone specifically) sends messages to both parents
1. We can block email sent to an address that becomes compromised
1. Each child has their own account and email address to use during their childhood
1. Parents get copies of children's inbound email
1. Each child has a separate account and email address provisioned for when they reach adulthood
    * This will give them an opportunity for a "clean slate" when they become independent, if they desire
1. The setup supports using addresses on domains that we own for both incoming and outgoing email
1. No subdomains are required on the email addresses
    * Our first implementation used subdomains and it confused every human we tried to give an email address to

## Domains

We own several domain names. While the setup illustration below masks the domains and email addresses we use on them with generic names, this list represents all of the domains we own and use.

1. family.com
1. mom.com
1. mom-project1.com
1. dad.com (you might correctly guess this one is jeffhandley.com)
1. dad-project1.com
1. dad-project2.com
1. dad-project3.com
1. child1.com
1. child2.com

## Email Accounts

At the core of the setup, each family member has a single email account that they check. All email destined for them, regardless of the address used, will ultimately be delivered to their primary email account.

1. Mom uses Outlook.com; her address is represented as mom@hotmail.com
1. Dad uses Gmail; his address is represented as dad@gmail.com
1. The children also use Gmail; their addresses are represented as child1@gmail.com and child2@gmail.com

A couple examples of the forwarding set up:

1. Mom also has a Gmail account; email to it gets forwarded to mom@hotmail.com
1. Dad also has an Outlook.com account; email to it gets forwarded to dad@gmail.com

## Catch-All Addresses

The setup utilizes three different mechanisms for routing email that work in concert with one another in our setup.

1. Google Workspace email catch-all
    * Domains managed through Google Workspace support routing email to unrecognized addresses to a catch-all account
1. Gmail Filters support powerful (but ill-documented) wildcard matching
    * This allows forwarding of messages based on matching rules
1. Gmail Forwarding
    * This allows all messages received in a Gmail account to be forwarded to a single address

With these utilities, our catch-all addresses look and work like this:

1. Each family member has a user account configured on the family.com domain
    1. Email properly addressed to their actual address is delivered directly to their account
1. us@family.com is also a **User** configured within the family.com domain
    1. Email to any unrecognized address is routed to us@family.com
1. Gmail filters can identify the following patterns by using a `child1*` wildcard match in the filter
    1. **child1**@family.com
    1. **child1**-website@family.com
    1. website-**child1**@family.com
    1. website-**child1**-disposable@family.com
    1. **child1**.website@family.com
    1. website.**child1**@family.com
    1. website.**child1**.disposable@family.com
1. Gmail filters can also exclude messages already sent to an actual address by putting a `-` before the pattern
    1. `-child1*` will exclude messages that match the wildcard pattern above
    1. `-child1@family.com` will exclude messages to child1@family.com
    1. `-child1@gmail.com` will exclude messages to child1@gmail.com
1. These patterns can be combined in a single filter `to:(child1* -child1@family.com -child1@gmail.com)`, matching messages:
    * to **child1**-website@family.com (or other patterns above)
    * not to **child1@family.com**
    * not to **child1@gmail.com**

In practice, when we each give out unique or disposable addresses, we tend to use the formats:

1. **mom-website@family.com** (to be delivered only to Mom)
1. **dad-website@family.com** (to be delivered only to Dad)
1. **child1-website@family.com** (to be delivered to Child 1, Mom, and Dad)
1. **child2-website@family.com** (to be delivered to Child 2, Mom, and Dad)
1. **website@family.com** (to be delivered to Mom and Dad, but not the children)

## Setup

Below is the setup illustration that meets all of our goals for these domains and email addresses. _Click the illustration for the full size image._

<a href="/img/postimages/2021-01-09-family-email-setup/family-email-setup.png" target="_blank"><img src="/img/postimages/2021-01-09-family-email-setup/family-email-setup-1600.png" alt="Our family domain email setup" border="0" /></a>

### Domain Setup

1. Domain registration
    * Each of our domains is registered and managed through [Google Domains](https://domains.google.com)
1. The family.com domain uses [Google Workspace](https://workspace.google.com)
    * Formally known as G Suite
    * Formally known as Google Apps for Your Domain
    * We are fortunately grandfathered into a free account
1. The family.com users are configured within Google Workspace
    1. There are accounts for each family member
    1. There is also an account for us@family.com, which serves as the catch-all account
1. The family.com catch-all address is configured within Google Workspace
    1. [Admin Console](https://admin.google.com)
    1. [Apps](https://admin.google.com/u/1/ac/apps)
    1. [Google Workspace](https://admin.google.com/u/1/ac/appslist/core)
    1. Gmail
    1. Advanced Settings
    1. Catch-all address
        * _Forward the email to:_
        * `us` @family.com
1. All other domains use domain-wide email forwarding
    1. This is set up within the Google Domains Email settings
    1. `*@mom.com` and `*@mom-project1.com` forward to **mom@hotmail.com**
    1. `*@dad.com`, `*@dad-project1.com`, `*@dad-project2.com`, and `*@dad-project3.com` forward to **dad@gmail.com**

### Gmail Account Settings

1. The **dad@family.com** and **mom@family.com** accounts have Forwarding set up in the "Fowarding and POP/IMAP" settings
    * _Forward a copy of incoming mail to **dad@gmail.com** / **mom@hotmail.com** and **delete family.com copy**_
1. The **child1@family.com** and **child2@family.com** accounts have Forwarding set up in the "Forwarding and POP/IMAP" settings
    * _Forward a copy of incoming mail to **child1@gmail.com** / **child2@gmail.com** and **keep family.com copy**_
    * Messages are kept here to retain the child's messages within the family.com mail account, so that if the child wants a "clean slate" with their gmail.com account as an adult, they could delete all messages received there that were sent to their family.com address, but still have a copy of those messages in their family.com account as an archive.
1. The **us@family.com** account has filters configured in Gmail to perform the catch-all routing based on email address
    1. Settings
    1. Filters and Blocked Addresses
    1. Configure the following filters:
        1. Messages containing **"child1"** as a whole word, before or after a `-` or `.` delimiter, gets forwarded to Child 1. But exclude messages that already explicitly addressed the actual account (preventing a forwarding loop).
            * `to:(child1* -child1@family.com -child1@gmail.com)`
            * _Skip Inbox_
            * _Mark as read_
            * _Apply label:_ `FW: Child1` (for debugging of the setup)
            * _Forward to:_ **child1@family.com**
        1. Messages containing **"child2"** as a whole word, before or after a `-` or `.` delimiter, gets forwarded to Child 2. But exclude messages that already explicitly addressed the actual account (preventing a forwarding loop).
            * `to:(child2* -child2@family.com -child2@gmail.com)`
            * _Skip Inbox_
            * _Mark as read_
            * _Apply label:_ `FW: Child2` (for debugging of the setup)
            * _Forward to:_ **child2@family.com**
        1. Messages _not_ intended for Dad get forwarded to Mom
            * `to:(-dad*)`
            * _Skip Inbox_
            * _Mark as read_
            * _Apply label:_ `FW: Mom`
            * _Forward to:_ **mom@hotmail.com**
            * *Note: This could be set up as `to:(mom*)` to provide Mom with a catch-all address, but by using the negation rule of email **not** addressed to Dad, this has the effect of also copying Mom on messages sent to Child 1, Child 2, or any unrecognized address*
        1. Messages _not_ intended for Mom get forwarded to Dad
            * `to:(-mom*)`
            * _Skip Inbox_
            * _Mark as read_
            * _Apply label:_ `FW: Dad`
            * _Forward to:_ **dad@gmail.com**
1. The **child1@gmail.com** and **child2@gmail.com** accounts have Forwarding set up in the "Forwarding and POP/IMAP" settings
    * _Forward a copy of incoming mail to **parents@family.com** and **keep Gmail's copy in the Inbox**_
    * This results in the messages getting routed to the **us@family.com** catch-all account, but through a specific address (for debugging of the setup)
    * The filters set up in **us@family.com** will then forward the messages to both Mom and Dad
    * Messages that arrived in Gmail after having originally been sent to **child1@family.com** or **child1-website@family.com** will also get forwarded to the parents at this point; the filters in **us@family.com** will prevent re-forwarding **child1-website@family.com** emails to the **child1@gmail.com** account again. Without that exclusion set up, a forwarding loop would occur.
1. The **mom@gmail.com** account has Forwarding set up in the "Forwarding and POP/IMAP" settings
    * _Forward a copy of incoming mail to **mom@hotmail.com** and **delete Gmail's copy**_
1. The **dad@gmail.com** account is set up to allow mail to be sent using alternate addresses
    * _Send mail as: **dad@dad.com** **(default)**_
    * _Send mail as: **dad@family.com**_
    * _Reply from the same address the message was sent to_

### Google Account Settings

Separate from the Gmail settings, a couple of finishing touches are added to the Google Account settings.

1. [Manage your Google Account](https://myaccount.google.com/)
1. [Personal info](https://myaccount.google.com/personal-info)
1. [Contact info / Email](https://myaccount.google.com/email)
1. [Alternate emails](https://myaccount.google.com/alternateemail)
1. For Dad, **dad@dad.com** is added
1. For Mom, **mom@mom.com** is added

### Outlook.com Account Settings

1. The **dad@outlook.com** account has Forwarding set up in Mail / Forwarding
    * Check _Enable forwarding_
    * _Forward my email to: **dad@gmail.com**_
    * Uncheck _Keep a copy of forwarded messages_

## Over-Engineered?

This setup has been in place for several years and it's been working well, meeting all of the goals we set out to accomplish. When I embarked upon documenting this setup, it occurred to me that this might all be over-engineered; I'm not sure though.

The hardest part was the catch-all behavior, including each family member being able to use unique/disposable addresses on the same domain. If we each used our own domains instead of sharing family.com, that would have been a lot more straightforward for sure. But once I figured out how to use the wildcard and exclusion patterns in Gmail filters, it came together nicely. I only introduced an email forwarding loop thrice while configuring it.

Regardless, I'm glad to have documented it so that as the children approach adulthood, I can be confident that reconfiguring for their independence will go smoothly.