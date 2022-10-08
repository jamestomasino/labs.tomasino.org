---
url: "/trace-replacer"
date: 2011-04-27T00:00:00Z
excerpt: An AS3 class to wrap the Trace functionality with more context, formatting,
  and flexibility.
title: Trace Replacer
tags:
  - as3
---

In AS3, the most basic debugging tool is the trace() statement. You
output some text to the console. That's all. Nothing fancy. It's all
great, and we all love it, right? But you know what's annoying? When you
get a trace that says "no" or "foo" while running your gigantic app. You
have no idea where it came from, what it means, or how to fix it. This
is one of the reasons I use [grep][], or a gui-grep, so often. It's
really annoying to track down where your output is coming from!

But what if it wasn't? What if your traces had nice pretty labels with
class names & line numbers, like errors in the Flash Builder debugger?
That'd be nice, right, but you hate having to label every trace, and
passing parameters into every one gets tedious too. Why can't it be
totally automatic?

TADA!!!

[Debug.as](https://github.com/jamestomasino/tomasino/blob/master/org/tomasino/utils/Debug.as)

The new and improved Debug class is just what you need. Import it into
your project, and it's a one-line solution to all the world's problems
(near enough). All you need to do to use it is write Debug.out('blah
blah blah'); That's all! No labels, extra parameters, or anything. You
can copy it right here, or grab the latest version from [my github
repository][].

That's the basics, and if you have no interest in how it works, feel
free to stop reading now.

In AS1 & AS2, functions' "arguments" object had a property called
"caller" that would let you know where the call originated. AS3 did away
with that in an effort to make code more in-line with object oriented
principles or something. This change was mostly fine, and I'd say they
were right to get people away from thinking backwards like that. Of
course, then there's the few edge cases where you actually need that
functionality for a non-stupid reason. To work around the hole the
"caller" removal left, we have to use a bit of a hack.

The Error class generates a very sophisticated text log of the stack
that led up to its generation. This "stack trace" is what gets outputted
to the console automatically when you hit a real error. It also happens
to include information like the class names & line numbers of calls. We
can parse that info to make pretty traces. YAY!

As a side note, the Flash IDE & Flash Plugin have different output
styles for their stack traces, so this class has two different methods
to parse them. Neither one is very fast, so when you're ready to hit a
production build, you probably want to toggle the "enabled" property to
false to turn off debugging.

Finally, I'm obviously not the first person to put this into use. If
you're looking for something more robust or more information, here's
some links for you:

[My Flash AS3 Logger][] - my much more robust debugging solution.
[Tracer.as][] - a full featured trace() replacement that does what this
class does and a whole lot more.
[Parsing Stack Traces in AS3][] - A very thorough parser that does a
much faster job than mine by using regular expressions.

  [grep]: //en.wikipedia.org/wiki/Grep
  [my github repository]: //github.com/jamestomasino/tomasino/blob/master/org/tomasino/utils/Debug.as
  [My Flash AS3 Logger]: //labs.tomasino.org/flash-as3-debug-logging/
  [Tracer.as]: //web.archive.org/web/20101012180525///blog.unionstudio.net/2010/04/tracer-as-will-turn-you-into-an-error-crushing-debugging-juggernaut/
  [Parsing Stack Traces in AS3]: //www.actionscript-flash-guru.com/blog/18-parse-file-package-function-name-from-stack-trace-in-actionscript-as3
