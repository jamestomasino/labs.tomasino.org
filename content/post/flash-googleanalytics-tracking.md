---
url: "/flash-googleanalytics-tracking"
date: 2011-01-31T00:00:00Z
excerpt: A How-To guide for implementing Google Analytics tracking in Flash AS3.
tags:
  - analytics
  - as3
  - component
  - google
  - tracking
title: Flash Google Analytics Tracking
---

If you're anything like me, which I'm sure you are, then you really
don't like Flash components & SWCs either. They're huge, cumbersome, and
offer little to no introspection. If they don't do exactly what you want
out of the box, well, you're pretty much screwed. There's no taking them
out of the box without a decompiler, and even then, who wants to
maintain ugly decompiled code?

That's my number one reason for avoiding Google's Analytics SWC. Well,
that and the enormous file size. I mean, tracking with Google Analytics
isn't rocket science. It's not like [Omniture][] tracking or anything
(Stay tuned for the Omniture Tracking post). So why all the meat?

It comes down to completeness. Google Analytics can be extremely
powerful and do a lot of cool things, things you're never going to use.
If you're like me, which we've established you are, then you'll probably
only ever need two types of Google tracking in the life of your project:
pageviews, and event tracking. On top of that, the Google Analytics SWC
gives you the wonderful power to not have to embed their javascript in
your HTML page by bundling in all sorts of hardcoded scripting
internally. That's awesome, right? If you're building an AIR app,
probably, but I've yet to encounter an analytics team who isn't
concerned about getting pageview information for those visitors that
don't have the flash player installed, or that don't wait for your SWF
to load. Useful feature, meet my friend, the complete lack of a useful
situation.

So you're probably asking yourself, "Wait a minute. Is this going to
turn into one of those rant posts that ends with him giving me a
handy-dandy class that solves all the worlds problems?" Well, yes and
no. I'm working on my WorldPeace.as class as we speak, but for now
you'll have to settle for a tracking class and helper.

Meet my homebrew GoogleAnalytics class. She's not very complicated. At
her core is a simple external interface that calls the JavaScript
tracking methods. I've added some helper methods for simpler tracking,
but that's it. Everything I've ever needed from Google Analytics in
about 95 lines with comments. The class requires that you have the
Google Analytics script block included in your HTML page somewhere, but
you surely have that already. Also note that the tracking calls use the
asynchronous JS tracking method. What's the implication of that? If you
plan on tracking an exit link, there's a chance you'll navigate away
before the tracking proceeds. There is a JS synchronous method you can
use which coupled with the synchronous behavior of ExternalInterface
will ensure your tracking gets completed, but I find a setTimeout delay
of about 200ms does the job just as well and is all but invisible to the
end user. Take your pick, gut my class, force it to do amazing things I
never thought possible. Enjoy!

[GoogleAnalytics.as](https://github.com/jamestomasino/tomasino/blob/master/org/tomasino/tracking/google/GoogleAnalytics.as)

All that Availability talk in the previous class probably got a little
annoying. It's really there to handle testing environment problems that
I run across all the time stemming from ExternalInterface.available.
That property doesn't do the best job of telling the truth, and a lying
property is about as useful as your rapper friend as a character
witness. The following utility class patches some of the holes that
ExternalInterface leaves gaping. If you don't feel like using it, do a
find and replace in the GA class and change "private static var
\_availability:Boolean = Availability.available;" to read: "private
static var \_availability:Boolean = ExternalInterface.available;".
You'll need to fix the imports as well, but you're an actionscript
rockstar, so I don't need to cover that.

[Availability.as](https://github.com/jamestomasino/tomasino/blob/master/org/tomasino/external/Availability.as)

As always, my code's free to use and distribute. I don't need a credit
or shoutout or anything, though I always welcome comments and feedback.
Find it useful, think of a better way to do things, have a bone to pick,
feel I'm dissin' your rapper homies, the comment box is below.

  [Omniture]: https://www.omniture.com/en/
