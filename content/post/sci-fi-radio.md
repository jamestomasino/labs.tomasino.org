---
date: 2023-08-15 22:57:50 +0000
title: "Sci-Fi Radio"
url: "/sci-fi-radio"
og_image: "/assets/images/sci-fi-radio-promo.jpg"
tags:
  - radio
  - audio
  - cli
  - automation
---

{{< figure src="https://labs.tomasino.org/assets/images/sci-fi-radio-promo.jpg" >}}

About three years ago I built myself a recurring internet radio show on [TildeRadio](https://tilderadio.org). I had been doing radio programs on [AnonRadio](https://anonradio.net) as well for a year or two, with live streaming interactive performances, but this time I wanted something a bit more automated. I stumbled on a collection of old radio dramas on the Internet Archive and thought that would make the perfect content.

I love those old radio plays, especially the science fiction ones. So many of their early scripts were lifted from the same magazines where the genre was cutting its teeth. One of the earliest episodes of X Minus One uses an early draft of a story that would later become part of the Martian Chronicles!

So, I gathered everything up, cleaned up the files, numbered them carefully by episode number and show, and tossed them in a folder. I had hundreds of episodes. It was perfect. In addition to X Minus One, there was also Dimension X, and MindWebs, and more. So many great stories, and all about 30 minutes long.

I made myself some promotional art (see the top of this post), and even a little teaser audio spot, calling my "show" Sci-Fi Radio.

[Listen to my radio promo spot.](https://labs.tomasino.org/assets/scifiradio-promo.mp3)

But how do I turn it into an actual radio show?

Well, that was actually quite easy. I just needed two steps:

1. Have a timer trigger a program every time I wanted the show to air

Enter the humble crontab. I don't actually remember if I needed bash and my environment for this to work or if it was for something else in my cron. Regardless, the main bit is scheduling a shell script to run on Tuesdays and Thursdays at 22:00 UTC. I also decided to pipe all output to a text file so I could check on it later in a simple file and find out if there were any issues.

```bash
SHELL=/bin/bash
BASH_ENV="/home/tomasino/.profile"
0 22 * * 2,4 /home/tomasino/scifi/stream.sh >>/home/tomasino/cron/scifi.txt 2>&1
```

2. Have a program that would play the next file in the queue and stream it to the audio server

This shell script uses liquidsoap to actually do the audio playback. It sets the output to an azuracast station and logs in with my credentials. The script feeds liquidsoap a playlist file that it creates each time the script is run. The playlist is one line long, just listing the filename of the episode to play. How is that determined? We read in the list of mp3 files in the current directory into a BASH array and just grab the first element. Easy!

Finally, once the playlist (aka, the episode) is complete, the liquidsoap disconnects and the script trap function cleans things up by removing the playlist file and moving our now-completed episode to a subfolder called "done". Easy archive as you go.

```bash
#!/usr/bin/env bash

# credentials for stream
TILDE_USER="<seeeeecret>"
TILDE_PASS="<even_more_seeeeecret>"
TILDE_PORT="<not_really_secret>"

# don't return a * if no files found in glob
shopt -s nullglob

# change to directory where script is and run everything there
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR" || exit 1

# get list of files in current directory
files=(./*.mp3)

# if there are files in the current directory, process
if [ -n "${files[*]}" ]; then

  # store reference to the 1st file in directory
  next="${files[0]}"

  # create a new playlist of only that 1 file
  printf "%s\\n" "$next" | sed 's?\./??'> "tracks.pls"

  # stream that playlist, then stop stream when it's done
  liquidsoap "output.icecast(%mp3(bitrate=192), \
    host='azuracast.tilderadio.org', \
    port=${TILDE_PORT}, \
    user=\"${TILDE_USER}\", \
    password=\"${TILDE_PASS}\", \
    mount='/', \
    fallible=true, \
    on_stop=shutdown,audio_to_stereo(playlist.once('tracks.pls')))"
fi

# trap any exit from this program for cleanup
function finish {

  # if there's a playlist, process it
  if [[ -f "tracks.pls" ]]; then

    # if we haven't created a "done" directory, do that now
    if [ ! -d "./done" ]; then
      mkdir "./done"
    fi

    # move our played file to the done folder
    mv "$next" "./done/"

    # remove playlist
    rm "tracks.pls"
  fi
}
trap finish EXIT
```

Normally I don't script in BASH itself, but in this case I was using some shopt settings and arrays, so it was handy.

Once I let the cron run everything has been smooth sailing for several years. I now have about 35 more episodes remaining in the queue before my lovely scifi radio experiment will wrap up. It's been a real joy hearing all these stories come to life every week, and we've have some really great times listening together in the #tilderadio IRC channel over on tilde.chat. Perhaps I'll come up with another theme for a similar show in the future. These little scripts sure have proven resilient!


<!--  vim: set shiftwidth=4 tabstop=4 tw=80 expandtab: -->
