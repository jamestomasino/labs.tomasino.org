---
url: "/obscure-text"
date: 2011-02-23T00:00:00Z
excerpt: Implementing a toy project to encode information using unicode characters
  with a similar visual style as English counterparts in order to fool basic net monitoring
  tools at work.
tags: as3 cryptography regex string-manipulation
title: Obscure Text
---

<amp-img width="493" height="72" layout="responsive" src="//labs.tomasino.org/assets/images/obscuretext.jpg" alt="Obscure Text"></amp-img>

I love instant messaging. I love it for keeping up with personal
contacts and as a work tool. I keep in touch with old coworkers and
friends and occasionally have need to call on their help for something
I'm doing at work. So when a friend of mine once responded in a panic to
my IMs because he was worried about his network managers scraping
through data for inappropriate things I was a little shocked. I mean,
normal computer lingo is filled with naughty-sounding terms. It's
intentional, and even an innocent conversation could land him in
trouble.

No worries, though. Even though we couldn't encrypt our IM's, I could
build a simple solution to get around keyword flagging. I called it
Obscure Text. It works on the same principle as captcha's. Humans are
good at reading things, even things that aren't really clear. By
replacing normal characters with other unicode characters that look
roughly the same, we get human readable text that will pass right
through simple searches by a machine.

Points to the lit-nerd who can name the place where I pulled my Lorem
Ipsum filler text.

[Source & Project][]


  [Source & Project]: //github.com/jamestomasino/obscuretext/
    "Source & Project"
