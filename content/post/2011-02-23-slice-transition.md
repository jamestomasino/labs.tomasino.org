---
date: 2011-02-23T00:00:00Z
excerpt: Implementing a visual transition that slices up dynamic visual content to
  flip tiles in Flash AS3.
tags: animation as3 bitmap empathy-lab transition
title: Slice Transition
---

<amp-img width="700" height="336" layout="responsive" src="//labs.tomasino.org/assets/images/slicetransition.jpg" alt="Slice Transition"></amp-img>

While working at [Empathy Lab][] I had the opportunity to help redesign
the company website. I guess that's a pretty common task, but it was
still fun. I wanted to put a new take on the old "Project Slideshow" by
throwing in an interesting dynamic transition. Hence the Slice
Transition.

The Slice is pretty simple. It grabs a Bitmap of whatever is currently
being displayed. It lays that bitmap on the top of the display, then
proceeds to chop it up into individual bits. As those bits are
blur-wiped in a cool diagonal pattern, they reveal the new content
underneath. The code got a little messy in places, but it worked. Who
knows how long Empathy Lab will use it on their site, though.

[Source & Example][]

  [Empathy Lab]: //www.empathylab.com "Empathy Lab"
  [Source & Example]: //github.com/jamestomasino/slicetransition/
    "Source & Example"
