---
comments: true
date: 2017-08-17T02:12:26Z
excerpt: Overcoming the pains of video conversion for legacy PPT on Windows 7 with
  a handy-dandy bash function
tags: powerpoint video ffmpeg
title: Convert Video for Windows PPT
---

Recently we've had a number of client presentations and pitches where my team has wanted to use video in their PowerPoint presentation. I develop on a mac, and so it's not difficult for me to render something up real quick, whether through screen capturing it myself or some quick video editing work. The problem inevitably comes when I try to deliver a beautiful, high-quality, well-compressed video to the person who will be presenting it. Our account team is all on Lenovo laptops running Windows 7, which doesn't play nicely with... well, with pretty much anything.

At first I tried H264 mp4, then I tried Quicktime mov files, hoping they had a plugin. Eventually I got so fed up I was delivering crappy wmvs. A couple weeks back I decided to give it an hour or two to experiment with FFMPEG and did some codec research. It seems that old-school MPEG file formats are reasonably well supported on PCs without any special software, and with the right framerate and compression they aren't too huge.

The following is a Bash function I defined as a helper to convert any video into a format that will place nicely with Windows PPT. Once the video is imported, I still recommend running PowerPoint's "optimize" function. It's somewhere buried in the File menu. I'm not sure what it does, but it smooths out the playback on longer vids.

For this function to work, you'll need ffmpeg installed. I'm using a lot of codecs these days for various tasks, so here's the brew command I use to install ffmpeg:

```bash
brew install ffmpeg --with-libvpx --with-theora --with-libvorbis --with-fdk-aac --with-tools --with-freetype --with-libass --with-libvpx --with-x265
```

```bash
#!/usr/bin/env bash

function convert_vid_for_winppt () {
  if [ $# -eq 0 ]; then
    echo "Missing video to convert as argument."
  else
    if [ -f "$1" ] ; then
      ffmpeg -i "$1" \
      -r 25 \
      -f mpeg \
      -vcodec mpeg1video \
      -ar 48000 \
      -b:v 5000k \
      -b:a 128k \
      -acodec mp2 \
      -ar 44100 \
      -ac 1 \
      -y \
      "$(basename "${1%.*}")".mpg
    else
      echo "Video file does not exist"
    fi
  fi
}
```

Let me know if you find it useful!

<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
