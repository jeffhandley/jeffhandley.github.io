---
layout: post
title: "I narrated. Copilot recorded the demos."
date: 2026-11-01 19:24:00 -0800
comments: true
tags: ["Copilot", "AI", "presentations"]
author: "Jeff Handley"
---
I've been building an web application at work that has been picking up stakeholders, and we needed to showcase a few demos. The app building is always exciting; showing demos live is usually fun; but recording those demos with narration is always frustrating.

As I usually do for demo presentations, I started out by writing a complete script that included bullets for what interactions to have within the app and what to highlight on the screen. I needed to demo with fake data and simulated API call timing, and the demo time budget had no room for clumsy clicking.

With my recording delivery deadline looming, I needed to choose what approach to take for recording myself clicking through the application, recording my narration, and composing the video and audio.

1. Record my screen while clicking through the application without narration, then record myself narrating over that recording.
2. Record my narration first, and then record my screen while clicking through the application and the narration playing.
3. Attempt to record myself narrating while sharing my screen and clicking through the application.

I knew I wanted to have all six demos captured as standalone recordings, and I also wanted to capture the entire end-to-end presentation as a lightning talk. That meant whatever approach I took would have extra work of combining the demos into that full-length presentation with recorded opening and closing remarks and slides. With the application functionality ready, I was dreading the effort required for each of these options.

So I decided to try something new. 
I read the narration out loud with a timer, captured each demo's target length, and asked Copilot to create the screen recording videos.

It worked brilliantly. I provided Copilot with my full presentation script and annotated each demo with its narration timing. I got back a demo recording player harness with a demo selector, playback buttons, and flawless clicking through the application. The fake data API calls were even simulated to align the timing of my narration with disclaimer text in the application that simulated API calls and data were being used.

I then used a permutation of the approach mentioned above, where I then recorded my narration over the screen recording. But I completely skipped the error-prone step of recording myself clicking through six demos in the application. I finished the production after one take.

## Making the demos work together

My script didn't treat the six demos as completely unrelated. The data shown in one segment needed to be consistent with what appeared later. For example, if an earlier segment updates a record, a later segment should still reflect that change rather than show unrelated data. Otherwise, a viewer might notice that the story wasn't adding up and be distracted from what I was trying to explain.

Copilot created a consistent set of fake records and used Playwright to drive a real browser against an isolated local application host. The demo segments exercised the application itself, but used simulated data and API responses rather than live systems. The recording automation also checked the simulated state after actions completed, so the video wasn't just showing a success message without checking what happened.

As I refined the script, I also removed an on-screen data loading sequence and had some of the data loaded before the recording instead. That gave me more time to talk about the application rather than narrating a loading indicator.

## Giving the demos time

The six narration timings I gave Copilot were 53, 35, 56, 61, 40, and 57 seconds. Those were useful as target lengths for the recordings, but they were even more useful for pacing the interactions within each demo.

For example, one demo had a 53-second budget. Copilot spread the browser interactions across that time and left a few seconds at the end for me to talk through an additional view before it closed. That gave me room to narrate what was on screen instead of racing to keep up with the clicks.

The timing couldn't just force the demo to move on, though. The application still needed to be ready for the next action, and the work needed to finish before the recording ended. The automation waited for those conditions, and an overrun failed the take rather than hiding an unfinished operation. The timer gave the demo a predictable pace without pretending an action had completed.

## Getting from browser captures to a presentation

Playwright produced silent 1920x1080 recordings for the introduction, context, and demo sections. Copilot put those recordings into an offline browser player where I could select a section, pause, replay, and switch to full screen. Playback stopped at each section boundary, so I could record one demo on its own or move through the sections for the full presentation.

There were a couple of details to work through before I had that player. One issue in the introduction was that changing only the URL hash to switch images didn't rerun the page setup, so the previous image could remain on screen. Navigating to a fresh page fixed that.

The browser recording also produced WebM files, and I wanted MP4s for the final collection. Copilot used Edge's local H.264 recording support to convert the clips, then checked that the converted files could actually be decoded and played. It was nice to have the format I needed without sending the recordings to another service.

Once the player was ready, I started a Teams meeting with only myself, shared the browser window, and recorded my narration while playing the screen recordings. I recorded each standalone demo as its own segment. Then I recorded the full end-to-end presentation separately, playing the demos in sequence and narrating the opening and closing remarks.

I moved the meeting recordings into a SharePoint folder and created sharing links for both the folder and each video. I made the links available to employees with View & Download permission, but not Edit. To make the lengths visible in the folder, I ended the standalone filenames with `-{seconds}s` and the full recording filename with `-{minutes}m{seconds}s`.

The only error I made with this was not accounting for the lag between when Teams said recording was starting and when recording had actually begun. So each recording missed the first \~2 seconds of me speaking but that ended up being just fine.

## What if Copilot could hear my narration?

I asked Copilot whether it could listen to a recording of my narration and use the timing of individual phrases to align the demo interactions, rather than relying only on my overall timing measurements.

Copilot told me, **"Yes!"** It demonstrated the idea with three synthesized phrases: a local speech recognizer found each phrase in the audio, and a browser used those timestamps to show visual cues during playback. In one run, the cues appeared within about 25 milliseconds of the recognized timestamps.

This was a small proof of concept, not a fully narrated demo: the recognizer already knew the phrases, and the browser changed a label rather than operating the application. But it gave me evidence that phrase timings could be used to coordinate what happens on screen.

This is how I'll record my next demo presentation. I'll ask Copilot to listen to me narrate the desired presentation and let Copilot create the fully-narrated recordings with screen sharing demos it captures itself.
