---
date: 2009-12-04T00:00:00Z
excerpt: A How-To guide for debug logging in Flash AS3.
tags: as3 debug logging
title: Flash AS3 Debug Logging
---

In my last post I mentioned that my TabManager class took advantage of
some of my other utility classes. The most commonly used of these are my
logging classes which make debugging my code super simple. Over the
years, these classes have grown from simple wrappers for the built in
method "trace()" to robust event-driven models, and back down to
easy-to-use, flexible implementations like the one I'm about to share
with you.

Before I get started, let me first make it very clear that this
implementation is totally ripped off from a few other sources, most
notably, the awesome Flex Logger. I don't use Flex a lot, and I honestly
don't really care for it, but there are still some very cool things it
does. I don't know how many times I've been reading through the AS3 API
when I come across a fantastic object that I want to use only to find
out that it's from the infamous "mx" package. Curses! Alas, I'll have to
just settle for recreating all Flex's cool mumbo-jumbo in pure AS3
myself.

Now, lets get talking about the logger. For those of you who don't care
about the inner workings and just want to use it, you can find the link
to the source code and sample implementation FLA at the bottom of this
post. For the rest of you (all two of you), here we go:

My logging system is built around three core components: the Log, the
Loggers, and the Consoles. Lets talk about each in turn.

The heart of the logging system is a singleton class called "Log" ([it
rolls over your neighbor's dog][]). For those who care, I used a
slightly different singleton implementation on this class than on my
[TabManager][], not for any particular reason, but just because I like
to mix it up. The roll of the Log class is to handle all of the logging
messages sent out from the various Loggers in all of your classes, do
some simple error checking, and then pass those to the active Consoles.
As a singleton, there's only ever one instance of Log, which keeps
things nice and organized.

[Log.as](//github.com/jamestomasino/tomasino/blob/master/org/tomasino/logging/Log.as)

The "Logger" class is your workhorse. This is the class that gets
instantiated in each class of your project. Each Logger gets passed
either a string name or a reference to "this" in its constructor so it
gains a particular identity. These identities are used by the various
consoles to organize all of your debug information in a logical and
pretty way that makes searching for errors a cinch. Logger has methods
like info(), warn(), and error() that allow you to send messages to
debugger with specific levels of importance. With some configuration of
the Log class, you can filter out these messages by level, string or
regular expression (how fancy!).

[Logger.as](//github.com/jamestomasino/tomasino/blob/master/org/tomasino/logging/Logger.as)

Finally there are the Consoles. The Consoles are the classes that get
the debug information and present it back to you in some way. By
default, Log is set up to have the "TraceConsole" enabled automatically.
TraceConsole is a wrapper around the AS3 trace() method that does some
pretty formatting, and automatically hides your traces in live
environments (unless you pass a particular query string parameter). The
other Console I have included is "LogBookConsole", which uses a
LocalConnection to send your debug data to [LogBook][]. All of the
Consoles implement an interface called "IConsole".

If you aren't familiar with LogBook, it's a really awesome AIR
application built by Comcast for their own debugging needs that takes
LocalConnection data, parses it, and displays it within a really pretty
DataGrid. It also has some great searching and filtering options. I
highly recommend it.

[IConsole.as](//github.com/jamestomasino/tomasino/blob/master/org/tomasino/logging/IConsole.as)

[TraceConsole.as](//github.com/jamestomasino/tomasino/blob/master/org/tomasino/logging/TraceConsole.as)

[LogBookConsole.as](//github.com/jamestomasino/tomasino/blob/master/org/tomasino/logging/LogBookConsole.as)

In a normal implementation, all that is necessary to use the basic
logging system is to import Logger into one of your classes, instantiate
and name it, and call one of its methods. This will use the standard
TraceConsole and give you some pretty output. If you want a greater
control of the system, import Log into your document class and
manipulate the filters array (takes either strings or regular
expressions), add or remove consoles from the consoles array, or change
the default log level by accessing the singleton instance. For instance:
Log.inst.consoles.push (new LogBookConsole('_org.tomasino.blog)); //
will enable a LogBook connection on the string _org.tomasino.blog.
*One small note: for some reason, LogBook
likes connections that start with an underscore.*

That's all it takes. It compiles down pretty small, too, which I'm a fan
of. Ready to try it out?

*There’s no license on this or any of my
utility code (anything in the com.tomasino packages). Feel free to use
it or modify it at your own discretion. If you find something useful I’d
love to know about it. Thanks.*

*Make sure to grab the
latest code from my [github repository][].*

  [it rolls over your neighbor's dog]: //www.youtube.com/watch?v=tky6iAHv-hs
  [TabManager]: //blog.tomasino.org/?p=608
  [LogBook]: //blog.digitalbackcountry.com/2008/03/comcasts-logbook-air-application/
  [github repository]: //github.com/jamestomasino/tomasino/tree/master/org/tomasino/logging
