---
url: "/tools"
date: 2014-09-01T00:00:00Z
excerpt: Taking a tour of my favorite tools for productivity, programming, and all
  around awesomeness.
title: Tools
---

If you want to start a war between coders, just ask them to start describing
their tools. Text editors, programming languages, and even platforms form
entrenched camps of dispute. Even so, like the great religions of the world, we
cannot but help proselytizing about the virtues of our one true way. This post
is no different.

I've been coding a long time and I've had all that time to become embittered
and crotchety about my development environments. I won't lie, when I see
someone coding in Textmate, I judge. Sure, there's an element of jest, but I do
it all the same.

Not all tools are created equally. This is my set up. It is the *one true way*.
If you're doing something else, may locusts descend upon your backups, and may
your keyboards be sticky.

On a serious note, though: Using a good set of tools, whether hardware or
software, can make an enormous difference in a developers speed, accuracy, and
even happiness. I've come to these through a rather convoluted past, and they
work really well for me. I will happily promote them to others, but I think
it's more important that you *have* tools than that you have my tools.

If you're reading this and you're a coder and you haven't spent time really
customizing your environment, setting things in just the right way and just the
right place, and using just the right brushes; you need to stop what you're
doing and get to it. I don't care how brilliant your mind is, if you're writing
in Notepad, or TextWrangler, then you're not at your best.

The list below is a snapshot of what I'm doing now. I'll give the reasons for
each and try and highlight some of the benefits. I hope some of you will find
this interesting and useful. Perhaps you'll even find something here to add to
your own collection. If you have questions or comments, lets *Disqus*.

## Dvorak Simplified Keyboard

The [Dvorak Simplified
Keyboard](//en.wikipedia.org/wiki/Dvorak_Simplified_Keyboard) is the first
fundamental difference in my computer interface. For those unfamiliar, the
Dvorak key-map rose in response to the outdated keyboard layout at the time,
QWERTY. The history in short is this: QWERTY was designed in the age of
typewriters, when speed led to jams. The letters used most often were spaced
apart to avoid these mechanical problems. Unfortunately, while we've outgrown
these problems their patch-work solution has remained. QWERTY became the
de-facto standard, and its proponents have promulgated through the ages.

Dvorak was created a bit more scientifically, with a focus on speed and
conservation of movement. The most commonly used keys (in English) were placed
on the home row. The left hand home row contains all the vowels, for instance.
Again, unfortunately, time was not kind to Dvorak. Like Betamax, it has lost
out. Still, there are users, and quite a number of them. It is available on all
major operating systems, and for those that know it, we cannot live without it.

Not only is my typing speed much greater than it was in QWERTY, the real reason
for my adoption was more health related than designed to eek out those last few
WPM. I had been beginning to develop repetitive stress injuries in my wrists
from prolonged typing. Dvorak has all-but-cured that issue.

Now I wont lie. Switching from QWERTY to Dvorak was not easy. It took me at
least a month to make the switch, during which time I was not working and my
constant typing was not necessary. I also lost my ability to type in QWERTY as
I developed the new layout. I know some folks have managed to hold on to both,
but not me. I can type my name, common passwords, and that's about it. Anything
else requires me to hunt and peck.

## Mac/UNIX

At the heart of my operating systems is the [UNIX
philosophy](//en.wikipedia.org/wiki/Unix_philosophy), a tiny piece of
wisdom:

> Even though the UNIX system introduces a number of innovative programs and
techniques, no single program or idea makes it work well. Instead, what makes
it effective is the approach to programming, a philosophy of using the
computer. Although that philosophy can't be written down in a single sentence,
at its heart is the idea that the power of a system comes more from the
relationships among programs than from the programs themselves. Many UNIX
programs do quite trivial things in isolation, but, combined with other
programs, become general and useful tools.

In short, "do one thing, and do it well."

With a UNIX based operating system, you gain the power of composition. You no
longer just do a task, but have the power to chain them together, feeding the
output of one thing into the input of another. Before you know it, little
commands like `sed`, `awk`, `grep`, and so on become instruments of magic.

    find "${SRC}" -type f -exec grep -H 'TODO:' {} \; 2> /dev/null | grep -v -e TODO.md -e README.md -e pre-commit | awk '{for (i=1; i<=NF-1; i++) $i = $(i+1); NF-=1; print}' | sed -e "s/.*TODO:[ ${TAB}]*//" | sed -e "s/^/- /" >> $TODO 2> /dev/null

Take the line above as an example. It's one line of a script I'm using in a
pre-commit hook for my latest front-end web boilerplate. Whenever I commit code
to my repo, this spiders my source directory and finds any TODO comments I've
littered throughout the code. It parses them and returns a markdown formatted
list of them, which the script then outputs to a README file inside the
repository. With some basic use of built-in utilities I can compose a
sophisticated script that keeps and up-to-date TODO list for my active
projects. How neat is that?

Windows is getting better at this sort of thing through projects like cygwin.
Apple means nothing to me, but their decision to buy out NeXT and use it to
create OSX was fantastic. That was the game changer that saved the operating
system, and it's the only reason I use their products now. Build a consumer
friendly UI on top of the UNIX philosophy and you combine ease of use with true
power.

## dotfiles

Running OSX or Debian or Ubuntu or whatever is great, but there's a lot of
customization that can be done to make things more personal. The first step of
that is your dotfiles.

These are my [dotfiles](//github.com/jamestomasino/dotfiles).

I define my environments, common aliases, and even some helper functions. Git
settings and shortcuts and my vim (coming soon) customization. I'm very proud
of my dotfiles, from the organization and installation to my prompt.

## bin

The other half of my working OS is my collection of binfiles that I carry with
me from machine to machine.

This is my [bin](//github.com/jamestomasino/bin) repo. They tie in to my
dotfiles quite closely. Some of these are handy things I use all the time, and
others are extremely specific tasks I do for work that should never, ever be
run unless you know what you're doing. It's like a fun minefield. Enjoy!

## tmux

I work predominantly at the command line. I build my projects there, use source
control, and--as you'll see in a moment--do my development there. Sometimes
it's necessary to do more than one thing at a time. I could make a new tab, but
there are better options. The best option I've found for session management is
`tmux`. It's the inheritor of the old `screen` program and it enables you to
create sessions, windows and panes, jump around, re-size, and dance across your
system with ease.

Right now I am in tmux writing this post. I am in the second window, first
pane, of the session called "personal". The pane to my right is running `make
devserver`, a script that runs both a development webserver but also watches
the file system for changes to this blog and re-compiles it as they happen. It is
a part of Pelican, my blog platform, which I've written about in the past.

I have context to my activities, whether it be work or play. This is thanks to
tmux. Like everything else, tmux customization is key.

Here is my [tmux
configuration](//github.com/jamestomasino/dotfiles/blob/master/bash/.tmux.conf).
It's a part of my dotfiles repo.

## vim

Finally we come to the most important part of my tool box,
[vim](//www.vim.org/). If arguing developer tools can start a war, arguing
with a vim (or emacs) user must signal the end of days.

If you don't know what vim is, shame on you. Also, go read
[this](//www.vim.org/6k/features.en.txt) explanation in six kilobytes. I
couldn't possibly do a better job than that.

Suffice it to say, vim is what makes my system work. The reason I can develop
entirely in the console is because I have a fully featured IDE right there at
the command line. I have more power at my fingertips without a mouse than
pretty much anyone I've encountered in my career. Sublime Text 3 is a great
editor. PHPStorm is a great editor. And yet they're worthless next to vim (or
emacs. Seriously... not gonna fight you guys).

I code in vim. I author in vim. I take notes in vim. I've done presentations in
vim. I rebind my keys in first person shooters based on the HJKL navigation in
vim. I play [vimgolf](//vimgolf.com). I've gotten on the high score board
for it too.

The best thing I can say for vim is that it makes my desires transparent. I
want to move this block of code to another area, done. I want to mark this
particular word so I can jump back to it later, even from another file... done.
I want to reverse every line of the file (why? no idea): That's as easy as
typing `:g/^/m0`.

Vim isn't easy. It's a power tool. If you haven't bothered to learn a real
editor yet, or if you're just starting out your career, then do yourself a
favor and master vim. I'm serious, it will change your life.

You can do pretty much anything in vim out of the box, but if you want to
simplify some things or don't want to code it yourself, there's probably a
great plugin that someone has made already to help you. I'd recommend hitting
up [VimAwesome](//vimawesome.com/) to see what's popular. I'll call out a
few of my favorites below as well.

- [YouCompleteMe](//github.com/Valloric/YouCompleteMe)
- [ctrl-p](//github.com/kien/ctrlp.vim)
- [vim-airline](//github.com/bling/vim-airline) - I also use the fonts for this plugin in my tmux configuration. Double-win.
- [And many, many MOAR](//github.com/jamestomasino/dotfiles/blob/fbda7eed231c3b39aaf4a949603af9aa37cbc835/vim/.vimrc.bundles#L21-L50)

:wq
