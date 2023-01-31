---
layout: post
title: "Reusing Microsoft Teams Meeting Chats"
date: 2023-01-30 18:05:00 -0700
comments: true
tags: ["Teams", "geo-distributed"]
author: "Jeff Handley"
---
Many times, a chat begins during a Teams meeting and the conversation continues long after the meeting concludes--sometimes even for weeks or months. When recurring meetings are set up, the same meeting chat is reused for each occurrence, and this keeps the chat momentum in the right place. **But did you know that you can reuse a Teams meeting chat without a recurring meeting? Indeed, you can!**

In fact, you can even reuse a Teams meeting chat with different team members scheduling different meetings (recurring or not). This is useful for working groups/feature crews or teams where you want to centralize your written conversations while allowing organic meeting scheduling.

**TL;DR: Configure the Teams Meeting Options to optimize the meeting for reuse, and then copy the Teams Meeting content from the original meeting invite into additional meeting invites. That's it!**

These instructions are based on the premise of having already hosted a meeting (either recurring or not). But if you want to start a persistent meeting chat anew, you can just schedule a single meeting with your initial audience and then follow the instructions below.

## Step 1: Update Teams Meeting Options

This can be achieved by either starting from Outlook or Teams.

1. In Outlook, open the meeting (occurrence or series) from your calendar
    - In the ribbon, click the Meeting Options button
2. In Teams, open the meeting details from your calendar (or from the existing meeting chat)
    - Click the "Meeting options" button above the form for editing the meeting

Regardless of how you get to the Meeting Options, a browser window will open for configuring the Teams meeting. The following settings are recommended for reusing a Teams meeting for additional meeting occurrences and/or a persistent chat:

1. Announce when callers join or leave
    - Set this to No if you want to have a "water cooler" type chat that allows folks to pop into a video chat without blasting all other participants with notifications
    - Set this to Yes if you want to schedule additional occurrences of the meeting and you do want participants to get notification when the first person joins
2. Choose co-organizers
    - If you want other participants to be able to schedule occurrences of this meeting, add them as co-organizers
        - For working groups/feature crews, it can be easiest to add all participants as co-organizers
    - Each co-organizer will be able to access these Meeting Options page, which is a good way to confirm they are reusing an existing Teams meeting
    - The list of available co-organizers is the union of:
        - People directly invited to previous occurrence(s) of the meeting (a new, unsent invite will not work)
        - People indirectly invited through a distribution/security group, but who have accepted or tentatively accepted the invite
        - People added into the meeting chat
3. Allow mic for attendees
    - Set this to Yes
4. Allow camera for attendees
    - Set this to Yes
5. Who can present?
    - Set this to Everyone
6. Record automatically
    - Set this to Yes if you are organizing the meeting but might be absent/tardy yourself, and you want to ensure the meeting is recorded
    - When this is turned on, the first attendee to the meeting will trigger the recording, and the recording will be saved to their OneDrive! Yes, really. They'll need to move or copy the recording into SharePoint if you keep an archive of meeting recordings.
7. Allow meeting chat
    - Set this to Yes
    
## Step 2: Reuse the Teams meeting in a new meeting invite

Whether you organized the previous meeting(s) or not, you can reuse a meeting invite so that the new meeting will share the same meeting chat.

You might think there's some magical, hidden content included in a meeting invitation that provides the Teams meeting metadata, but there aren't. There are no hidden MIME fields, HTML comments, or other data elements that make Outlook and Teams correlate a meeting invite with an existing Teams meeting. The data is simply gleaned from the visible Teams meeting content included in the meeting description.

Therefore, in order to reuse a Teams meeting chat, you can simply copy/paste the entire Teams meeting content from the original meeting into a new meeting. While this will generally work even if you're not a meeting co-organizer, you'll likely run into issues. Adding new participants, changing the meeting name, trying to alter the Meeting Options, or doing anything else that requires organizer permissions will fail. Thus, reusing a meeting invite is best done after being configured as a co-organizer per the instructions above.

Beyond copying and pasting the Teams meeting information from the original invite, the following details have been found to be valuable tips:

1. The original meeting invite is what controls the meeting name
    - This might prompt you to rename the original meeting after it has occurred; this might confuse the participants but it works like a charm.
    - To avoid that confusion (of why people are getting an invite for a meeting in the past), you can warn them in the meeting chat that you're going to rename the meeting and re-send the invite with the express purpose of making the chat persistent/reusable.
2. Configure the Meeting Options per the instructions above as soon as you realize a previous meeting would be good to reuse
3. Set the meeting Location (on subsequent occurrences) to be "Microsoft Teams Meeting"
    - When you paste the Teams meeting content into the meeting description, that will cause Outlook and Teams to enlighten the meeting with the "Join Online" buttons, nothing else is truly needed.
    - But using "Microsoft Teams Meeting" in the location makes this meeting occurrence indistinguishable from the original, ensuring the best compatibility and recognizability.
4. Communicate to other participants that these instructions can be used to prevent a fork in the meeting chat
    - Encourage the working group/feature crew to use this practice so that even one-off meetings with a subset of the participants still keep everyone else informed
5. If you have OneNote page or another place where you track information for this meeting topic, save the Teams meeting invite content there for quick reference
