---
url: "/netstream-sucks"
date: 2011-07-08T00:00:00Z
excerpt: The AS3 Netstream object is broken and inconsistent in several ways. This
  article outlines the creation of a replacement class which uniformly manages properties,
  methods, and events.
title: NetStream Sucks
tags:
  - as3
---

{{< figure src="https://labs.tomasino.org/assets/images/bridge-from-nowhere.jpg" alt="Bridge">}}

I have to give Adobe a lot of credit for all the hard work they put in
to make AS3 the great language that it is. They took an awful,
hacked-together scripting language and completely re-factored it to make
it Object Oriented (mostly) with a really well put together packages for
all sorts of cool stuff. Now that their praise has been given, I feel
less bad about complaining!

What's up with the Netstream class? Any of you who has had to write a
video player from scratch or do anything of worth with mp3s knows, some
developer at Adobe was sitting around one day slurping back his Mt. Dew
looking at that class and said, "Meh, I think I'll cut out early and go
to the beach." Half the class is properly object oriented, and the other
half is stuck in the old AS2-style callback land. You want to get the
metadata from the file you're streaming? Oh, set the client property to
an object and define a callback function on that objected called
onMetaData! WHAT!? Why not have a simple addEventListener like
everything else in your whole language?

Well, now that I've complained, I guess I better get off by butt and do
something about it, right? Fine. I introduce to you a nifty class I
affectionately call SimpleNetStream.

[SimpleNetStream.as](https://github.com/jamestomasino/tomasino/blob/master/org/tomasino/net/SimpleNetStream.as)

There's a whole package of dependencies on this class, now, but don't
worry yourself too much. For the most part you won't need to touch any
of them unless you want to really use one of those fancy events like
Metadata, DRM content, or CuePoints. Now your NetStream code will look
more like this:

``` actionscript
_ns = new SimpleNetStream (_netConnection);
_ns.addEventListener (AsyncErrorEvent.ASYNC_ERROR, onAsyncError);
_ns.addEventListener (NetStatusEvent.NET_STATUS, onNetStatus);
_ns.addEventListener (CuePointEvent.CUE_POINT, onCuePoint);
_ns.addEventListener (MetaDataEvent.META_DATA, onMetaData);
_ns.addEventListener (PlayStatusEvent.COMPLETE, onPlayComplete);
```

And so on! I wanted to give this its own post, but in the next day or
two, I'll give you all my follow-up post with the StreamingVideoPlayer
class that will make your tiny video player needs trivial!

In the meantime, enjoy SimpleNetStream. It can do everything that
NetStream does, but instead of all the callbacks, there are now real
events. I even have support for some AIR & FMS events that aren't well
documented. Next time you find yourself in need of a NetStream class,
please, do yourself a favor and use this instead.

[Download SimpleNetStream Source][]

Edit:

There's one other thing I almost forgot to tell you! All of those awful
string literals you find yourself checking in switch statements when
dealing with the NetStream object, I fixed those too. Take a look at the
[NetConstants][] class!


  [Download SimpleNetStream Source]: https://github.com/jamestomasino/tomasino/blob/master/org/tomasino/net/SimpleNetStream.as
    "Download SimpleNetStream Source"
  [NetConstants]: https://github.com/jamestomasino/tomasino/blob/master/org/tomasino/net/vo/NetConstants.as
    "NetConstants"
