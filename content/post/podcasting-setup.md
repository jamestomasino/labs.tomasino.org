---
date: 2022-11-04 13:50:28 +0000
title: "Podcasting Setup"
url: "/podcasting-setup"
tags:
  - podcast
  - audio
  - configuration
---

It's National Novel Writing Month (NaNoWriMo) again. This year I wanted to
participate, but do something a little bit different. Last year I branched out
from the traditional novel by writing short stories. This time I've decided to
produce a podcast in real time.

## Real time podcast

{{< figure src="https://labs.tomasino.org/assets/images/podcast-setup-solarpunk.jpg" caption="The cover image of my podcast" >}}

What does that mean exactly? Each day I write an episode for the podcast, record
the script, do all the audio engineering work to edit and clean up the quality,
write show notes, format a transcript, prep the podcast files for update, and
schedule it to release the following day. I decided to push live each day at
14:00UTC so it's a convenient day time for both Europeans and Americans (sorry
Australia).

I wrote one introduction episode on the eve of November to have something ready
to go on day 1, but otherwise I am constraining myself to just writing every
single day of November. Is it a smart thing to do? Certainly not. Is it easy?
Hard no. Am I going to make it? Time will tell!

## Solarpunk

What's my podcast about? I'm glad you asked.

It's about Solarpunk, a genre and movement that tries to envision a future where
we have leveraged technology and infrastructure to become balance with our
environments and within our communities. Want to know more? [Check out the first
episode][1].

My series discusses writing prompts in that setting, covering a single writing
prompt per episode and diving into the inspirations and considerations for it.
I offer some advice and try to motivate the writers.

## The setup

This post isn't about that, though. I was asked to share my setup and process
and that's what I'm going to do.

Let's start with the hardware:

* Microphone - [MXL 770 Cardioid Condenser][2]
* Pop filter - [Aokeo Professional][3]
* Stand - [Neewer Suspension Boom][4]
* Cables - [Amazon Basics][5]
* USB interface - [Focusrite Scarlett 2i2][6]

Looks pretty fancy, doesn't it? The mic is pretty solid but picks up the room
quite well. It's wonderful if you want to sit back and play the guitar, but
unless you're in a quiet space you'll pick up the room acoustics and background
noises. Unfortunately for me, I'm not in a quiet space. My office is a nook in
the middle of our apartment hallway. I also have no sound insulation or
absorption nearby. If you are looking for a really professional sound that stuff
would probably matter to you. This reaches "good enough" quality for me, though.

### Cleaning up the Focusrite Scarlett 2i2 on Linux

The Focusrite interface is important for me to be able to use this external
hardware and have it actually work on Linux. There's a lot out there that
doesn't. That being said, recording in via the 2i2 brings in the sound in
a single channel. That means I can record in mono, but some things don't work
well with it.

So I remap the mono input to stereo in my pulseaudio config:

```bash
load-module module-remap-source master=alsa_input.usb-Focusrite_Scarlett_2i2_USB-00.analog-stereo master_channel_map=front-left,front-left channel_map=front-left,front-right
```

And while I'm in there, I also set up an echo cancellation sink:

```bash
load-module module-echo-cancel source_name=noechosource sink_name=noechosink
set-default-source noechosource
set-default-sink noechosink
```

Now that's fancy!

I've read that this stuff would be easier in Jack, but I'm really bad at the
audio configuration. I couldn't get it to work at all. Pulseaudio gets the job
done for now.

### Alternatives

So if that sounded like too much work to be worth it, it probably is. It's not
like I have the rest of the skills or environment to get studio-quality audio
anyway. I actually get pretty decent recordings out of this relatively cheap
headset with mic:

* Headset - [SENZER SG500][7]

If you're looking to duplicate my setup, I'd just do that instead.

## Scriptwriting

{{< figure src="https://labs.tomasino.org/assets/images/podcast-setup-keyboard.jpg" caption="The place my fingers go tappy-tap" >}}

So that's it for the audio hardware setup. Now I have to write what I'm going to
record. When I'm making video how-tos for Youtube/Peertube I don't really bother
with this step. I typically make a list of topics I want to cover and then just
speak freely using those as a rough guide to make may way. This podcast requires
a little more work. For one thing, the writing prompts I'm covering in my
podcast aren't my own. I'm working with a really smart group of people who came
up with them and are helping me with links and comments for my episodes.

So I need to take these resources they've given me and run with them, turning it
into about 10 minutes worth of content. Why 10 minutes? Well, it's about the
amount of time you can expect someone's undivided attention (hence the format
for TED Talks). It's also about as much as I can reasonably write, record, and
produce in a single day. Everyone wins! Besides, by keeping them short and
punchy there's really no excuse not to listen. You don't need to set aside time
for this thing. You can listen while you brush your teeth or something.

But writing needs to happen and to do that I use my handy editor [vim][8] and
a plugin called [vimwiki][9]. It lets me quickly write in markdown format and
have the full advantage of easy hyperlinking between content. I love my wiki
life so much and I need to access things in it so often when I'm not at my
computer that I actually rig it up to [display on my website][0].

There's a bit of [custom code][11] involved in that process, but mostly I'm just
keeping the wiki files in Syncthing and have those accessible on my web server.
A tiny bit of node converts markdown to HTML and I styled it to be pretty. Now
I can get at those notes anywhere.

While working in Markdown, one of my favorite features is that single newlines
in the source don't matter. The content will wrap back up into a single
paragraph when rendered to HTML. That means that I can have arbitrary line
breaks. When writing that way I like to use a thing called [Semantic
Linefeeds][12], which basically mean I hit return when I finish the clause of
a sentence. This is a great habit for prose writing which provides three key
benefits:

1. Easy version control diffs (if you're using version control)
2. Easy manipulation of sentences and clauses, especially in vim
3. Each line is broken in a natural way for reading it aloud

{{< figure src="https://labs.tomasino.org/assets/images/podcast-setup-screen.jpg" caption="Semantic linefeed script prepping for recording" >}}

Writing is fun.

## Recording

My recording setup is pretty straight forward. I'm using [Audacity][13]. There
was some drama not too long back over telemetry and I think I was supposed to
switch to a fork, but I forgot about that until I started typing this sentence,
so that's my excuse.

Actually, my first episode was recorded in a different way. I have OBS set up on
this machine and it has some vocal filtering set up to clean up my sound when
I do video recording or streaming. I thought I could save a step and just record
myself there and pull the audio out of the video. It worked, but the noise gate
in OBS clipped some of my words more than I liked. I switched to Audacity after
that first episode.

Using my lovely hardware setup above, I prep my tmux into as many panes as I can
to get the entire script on screen before I record. I don't like trying to
scroll or hit keys as I go. You can hear them, and I get lost. It's easier if
it's just all there. If you hate trees, you could even print it out.

I try my best to read like I speak, except with less "ums" and "ahs". Sometimes
I need to remind myself to breathe more, or slow down, but the process comes to
me pretty naturally. I'm not sure I have any advice here to give except Bill
Murray's advice about everything:

> The more relaxed you are, the better you are at everything: the better you are
with your loved ones, the better you are with your enemies, the better you are
at your job, the better you are with yourself.

So relax, record, have some fun, smile, use emotion. If I screw up I just take
a breath and record that line again and keep going.

## Audio Engineering

I wanted to use that headline because it sounds so fancy. Ultimately what I'm
doing at this stage is to quickly edit the audio until only the content I want
to keep remains. I will select any notable breathing noises and CTRL-L them in
Audacity to silence them. I'll trim sections where I messed up. And... yeah,
that's it. That's my entire editing process.

Now it's time to make the audio suck a little bit less.

### Correcting Voice Audio

# Correcting Voice Audio

1. Noise Reduction

Step one, I grab a sample of empty space on my timeline when I'm not saying
anything and take a noise profile from it. Then I select the entire track and
run noise reduction using that profile. That cleans up a lot.

2. Compressor

If the audio has a lot of varying levels (louds and quiets) I'll use
a compressor to bring things a bit closer together. If my voice was relatively even
then I'll skip this step.

4. Use a high pass filter (HPF)

In audacity I do this and the following two steps in a single EQ filter:

First I do a high pass filter to drop sounds below 80Hz which is below my
speaking tone.  I also set a ramp up from 80Hz to about 125Hz, right where my
change in clarity happens. If you've a very different voice from mine you might
need to adjust these numbers a bit.

4. Boost in the mid-range

The main area of speech intelligibility is in the 1kHz to 4kHz range. I don't
need to do much here, but 4dB seems to have a remarkable increase in quality.
I shape my increase like a bubble between 1 and 4 growing about 5db around
2,500Hz.

5. Add warmth to the vocal

To make the voice sound more warm and welcoming I boost a special range by 3dB
between 160Hz to 300Hz.

6. Remove sibilance

I have a pretty strong lisp, especially as I get tired, so there's only so much
I can fix with my audio skills. Still, cleaning up a bit of the hiss helps.
The best option here is to use a de-esser, but I don't have one on this system.
Instead I tweak my sounds between 5kHz and 7kHz down by 3dB. That's where the
S's live.

7. Normalize

Finally I want to ensure my track peaks just below full volume and that
everything isn't too quiet. To do that I use a Normalize filter.

### Add music

Finding music with rights you can use isn't the easiest. For this podcast I was
lucky enough to find an album on Bandcamp that's Solarpunk themed and CC
licensed. I've been picking one track from it for each episode.

My music arrangement pattern is really simple. I let the music play for about
10seconds before my voice comes in. I ramp the volume on the music back down
again as soon as my voice comes in and keep it in the background for a minute or
two. Then I fade it out to nothing slowly around the middle of the track.

Toward the end of the track I bring the second half of the song back in to that
background level. At the end of my episode I say my thanks and mention the audio
track artist and title. Just as soon as I start announcing that part I start
ramping the volume back up. It should reach full about 2-3 seconds after my last
word spoken, and then I leave the last 10 seconds of audio to play until the end
of the episode.

There's obviously a million ways to handle music arrangements, but this is
something I can do automatically when it's 3am and I'm exhausted and just want
to be done recording.

## Packaging it up

Once that's all done I save down a wav and mp3 version of the episode and prep
my podcast software with the latest episode. I'm using a self-hosted
activity-pub enabled podcasting suite called [Castapod][14]. It was pretty
simple to set up in Docker and it enables me to both create the podcast, its
episodes, and easily arrange the setup of a bunch of podcast search services
from Apple Music to Spotify to PocketCasts. It formats my RSS feeds, and also
sends out announcements into the fediverse when my episodes release. People on
the fediverse can follow that account, boost or like its messages, and reply,
creating viewable comments on the website. It's really quite cool.

I do a tiny bit more writing at this stage by creating episode notes. That's
usually a 2-3 sentence description of the episode, any links I mentioned in the
audio, and a link to the song I used.

Unfortunately while I can add hashtags to the fediverse announcement posts for
each episode, those hashtags aren't enabled when the messages reach other
servers. That means the podcast doesn't show up under the relevant hashtags on
Mastodon, for instance. I have to do a bit of boosting and mentions myself to
get around that.

I put the audio files, transcript of the episode, and show notes into a cloud
folder. The plan is to run through those transcripts to make subtitle files for
those that need the text in an alternate way. In the meantime, people can find
the full scripts on my wiki.

After November ends I hope to go back to the beginning and turn the audio
episodes into video episodes on Youtube and Peertube. I may need a little break
after this busy month, though.

Time will tell, right?

[1]: https://podcast.tomasino.org/@SolarpunkPrompts
[2]: https://www.amazon.com/gp/product/B0007NQH98
[3]: https://www.amazon.com/gp/product/B01N21H9WY
[4]: https://www.amazon.com/gp/product/B00DY1F2CS
[5]: https://www.amazon.com/gp/product/B01JNLUA5G
[6]: https://www.amazon.com/gp/product/B01H4W34WW
[7]: https://www.amazon.com/gp/product/B08FX35S7K
[8]: https://www.vim.org
[9]: https://github.com/vimwiki/vimwiki
[0]: https://wiki.tomasino.org
[11]: https://github.com/jamestomasino/wiki-web
[12]: https://rhodesmill.org/brandon/2012/one-sentence-per-line/
[13]: https://www.audacityteam.org/
[14]: https://castopod.org/

<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
