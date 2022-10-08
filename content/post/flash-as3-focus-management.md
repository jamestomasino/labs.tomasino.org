---
url: "/flash-as3-focus-management"
date: 2009-12-03T00:00:00Z
excerpt: Managing tab order and focus of complex movieclips in Flash AS3.
title: Flash AS3 Focus Management
tags:
  - as3
---

I'm building a new project at work that's going to require me to be more
diligent with tabs than normal. I need to have specific groups of
controls that you can tab around, but not tab between. I started
thinking about a small, simple solution, but then I remembered all the
trouble I had on this last project. It had pop-up forms (in Flash, not
JavaScript), but when you'd tab to the end of the form, the focus would
start going to items in the background that were supposed to be
disabled. It was a really annoying bug.

So to fix my problem, I started looking up options for focus management
in AS3. I saw a few things floating around online, but most were either
Flex based, cumbersome, or not as easy to implement as I wanted. So,
being a lover of utility classes, I decided to build my own.

I wanted a very specific set of features, and listed them out:

-   Define groups of tab-able items
-   Groups can be defined by any object, not just a string name
-   Define the order of items within a group
-   Allow items to be in more than one group
-   Maintain one active group at a time
-   Quickly toggle between groups
-   Clean up nicely

Below is the class I came up with for my first draft. It uses a couple
other utility classes I've built in the past (included in the ZIP
below).

[TabManager.as](https://github.com/jamestomasino/tomasino/blob/master/org/tomasino/accessibility/TabManager.as)

All-in-all, though, I think it's a pretty solid start at a good tab
management system.

The biggest issues for implementation are:

-   Focus Rectangles are still default yellow and there's no good way to
    style them otherwise automatically
-   You must be diligent about adding every tab-able item to the
    manager. If you miss something, the TabManager won't know about it
    and it will remain in the normal tab order.

Those two bits are less than ideal, but certainly manageable.

One day I would like to tackle the optimization and add some new
features. I think it would be neat to have some auto-focus detection or
something that could toggle the tab system for you, if you wanted,
perhaps driven by a boolean. That way, if you were using one tab group
and you manually clicked with your mouse to another, it would toggle to
use the new group's tab order.

Anyone out there have any other ideas or requests that could make this
thing more usable? Either way, the files are down below. Feel free to
grab and play. Please comment if you find it useful or interesting.

*There's no license on this or any of my
utility code (anything in the com.tomasino packages). Feel free to use
it or modify it at your own discretion. If you find something useful I'd
love to know about it. Thanks.*

**UPDATE:** I've done some surgery to
the class to remove the excess dependencies and fix a few bugs. The
example project will be updated shortly as well.

**Update:** Please make sure
to get the latest version of this code from my [github
repository][].

  [github repository]: //github.com/jamestomasino/tomasino/blob/master/org/tomasino/accessibility/TabManager.as
