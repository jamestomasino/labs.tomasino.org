---
comments: true
date: 2018-01-15T15:57:28Z
excerpt: Using alt text in horrible ways it should never be used
tags: alt-text accessibility ascii
title: Ascii Art Alt Text
---

I had a silly thought this weekend.

>"I wonder if I could serve the alt text of an image to be ascii art OF that
>image. Wouldn't that be amazing?"

Well, I don't know about amazing, but it works. It wasn't as obvious as
I thought at first, though.

You can style alt text, that was nothing new. I've been doing it in HTML emails
for years. I thought I could style the text to be `white-space: pre` formatted
and maybe size down the font a bit and that would do it. And I was mostly
right! Unfortunately, that leaves that obnoxious "broken image" icon in the top
left corner, which throws off the ascii art. Lame.

I dug around for a while trying to figure out how to get rid of the
auto-generated broken image icon and instead found something really cool. As
a part of how the internals of web rendering work, img tags are kinda replaced
in the DOM once they load. That means that pseudo elements don't really work on
them because they don't exist once they load. But pseudo elements DO exist if
the image fails to load. So, with a bit of creativity, I hid the contents of
the alt text once the image fails to load and use a pseudo element and
a calculated contents of the alt text itself to apply a styled version of the
alt text over top of the image box. My over-the-top version has a white
background and is z-indexed above that annoying broken-image bug, smothering it
to smithereens!

Have a look:

<amp-iframe width="500"
  title="Ascii-Art Alt Text"
  height="265"
  layout="responsive"
  sandbox="allow-scripts allow-same-origin allow-popups"
  allowfullscreen
  frameborder="0"
  src="https://codepen.io/jamestomasino/embed/gojmvL/?height=265&theme-id=0&default-tab=html,result&embed-version=2">
  </amp-iframe>

So obviously this is 100% against all best practices regarding accessibility.
Screen readers will murder you for trying it, and you will immediately descend
to the 5th circle of hell (wrath and sullenness).

But... what if?

Yeah, I had another idea I'm exploring. Email!

Emails have this cool thing where the HTML version isn't the only version you
send. You send plain text as well. I'm going to test out sending an email with
plain text appropriate for a screen reader and my Frankenstein ('s monster)
version as HTML. I'll test it out with some screen readers to see how it does,
but my hope is that the HTML version will degrade visually nicely for users
that have blocked remote images while the plain text will still service folks
that need it.

Anyone have more experience in this area? Is that something that will work?
Please hold the pitchforks!

<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
