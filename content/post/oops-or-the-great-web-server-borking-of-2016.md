---
date: 2016-10-09T13:48:40Z
excerpt: I broke my web server in epic fashion and have been migrating most of my
  content to static sites hosted on AWS via S3.
tags: server s3 aws
title: Oops, or, The Great Web Server Borking of 2016
---

On Thursday, while reading up on HTTP/2 and all the brilliant things it has to
offer, I logged into my trusty old web server in an attempt to upgrade
Apache and reap the benefits. This wasn't a big deal in my mind as it was
only a small dot version upgrade. So, I switched my `tmux` session to my
server admin view and ran the command:

``` bash
sudo apt-get update && sudo apt-get upgrade apache2
```

I should have realized something was wrong when I noticed `grub` was
upgrading as part of the dependency tree. I even said aloud, "I wonder why
grub is in there?" But I just shrugged it off and went back about my
business.

When I checked back on that session I noticed that `apt` finished with an
error. The Apache service was offline and my lovely little server was now
sitting up on EC2 billing away while doing jack. Again, I should have
realized something bigger was wrong, but I was mentally in my work and
only dealing with the server in a side task as I went about my day. Little
things were adding up.

- grub upgraded
- apt-get failed a basic upgrade
- Apache wasn't restarting

Since I wasn't thinking straight and couldn't be bothered to investigate
I decided to do the last thing any sane sysadmin would do, I rebooted the
box. I suspect the line of thinking went something like, "Grub upgraded,
maybe I'm running some old config still from last startup and it needs
a fresh whatever in order to whosit properly." Obviously I didn't think
things through.

``` bash
sudo reboot
```

Sadly, that would be the last command ever issued to my lovely little VM.

<amp-img width="599" height="480" layout="responsive"
src="//labs.tomasino.org/assets/images/system-failure.gif" alt="System
Failure"></amp-img>

The box didn't come back up cleanly. The ssh daemon wasn't running so
getting a peek at what went wrong was especially difficult. I ran through
the server log that AWS reveals and blamo, there it was. My boot loader
was failing and the box couldn't complete the init process.

The good news here is that I am a reasonable non-idiot most of the time
and I had a recent snapshot backup. It should just be a matter of spinning
up a new VM from that snapshot and I'd be kicking again and the only price
would be some `irssi` shortcuts and styling I'd been working on outside of
git.

Now, I've been in the server game for a while, but I've never had the
personal experience of restoring an AWS snapshot to a working EC2 instance
before. I went on a little hunt to find out the proper process. It was
surprisingly difficult to find a straight forward how-to that didn't make
me want to gouge my eyes out. Eventually I figured it out, got the
instance all configured, and attached my sparkly back-up volume. I clicked
on the magical "start instance" control and waited.

And waited.

And then probably muttered something better suited to a Trump
live-mic incident.

Miraculously, pulling up the server log revealed the exact same boot
loader issue I'd seen before. But this was my backup! This was done before
all that stuff had gone awry, right? Nope, apparently the Apache upgrade
had nothing to do with whatever I broke. It just served as the trigger
that drove me to reboot and discover I'd severely Borked My
Box<sup>TM</sup>.

I know some [extremely][] [talented][] [unix][] [dudes][] who would
probably have had the ability to pull things back together and get the box
back in working order even without a shell or init.d working. I am
constantly in awe of the magic they can work. Instead of wasting days and
weekends trying to do that myself, I decided it was a sign from the
heavens that I needed to start fresh. That server, after all, had
originally started four hosting companies ago and had been upgraded and
ported through a hodgepodge of stacks and countries. Maybe starting anew
could be a good thing?

<amp-img width="580" height="300" layout="responsive"
src="//labs.tomasino.org/assets/images/aws.png" alt="AWS"></amp-img>

## The Rebuild

I keep pretty much all my web content in git on one service or another.
I wasn't worried about losing anything with my server being a steaming
pile of #trump. I have also recently been following a trend toward
static-site-publishing. That, in particular, opened some new options.

I have one website in development that I have hosted on AWS S3, served
through CloudFront, with the domain hosted in Route53 and SSL handled by
AWS Certificate Manager. All told, I spend about $0.13 a month on hosting
fees for that property. Since this blog, [my other one][], and [many][]
[other][] [silly][] [web][] [projects][] are also static in nature,
I decided that I'd use this same configuration with all of them!

## Aftermath

My content is far cheaper, way faster, and much more stable than it ever
was before. There are still some gaps in what I had formerly running from
what's up today: namely my portfolio site and son's photo album. I had
been planning a revamp on the portfolio at some point anyway, so this may
fast-forward some things.

I'm not sure if I'll return to EC2 at all or stay exclusively in the
static web-hosting world. I'm still feeling pretty stupid about the whole
situation, but sometimes you need a major event to trigger a change.

How about the rest of you? Have you done anything so boneheaded as this
and managed to turn it into a positive? I'd love to hear some
horror-stories turned opportunities. Share below!

  [extremely]: https://www.linkedin.com/in/jjrosen
    "Josh Rosen"
  [talented]: https://www.linkedin.com/in/john-lyden-433a4
    "John Lyden"
  [unix]: https://www.linkedin.com/in/mark-sedlock-35111074
    "Mark Sedlock"
  [dudes]: https://www.linkedin.com/in/w2srh
    "Steve Huston"
  [my other one]: https://blog.tomasino.org
    "Tomasino Personal Blog"
  [many]: https://www.tomasino.org
    "My Web Presence"
  [other]: https://deprofundis.tomasino.org/
    "De Profundis Coorespondence Role Playing Game"
  [silly]: https://retreat.tomasino.org/
    "Web-based mini-retreat"
  [web]: https://map.tomasino.org/
    "World map for my novel (in development)"
  [projects]: https://obscure.tomasino.org/
    "Text Visual Obfuscation Utility (just start typing)"


<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
