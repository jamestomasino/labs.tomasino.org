---
date: 2011-09-02T00:00:00Z
excerpt: A How-To guide to running Google Chrome in a permanently cacheless state
  for development.
tags: browsers cache cache-busting cacheless chrome google google-chrome osx
title: Google Chrome Cacheless (OSX/Unix only)
---

I do web development. I love [Chrome][]. What I don't love is that
Chrome has [no simple way to disable the browser cache][]. It makes
using Chrome for my development tasks so frustrating that I usually end
up cracking open Firefox (and crying). It's especially bad for Flash
development because even where a SHIFT-Refresh would serve to pull new
HTML updates from the server, Flash content remains cached as always.

Yes, I know I can run my Chrome in Incognito Mode to avoid caching
things, but my Flash Builder and other apps don't automatically launch
in Incognito mode. It's all a big hassle. I don't like big hassles.
Well, I don't mind them once, but I don't like regular big hassles.

So I set out to fix it. I knew there must be some way around the
problem, and I had just enough patience to deal with that hassle once.

<amp-img width="750" height="188" layout="responsive" src="//labs.tomasino.org/assets/images/chrome-cacheless.jpg" alt="Chrome Cacheless"></amp-img>

Look what I came up with! See that, folks? No cache. Pretty awesome,
right? Well, it's a little annoying to set up, but I think it'll be
worth the trouble.

**Disclaimer:** This method only works on Unix / OSX systems. It
requires /dev/null.

Lets get started:

### **Step 1: Making Chrome Cachless**

Chrome has a handful of handy command-line parameters that can help you
customize where your cache is stored or how much space to allot. At
first, I thought I might be able to use one of these
(--disk-cache-size=0) to set the cache size to zero. That seems like the
simplest, but apparently the minimum value you can use is (1). That's
not good enough.

A little more looking revealed another parameter, seemingly less useful
at first.(--disk-cache-dir) allows you to change the folder used to hold
your cache. It took me a while to realize just how awesome that is on a
Unix architecture, though. In Unix-like systems, we have a special
file(ish) location called [/dev/null][] that acts as a kind of black
hole to data. Anything you send its way gets discarded cleanly. It's a
quick read over on Wikipedia. I'll wait.

That means that you can run Chrome without it being able to store or
retrieve cache information like so: chrome --disk-cache-dir="/dev/null/"

Of course, you can't just run an app like that on a Mac, which leads us
to part two!

### Step 2: Running Chrome from Command Line

You can't run an .app file with switches. That's because .apps are
really directories launched via [launchd][] (if I recall), and subject
to their own unique manner of wonkery (yes, that's a word now). If you
want to launch an .app from the command line, you have to look inside
the directory. From Finder you can do this by right-clicking and
choosing "Show Package Contents". In terminal, just "cd" into the
directory. Here's what it looks like inside Chrome:

<amp-img width="750" height="198" layout="responsive" src="//labs.tomasino.org/assets/images/chrome-package.jpg" alt="Chrome Package"></amp-img>

Well, almost. You'll notice your MacOS folder has only the "Google
Chrome" file, not the little darling "chrome". That's because I wrote
"chrome" myself. I'll show you that in a minute. The important thing is
that "Google Chrome" is the actual executable file you can run with
switches to launch your app. Cool, right? Give it a try. You can launch
a cacheless chrome from here.

### Step 3: Making the App Cachless

Obviously you don't want to have to run this from the command line every
time you want to launch Chrome. Some people would start blathering to
you about AppleScripts and Automators and all manner of annoying things.
Those may make it easier to launch a cachless Chrome by hand, but what I
really wanted was to make the app itself, by default, launch without
cache. It turns out it was pretty simple with a bit of shell scripting.

Remember I told you that "Google Chrome" was the file that was actually
run by the .app? We can use that to our advantage. Rename "Google
Chrome" to "chrome" (see, I told you I'd show you). Now, create a new
file called "Google Chrome" in its place. Open it up in [your favorite
text editor][]. Inside, we'll write a little shell script that will
launch our app for us using the "exec" command and our parameter. Here
it is. Just tweak your paths to work for you.

``` bash
#!/bin/sh
exec /Applications/Google\ Chrome.app/Contents/MacOS/chrome --disk-cache-dir="/dev/null/" $@
```

Save and exit your editor. Last, but certainly not least, remember to
"chmod" your new "Google Chrome" app to 755 so it'll be executable.
You're done!

Launch Chrome and witness the awesome. You may also want to delete all
your old cache files to clean things up a bit. You can use the Chrome
interface, and also pop into these two folders and wipe out their cache
contents to be thorough: ~/Library/Caches/Google/Chrome and
~/Library/Application Support/Google/Chrome.

Congratulations! I hope you enjoy your new cacheless browser. Everything
will probably get wiped out and reset when you upgrade, so beware.

  [Chrome]: //www.google.com/chrome "Chrome"
  [no simple way to disable the browser cache]: //www.google.com/support/forum/p/Chrome/thread?tid=34782d461575bcdf&hl=en
    "Disable Browser Cache in Chrome"
  [/dev/null]: //en.wikipedia.org/wiki//dev/null
    "Dev Null at Wikipedia"
  [launchd]: //en.wikipedia.org/wiki/Launchd "LaunchD"
  [your favorite text editor]: //www.vim.org/ "vim"
