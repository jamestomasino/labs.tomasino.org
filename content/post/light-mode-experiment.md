---
date: 2020-10-26 20:31:20 +0000
title: "Light Mode Experiment"
url: "/light-mode-experiment"
tags:
  - color scheme
  - theme
  - light mode
  - eye strain
---

I've seen a [number of articles](https://www.google.com/search?q=is+light+mode+or+dark+mode+better)
recently claiming that dark modes and themes are scientifically shown to
be worse than light ones. After seeing yet another example come across
Lobste.rs I decided it was time to give it a try.

I've been using a dark terminal since I can remember using a terminal.
That's at least 20 years now. Now that other apps and even desktop
environments are offering darker themes I opt into those as much as
possible. I like my interfaces dark. But this is about science, not what
I like. At least, that's what I told myself as I started this out. Here's
what happened.

## 2020-09-28

Today I started the process of multi-week light theme experiment. How best
to begin? I implemented some system level changes (dark Gnome theme to its
light counterpart) and my terminal (Kitty). Since I've been doing a lot of
work on accessibility recently I searched for a theme with a colorscheme
that met WCAG 2.1 AA guidelines for contrast. After much searching I found
[Tempus Totus](https://protesilaos.com/tempus-totus/) a "light theme for
prose or for coding in an open space." This passes the AAA guidelines!

## 2020-09-29

On my first full day of using light themes I realized that vim styling is
just a mess. A few languages worked alright, but opening up some formats
has me just turning off syntax highlighting so I can read text. This isn't
a light-mode problem, but a vim syntnax file problem. I'll keep tweaking
it.

After lots of work and tweaks I figured out how to get true-color working
on remote servers. Mosh, by-the-way, only supports true color if you
compile from source on both client and server ends. Yuck. Also, weechat
takes absolutely forever to style since there are so many color
properties.

At this point after a full day of wasting my time on color configuration
I can say everything is set up how I like it.

## 2020-10-01

Oh neat! I can change the color scheme by wearing tinted sunglasses.

## 2020-10-10

The light theme isn't jarring to me anymore, but I feel less
comfortable sitting in it. Everything feels exposed and I feel more
anxious. This is unexpected. I still don't prefer it and I had to wear my
blue-blocking glasses to avoid eye strain recently. This is meant to help
alleviate that, right? The Visine Dry Eye drops are my friend.

## 2020-10-21

My eyes hurt. A lot. Like, all the time.

## 2020-10-25

Enough is enough. If this experiment proved anything to me it's that
I really don't like light themes. Aesthetically everything feels fake and
clinical. My environments aren't relaxing and inviting. Maybe some people
like that, but I don't. I want my comfy terminal back.

But what about my performance? What about reading comprehension and eye
fatique and all that? Look, I know what the studies say. I know that it's
supposed to be more effective and my pupil less dilated and my retinas
should throw parties and information download into my brain with ease, but
none of that is true. I hate it. My eyes hurt a lot more. My eye fatigue
is much worse (and yes, my room is illuminated properly while I work).
I've had to increase the font size of my terminal twice in the last month
to keep going. I hate reading anything of length in this mode and I find
myself cheating by copying text and pasting it into a content-editable
webpage so I can use [my RSVP plugin](https://ino.is/stutter) on it.

## Conclusion

Light themes suck. They really do. Science can stuff it.

<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
