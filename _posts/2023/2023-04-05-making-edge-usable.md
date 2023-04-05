---
layout: post
title: "Making Edge Usable"
date: 2023-04-05 02:05:00 -0800
comments: true
tags: ["Edge", "Settings"]
author: "Jeff Handley"
---
I've been setting up several new machines recently. As part of this, I've found myself repeatedly going through my Windows post-install setup steps. I finally decided to [write them down](https://github.com/jeffhandley/machine-setup/blob/main/windows-postinstall.md) so that I can have more consistent results.

When I got my first draft written, I joked that for this effort:

- 10% is uninstalling Windows bloatware
- 75% is making Edge usable
- 10% is fighting OneDrive sync
- The remaining 5% is the good stuff

Indeed, Edge's portion of those steps is pretty lengthy. With the approach I have though, it doesn't really take that long to get it set up the way I like. The instructions are basically to _disable all the junk_. Here's how I do it (as of April 5, 2023).

## Default Profile

On the first launch of Edge, it'll confirm the connection for the Microsoft account used to sign in to Windows. It'll ask about importing data from Chrome, which can be skipped. We can proceed to configuring settings across several categories.

In each of these categories, there are some settings listed out of order. That's because other settings will disable them, so we move them up to be able to turn them off before they get disabled.

### New Tab Page Settings

- **Layout: _Focused_ (work) or _Inspirational_ (personal)**
- **Show sponsored links: _Off_**
- **Quick links: _Off_**
- **Show greeting: _Off_**
- **Content: _Content off_**

### Sidebar Settings

- **Personalize my top sites in customize sidebar: _Off_**
- **Allow sidebar apps to show notifications: _Off_**
- **Always show sidebar: _Off_**
- **App specific settings: Discover**
    - **Automatically show related content in Discover: _Off_**
    - **Page context: _Off_**
    - **Show Discover: _Off_**

### Other Settings

All other settings that need to be updated show up under the search results for **"show"**. Some of these settings might not show up under a work profile, and some might not show up until Edge completes its first update. It's generally a good idea to check all of these settings after a notable Edge update (and add any new annoyances to the list of features to disable).

- **Use a web service to help resolve navigation errors: _Off_**
- **Suggest similar sites when a website can't be found: _Off_**
- **Save time and money with Shopping in Microsoft Edge: _Off_**
- **Show Collections and follow content creators in Microsoft Edge: _Off_**
- **Get notified when creators you follow post new content: _Off_**
- **Show suggestions to follow creators in Microsoft Edge: _Off_**
- **Show opportunities to support causes and nonprofits you care about: _Off_**
- **Get notifications of related things you can explore with Discover: _Off_**
- **Enhance images in Microsoft Edge: _Off_**
- **Suggest group names when creating a new tab group: _Off_**
- **Address Bar and Search**
    - **Show me search and site suggestions using my typed characters: _Off_**
    - **Show me suggestions from history, favorites and other data on this device using my typed characters: _Off_**
    - **Search engine used in the address bar: _DuckDuckGo_**
    - **Search on new tabs uses search box or address bar: Address _bar_**
- **Show tab actions menu: _Off_**
- **Show tab preview on hover: _On_**
- **Show Workspaces: _Off_**
- **Show favorites bar: Only on new _tabs_**
- **Home Button: _On_**
- **Forward button: Always _show_**
- **Extensions button: Never _show_**
- **Favorites, Collections, History, Downloads, Performance, Math Solver, Citations: _Off_**
- **Web capture, Share, Feedback: _Off_**
- **Show smart actions: _Off_**
- **Hover _menu_:**
    - **Show hover menu on image hover: _Off_**
    - **Show visual Search in context menu: _Off_**
- **Show mini menu when selecting text: _Off_**

Within the _All Permissions_ section:

- **Location: _Ask first_ or _Off_**, depending on the device
- **Camera: _Ask first_ or _Off_**, depending on the device
- **Microphone: _Ask first_ or _Off_**, depending on the device
- **Motion or light sensors: _Off_**
- **Notifications: _Off_**
- **Protocol handlers: _Off_**
- **MIDI devices: _Off_**
- **USB devices: _Off_**
- **Serial ports: _Off_**
- **File editing: _Off_**
- **Payment handlers: _Off_**
- **Virtual reality: _Off_**
- **Augmented reality: _Off_**

And the final set of settings:

- **Open Office files in the browser: _Off_**
- **Show downloads menu when a download starts: _On_**
- **Show a high visibility outline around the area of focus on the page: _On_**

## Secondary Profile

Use the profile menu to add another profile to Edge, adding either the work or personal profile by signing in to sync this profile's data. Once the profile is added and its initial sync completes, all of the above settings will need to be configured into the secondary profile as well.

## Profile Icons

When Edge is configured with multiple profiles, each profile gets its own Start/Taskbar icon and there's an overlay of the account's profile picture on the icon. When those profiles _have the same profile picture_, they cannot be distinguished from one another. Worse yet, Edge doesn't give access to control the profile picture that it uses without also changing the profile picture associated with the Microsoft Account. But we can sidestep its behavior and just overwrite the image files.

There are two files that need to be overwritten:

- _Edge Profile Picture.png_ (used inside Edge for the Profile picture button)
- _Edge Profile.ico_ (the Edge application icon with the profile picture overlaid on it)

These files exist within the user profile folders in `%LocalAppData%\Microsoft\Edge\User Data\`.

- The initial profile folder for the account used to sign into Windows is _Default_
- The secondary profile is _Profile 1_ (unless any mistakes were made during setup, then perhaps _Profile 2_, etc.)

If you're not sure what folder belongs to what profile, open up the `Preferences` file (it has no extension, but it's a JSON text file) from a profile folder and search for your Microsoft Account email addresses. The address for the profile will be found in the file.

You can start with the image files in that folder and then modify them to your liking. Keep copies of your modified images somewhere safe though. I've seen Edge stomp back over these files after updates. After these are modified in Edge's user data folder, launch Edge for each profile and ensure it's pinned it to the Taskbar. The icons may be stale for several launches of Edge, or perhaps even for a couple of reboots.

### Custom Search Engines

Edge does not sync configured custom search engines with its settings (even though Chrome does). But the search engines are stored in a SQLite database. You can use tools like [DB Browser for SQLite](https://sqlitebrowser.org/) to view and edit the search engines, or you can even write apps to update the database using SQL statements.

I've written about this topic before, covering the appropriate details. See [Custom Search Engines in Edge](https://jeffhandley.com/2022-10-17/custom-search-engines) for more info. Since writing that post, I've created a console app that uses the [Microsoft.Data.Sqlite.Core](https://www.nuget.org/packages/Microsoft.Data.Sqlite.Core/) package and does the following:

1. Kill any running Edge processes
1. Find the right Edge user data folder for each of my profiles
1. Connect to the SQLite database for that profile
1. Delete all existing custom search engines
1. Insert the desired custom search engines for each profile

## Summary

Edge is constantly "adding value" with new features. I generally turn off every new feature that is introduced so I can keep my browser trimmed down. I could (should?) entertain bouncing back to Firefox, but with all of the junk disabled, I quite like Edge. I really just wish it did a better job of syncing _all_ of the settings across machines.
