---
url: "/as3-synchronous-url-xml-loading"
date: 2010-04-01T00:00:00Z
excerpt: Forcing the synchronous loading of XML data in Flash AS3.
tags: adobe as3 bug service synchronous xml
title: AS3 Synchronous URL (XML) Loading
---

Yes, you read that right, synchronous. After years and years of Flash
programming, I finally came across a situation where I needed a
synchronous solution over the normal asynchronous alternative. Here's
the quick rundown...

I am building a holiday card creator where little kids can place stamps
and words and things to build cards for their friends and family. Once
they're done, they can share the cards via e-mail or Facebook. To send
the data, I'm using a [multi-part form post][] via a library written by
a real awesome [Flash dude][]. Lets call the service I'm using to send
the data, "Service #1". So far, so good.

Next, the client wanted us to add a profanity filter into the form so
keep naughty little kids from spreading their potty-mouths across the
interwebz. This filter will be called, "Service #2".

Here's where the problem came in. Now, when the users click "send", I
have to submit data to Service #2 first, wait for the asynchronous
response, then, if it is valid, submit the data to Service #1. It's not
nuclear physics or anything. And I'd know, cause I learned that stuff
[back in the day][]. Unfortunately, this is where Adobe stepped in and
ruined my party.

> SecurityError: Error #2176: Certain actions, such as those that
> display a pop-up window, may only be invoked upon user interaction,
> for example by a mouse click or button press.

Now that I am calling Service #1 in the event handler of Service #2,
it is disconnected from the original mouse click action. The result is
this really nasty Flash security error. Boo!

I was left with a nasty problem and only a few possible solutions.

1.  Get Service #1 and #2 to execute inside the mouse event handler
2.  Fake a mouse event for Service #1
3.  Combine the services (this one was totally valid and probably the
    way to go, but I didn't do it for reasons explained below)
4.  Change the internal operation of the Multi-Part URLLoader class to
    send a property other than "filetype" and thus bypass Flash Security
5.  Cry

I ended up choosing option #1 since the only challenge was getting
Service #2 to execute synchronously. It should be the easiest thing in
the world!

Surprise, surprise, getting AS3 to hit a service synchronously is
stupidly annoying. My options quickly degraded to choosing between
writing my own socket connection and handling everything manually, or
figuring out a way to do it in JavaScript, and do it with
ExternalInterface. My JavaScript chops, while not great, are better than
my experience with socket connections. Thus the following utility class
was born:

[SynchronousLoader](//github.com/jamestomasino/tomasino/blob/master/org/tomasino/net/SynchronousLoader.as)

Lets take a closer look at what I'm doing here. First, I'm utilizing
ExternalInterface to call a JavaScript function that I have hard-coded
into my class as a constant. I know that ExternalInterface performs its
calls synchronously, so that's perfect for my needs right away. Second,
I learned that the JavaScript object XMLHttpRequest can perform its load
operations synchronously or asynchronously depending on a boolean. (One
could argue that building Flash's URLLoader the same way would have made
a little more sense than forcing developers to have only one option.
Developers without options = angry developers.)

Now XMLHttpRequest is a newer class and some IE versions don't have it,
so I needed to use their weird ActiveXObject versions. You'll notice
that weird little block of try..catches doing the heavy lifting. That's
pulled almost directly from the wiki page for the class. Finally, I need
to perform my request. I pass in the URL and the parameters as, well,
parameters, then format everything and make my call.

There's a few things to note. First, without the request headers, the
service doesn't understand what type of data it's getting, so those are
a must. That took some time to figure out. Second, the "params" should
be a string of url-encoded name/value pairs, separated by ampersands. At
the end, we return back the string of the server response to our flash
method. We'll let Flash try to parse that string into a native XML
element. If it works, everyone is happy and you have your results,
synchronously. Hooray!!!

Now the caveat: XMLHttpRequest can't operate across domains. There might
be some sneaky ways around that, but it's out of scope for this
solution. If you know a good way, let me know in the comments!

Also, you'll notice I'm using my [Availability class][] in here. For
those that are unfamiliar, all it does is test to see if we are in an
environment where ExternalInterface is available. You can make that work
your own way, or grab the class from my server... whatever floats your
boat.

**Finally**, and I really mean it this
time, I promised I'd explain why I used this solution instead of just
combining the services and making one call. To put it simply, AS3 forums
pissed me off. I searched around for 15 minutes looking to see if
someone had already solved my problem for me (like you are likely doing
right now), only to find a frustrating number of post replies saying
things like, "Why are you trying to do it synchronously?! That's NEVER a
good solution. Whine-whine-whine..." Sometimes I just wish people would
answer the questions asked instead of going off on nerd-rants. Oh well!

Enjoy, comment, share, modify, whatever. Have a blast.

  [multi-part form post]: //code.google.com/p/in-spirit/wiki/MultipartURLLoader
  [Flash dude]: //inspirit.ru/
  [back in the day]: //en.wikipedia.org/wiki/Naval_Nuclear_Power_Training_Command
  [Availability class]: //github.com/jamestomasino/tomasino/blob/master/org/tomasino/external/Availability.as
