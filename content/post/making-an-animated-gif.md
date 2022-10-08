---
date: 2019-08-25 15:48:57 +0000
title: "Making an animated gif"
url: "/making-an-animated-gif"
tags:
  - cli
  - gif
  - ffmpeg
---

In my [last post](https://labs.tomasino.org/flashforge-finder-with-cura) I wanted to lead off with
a short animation of the 3D printer in action. I had a video I shot on my
phone that looked nice, so I downloaded it and started looking at ffmpeg
options. Eventually I stitched together a few snippets from others with
some critical thinking of my own and came up with this:

```bash
#!/bin/sh

vid=vid.mp4
start_time=00:00:01
duration=3
height=320       # input height halved , can replace with pixils .
width=-2         # keeps aspect ratio . can replace with pixils .
fps=10           # frames per a second .

filters="fps=$fps,scale=$width:$height:flags=lanczos"

ffmpeg -ss $start_time                             \
       -t  $duration                               \
       -i  "$vid"                                  \
       -vf "$filters,palettegen"                   \
       -y  palette.png                             &&
ffmpeg -ss $start_time                             \
       -t  $duration                               \
       -i  "$vid"                                  \
       -i  palette.png                                \
       -lavfi "$filters [x]; [x][1:v] paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle"  \
       -y  "$vid".gif                              &&
rm palette.png
```

It got the gif pretty small, but I still ran it through another web-based
optimizer to get the size down more. I'm sure it's possible to do that
extra optimization here, but this is where good ideas run short on time,
right?


<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
