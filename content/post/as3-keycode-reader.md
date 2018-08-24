---
url: "/as3-keycode-reader"
date: 2011-03-01T00:00:00Z
excerpt: A basic implementation of a keycode reader in Flash AS3 for fun and profit.
tags: as3 charcode cheat-codes io-capture keyboard keycode konami nintendo
title: AS3 KeyCode Reader
---

<img width="600" height="804" layout="responsive" src="//labs.tomasino.org/assets/images/keycode.jpg" alt="up up down down left right left right b a start"></img>

[Up Up Down Down Left Right Left Right B A Start][]

It's one of the most well known bits of KeyCode gibberish out there and
has spawned all sorts of web fun. The Konami Code was my first
experience with a cheat code when I learned it for the 1988 game
[Contra][] on [NES][]. Facebook made some noise when they implemented a
hidden Konami code Easter Egg on their site back in 2009. It's a bit of
nostalgic fun, really.

My first encounter with KeyCode reading was thanks to Guy Wyatt down at
Moxie Interactive back in 2007 or 2008 when he showed me an
implementation he'd done for a web-game that he wanted to add cheat
codes into. I've written a few versions of my own since then, but this
latest is the simplest and most flexible.

[KeyCodeReader.as](//github.com/jamestomasino/tomasino/blob/master/org/tomasino/io/KeyCodeReader.as)

My KeyCodeReader class is the workhorse here. When you add it to an
application, you create an instance and pass it a reference to the
stage. This is necessary because keycode capturing has to happen via a
stage listener. Once you've instantiated the class, you can start adding
matching codes. The codes are arrays of keycode values. These are not
[ASCII][] values, necessarily. They're determined by the physical key on
the keyboard. That can have some strange effects for international
users, or users like yours truly who enjoy the benefits of the [Dvorak
keymap][].

Now coming up with these codes might seem like a difficult task, but as
you'll see in my example app, it's really quite easy. Other
implementations I've built have used ASCII methods and actual strings,
which is honestly easier to develop, but extremely limited. You can't
map the arrow keys with ASCII, for instance. That's just a shame.

This class doesn't do anything fancy beyond allowing you to define codes
and test to see if they've been matched, but it does give you some
helpful tweaking tools. By default the user has 300 milliseconds between
character presses to enter the code. If you have a slow-typing audience,
this can be changed in the constructor. Also, it's important to note
that this will not match overlapping codes. For instance, if you define
ABCD and ABCDE both as matchable codes, only ABCDE will be tested. Since
ABCD is just an unfinished version of ABCDE, it is basically overwritten
by the more "full" code. There were several ways I could have handled
that issue, and this wasn't necessarily "right", but that's what happens
to lab projects!

Finally, when a code is matched, it will dispatch a KeyCodeEvent with a
key property that holds the matched code array. You can use this array
for any fancy switching to figure out what you want to do next. Here's
the Event class:

[KeyCodeEvent](//github.com/jamestomasino/tomasino/blob/master/org/tomasino/events/KeyCodeEvent.as)

In the linked folder I've created a sample project with an implemented
KeyCodeReader class and a couple simple match codes. It is also a
helpful tool for figuring out what the codes for each key are.

Finally, it's worth noting several things severely lacking in my
implementation. You know they're serious flaws since they even got
comments in the code.

1.  I haven't added any special support for held keys, like Control, Alt
    or Shift. Right now they're processed just like any other key
    presses in a sequence. It's really not that much work to fix the
    omission, but I've yet to have a need for it, so there you go.
2.  I haven't added the method for removing a match code. It's stubbed
    out, but again, I've never had the need.
3.  There's almost zero error handling in here. If you add a match code
    that's not integer based, or any number of other simple things, the
    class will totally blow up. So, um, enjoy that!

[Source & Example][]

By the way, in case you want to implement the Konami Code yourself,
here's the character array: [38, 38, 40, 40, 37, 39, 37, 39, 66, 65, 13]

  [Up Up Down Down Left Right Left Right B A Start]: //en.wikipedia.org/wiki/Konami_Code
    "Konami Code"
  [Contra]: //en.wikipedia.org/wiki/Contra_(video_game) "Contra"
  [NES]: //en.wikipedia.org/wiki/Nintendo_Entertainment_System
    "NES"
  [ASCII]: //en.wikipedia.org/wiki/ASCII "ASCII"
  [Dvorak keymap]: //en.wikipedia.org/wiki/Dvorak_Simplified_Keyboard
    "Dvorak Simplified Keyboard"
  [Source & Example]: //github.com/jamestomasino/keycodereader/
    "Source & Example"
