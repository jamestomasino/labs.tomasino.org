---
url: "/as3-duplicate-loaded-swf"
date: 2010-04-20T00:00:00Z
excerpt: A Flash AS3 class to duplicate dynamically loaded SWF content using ByteArray.
tags: as3 display-object duplicate loader swf
title: AS3 Duplicate Loaded SWF
---

A really common problem that shows up in a lot of the Flash apps I build
is the need to load external files and use them in multiple places. For
Bitmaps, that's not such a big deal. Copying the bitmap data and
generating a new bitmap is a one line task. Things get more complex when
you try to do the same thing with SWFs, though.

You can't clone a SWF because you can't clone a MovieClip in AS3. The
problem is actually due to the [Shape][] class. Unlike most of the other
core display classes, Shape does not have a clone method. With a bit of
recursion, you can duplicate most complex objects, but without Shape
things hit a brick wall.

Depending on the type of SWF I'm loading, I've found a few silly ways
around the problem. If the SWF is just a still image, you can do a
bitmap clone in much the same way as you'd handle a normal Bitmap. You
lose the ability to scale the vector information smoothly, but sometimes
that's okay. If you have more control of the source SWFs, you can build
your assets into Library symbols with some linkage information, then
instantiate as you need them. This has been my preferred method in the
past as it allows you to perform only one external load, and you can
control each instance as a fully vector, fully functional MovieClip
object. Sometimes, though, you just don't have the access and control
needed to pull off that method. That's where this other solution comes
in.

Enter DuplicateLoader, another handy utility class from yours truly.
This class loads your external SWF as a ByteArray, keeps a reference to
it, and then as you need an instance, it processes that ByteArray
through a Loader and voila, presto-chango, MovieClip! Simple right? Lets
take a look.

[DuplicateLoader](//github.com/jamestomasino/tomasino/blob/master/org/tomasino/display/DuplicateLoader.as)

There are two main segments to the class. The first is the load() method
that grabs your external content and loads it up into the ByteArray
using a URLLoader. It's pretty self-explanatory. Following that process,
we need to convert the ByteArray into a usable Flash DisplayObject. This
type of decode operation is best left to the folks at Adobe. They've
written some wonderful magic into the Loader class that lets us pass in
just about anything to a loadBytes() method and get back a useful
object.

Calling the convert() method tells the class that you'd like a new
instance of your SWF to be made available. You might be asking, "Why
can't I just use a getter and grab an instance right away?" If you were
asking that, kudos. I was asking the same thing myself. The short answer
is, Adobe sucks. The long answer is, the Loader class loadBytes() method
is asynchronous only. Stupid, right? Right.

If that's something that annoys you as much as it annoys me, please feel
free to vote for change on [the Flash Bug Tracker][]. Maybe we'll start
getting methods with the option to perform the operation synchronously
or asynchronously. A simple change like that would allow me to stop
making wordy blog posts like this.

Back to the class at hand. We were talking about the convert() method
and how it will tell the class to make a new instance available. You can
call this guy over and over and over to your heart's content. Each time
you do so, it preps a new instance and stores it. Once the instance is
ready, DuplicateLoader fires off a CHANGE event to let you know things
have been converted. Finally, you can hit the getInstance() method and
get back the handy instance you've always wanted.

Now, a few internal notes. DuplicateLoader loads all SWFs into their own
LoaderContext to avoid collisions and avoid a nasty security hole left
by loadBytes. Also, as soon as you getInstance(), the class gets rid of
its reference to that instance. The idea behind this was, when you are
done with the SWF, you should be able to just delete it yourself. If I
were maintaining a reference in my class as well, poor ol' garbage
collector would never know it was okay to delete it. Also, if there's an
error anywhere in the class, I grab the messages and dispatch them to a
nice generic ErrorEvent to simplify event handling. Too many listeners
make my head hurt.

If you'd like to see the class in action, here is a sample project
that shows it in action. As always, the class is free to use, rip apart,
call names, drunk-dial, or whatever floats your boat. I'm always happy
to hear your comments and see projects where you've found my code
useful. Enjoy!

*Special thanks to Kristine McDermott for
pointing my head in the right direction on this one. She's such a
smarty.*

*Update: Please make sure
to get the latest version of this code from my [github
repository][].*

  [Shape]: //livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/display/Shape.html
  [the Flash Bug Tracker]: //bugs.adobe.com/jira/browse/FP-3536
  [github repository]: //github.com/jamestomasino/tomasino/blob/master/org/tomasino/display/DuplicateLoader.as
