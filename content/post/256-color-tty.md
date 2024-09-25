---
date: 2024-09-25 13:32:41 +0000
title: "256 Color TTY"
url: "/256-color-tty"
og_image: "/assets/images/kmscon.png"
tags:
  - cli
---

It's pretty well known that I do most of my daily work inside a terminal. My
text editor of choice is [vim](https://vim.org). I program, take notes, write
stories, blog, and do pretty much everything text related in there. Most of my
social networking and chatting is done via [weechat](https://weechat.org) and
plugins. I browse a lot of fun content on gopher and gemini using tools like
[amfora](https://github.com/makew0rld/amfora) or
[phetch](https://github.com/xvxx/phetch). Even when I browse the web, lynx or
links or w3m get pulled out before Firefox. With tildes in reach I can access
games and forums in a flash, all within my world of text.

Now my main PC and laptop require me to have a bit more than that for my job.
Zoom calls on the command line will have to wait for another day. But I have
some other machines lying around. I have a $99 pinebook sitting in my storage
right now that's too underpowered for almost anything serious. But it's plenty
powerful for a bit of command line action.

Now most linux distributions have a server version that doesn't install
a graphical user interface. They're meant to be out there on servers or virtual
servers and be accessed via things like SSH. That's great if you're remotely
connecting to them, but what about if you want that experience on a local box?
Opening the lid on one will place you into the command line experience, but not
via a terminal emulator. It will give you a TTY connection.

Now this is where many forum posts go awry. Someone like me will post a question
about using a CLI based distro locally and the answers will suggest doing things
in the terminal emulator. The most basic of these questions, and the one I've
been hunting after for a while is, "How can I get my terminal to use more than
8 colors?"

We have a wealth of Truecolor terminal emulators available now, from Kitty to
Alacritty, Konsole, or urxvt. Having 16 million colors is amazing, but I don't
need to go quite that far. I just want to get to 256. The big problem there is
putting that logic into a TTY is a bit counter intuitive. The TTY is the
machine-safe fallback when nothing else is working. It needs to support the
lowest common denominator (or that's the argument I see online, anyway). So even
if you can signal 256 colors to it, they get converted down.

{{< figure src="/assets/images/kmscon-fail.png" title="TTY converting down to 8 colors" alt="TTY converting down to 8 colors" >}}

So what's the option? Do I install a whole gui just to open a terminal emulator?
Some of those are fairly lightweight, like i3wm, but it also means a gui is
available for other apps to target and use. I don't want things popping up in
a surprise. I just want my text, thankyouverymuch. I haven't been having much
luck on this hunt until last night when I ran across
[KMSCON](https://wiki.archlinux.org/title/KMSCON).

This is a project designed to provide a replacement TTY terminal for use on
virtual consoles. What are those? Well, even on systems with a gui running, you
can usually access additional virtual console logins by hitting some combination
of ctrl-alt and the F1-F6 keys. Are you on linux now and unaware of this? Give
it a try. Try ctrl-alt-F2! You can get back to where you were with one of the
other F-keys (probably F1). Fun, right?

So with KMSCON installed I can set up F2-F6 to use that and leave F1 as a plain
TTY fallback (in case of emergency). And suddenly we have color!

{{< figure src="/assets/images/kmscon.png" title="KMSCON running 256 colors in my TTY"alt="KMSCON running 256 colors in my TTY" >}}

{{< figure src="/assets/images/kmscon-vim.png" title="vim with apprentice theme"alt="vim with apprentice theme" >}}

My mission isn't quite complete. I need to work on loading better fonts with
unicode support. Also KMSCON has an open issue to [support
Truecolor](https://github.com/dvdhrm/kmscon/issues/111). Maybe one day it'll be
as beautiful as my terminal emulators!

<!--  vim: set shiftwidth=4 tabstop=4 tw=80 expandtab: -->
