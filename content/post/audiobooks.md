---
date: 2023-11-13 18:23:03 +0000
title: "Audiobooks"
url: "/audiobooks"
tags:
  - cli
  - audiobooks
---

I'm doing some work that requires the use of headphones but I wanted to listen
to my audiobook at the same time. These headphones are noise canceling, so
playing the book on my phone wasn't going to work well.

I have all my audiobooks in a share drive, so I figured I should make a quick
browser to select one and play it. I knew `mpv` had support for saving the
position of playback so it could resume, so a quick script stitched it all
together.

``` bash
#!/bin/sh

book=$(find "${AUDIOBOOKS:-${HOME}/audiobooks/}" -maxdepth 1 -type d -print | fzf --multi --select-1 --exit-0)

if [ -n "${book}" ]; then
    mpv --save-position-on-quit --no-audio-display "${book}"
fi
```

If you set `AUDIOBOOKS` as an env var pointing to your own book collection, then
you can run this script and it will browse the list with FZF. It works on books
that are just one mp3 or those that are a whole directory full.

While it's running you can use keyboard shortcuts in that terminal window to
change the volume or skip around. Or, if you want to send full-featured command
instructions, you can enable mpv's socket and pass commands that way.

To enable the socket server, edit `~/.config/mpv/mpv.conf`:

```bash
# Enable the IPC support to control mpv from the command-line.
input-ipc-server=~~/socket
```

Then you can send echo commands through to that socket and it'll update your
playback session. Here's a little `mpv-cmd` helper script I use:

```bash
#!/bin/sh

if [ -z "$*" ]; then
    echo "Missing command param. See https://mpv.io/manual/master/#list-of-input-commands"
else
    echo "$*" | socat - "$XDG_CONFIG_HOME/mpv/socket"
fi

```

And then you can tell your audiobook to jump to a specific time like so:

```bash
mpv-cmd set time-pos 5:21:43
```

Fun!

<!--  vim: set shiftwidth=4 tabstop=4 tw=80 expandtab: -->
