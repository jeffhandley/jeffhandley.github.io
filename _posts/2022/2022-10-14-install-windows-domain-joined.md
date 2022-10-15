---
layout: post
title: "Installing Windows 11 on a Domain Joined Machine"
date: 2022-10-14 17:15:00 -0800
comments: true
author: "Jeff Handley"
---

I've recently set up or reset multiple PCs. Some of them were personal machines and others were work-issued machines. When resetting a work-issued machine while at the office, I found a specific series of steps that accomplished the end state I desired.

- The desired machine name
- Domain joined (not Azure AD joined)
- User folder matching domain username

It took a couple attempts to get the steps just right, so I captured them for future reference.

## Start the Windows 11 Install

1. Connect the machine to the corporate network
2. Boot to USB with the Windows 11 setup
3. When prompted, give the machine the name you want

When clicking Next at this point, the machine will abruptly restart.

## Set up for Work or School

1. Choose that you want to set the machine up for Work or School
2. When asked to sign in, click "Sign-in Options" and select "Domain Join"

This will leave the machine in standalone, local sign-in mode. You can domain join later, but you won't be prompted to join a domain at this point.

## Create a Temporary Local Administrator Account

1. When promoted for a username, put in something temporary. **DO NOT** use your domain username as the name will conflict with the desired user folder once you join the domain.

This account will be a local administrator, which I always delete. When deletion is planned, the password can be left blank.

## Finish the Installation

1. Choose the permitted telemetry and finish the installation steps

Once installation finishes, you'll be logged in with the local administrator account.

## Join the Domain

1. Go to Settings > System > About
2. Click on "Domain or Workgroup"
3. Join the domain using your domain credentials
4. Restart

## Make the Domain User Account an Administrator

1. Sign in with the local administrator account
2. Go to Control Panel > User Accounts > User Accounts
3. Click Manage User Accounts
4. Click 'Add...'
5. Enter the username and domain
6. Choose Administrator and add the account

No credentials will be required at this step. And note that the Windows 11 'Settings > Accounts > Other Users' screens do not allow you to add a domain account (at the time of this publication).

## Sign in with Domain Account

1. Sign out from the local administrator account
2. Choose to sign in as another user
3. Enter your domain credentials and sign in

## Remove the Temporary Local Administrator Account

1. Go to Control Panel > User Accounts > User Accounts
2. Click Manage User Accounts
3. Select the temporary local administrator account and click Remove
4. Close the windows

## Remove the Temporary Account User Folder

1. Open `C:\Users`
2. Delete the temporary user's folder (confirming administrator privileges to do so)

## Enjoy the Sweet Bliss of a Clean Install

At this point, the machine name matches what you want, the machine is properly domain joined (as opposed to being Azure AD joined), and your user folder matches your domain username.
