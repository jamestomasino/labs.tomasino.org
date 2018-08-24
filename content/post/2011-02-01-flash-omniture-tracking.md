---
date: 2011-02-01T00:00:00Z
excerpt: A How-To guide for implementing Omniture tracking in Flash AS3.
tags: analytics as3 component omniture tracking
title: Flash Omniture Tracking
---

Ok, bear with me. I mentioned in the last post that Google Analytics
was not nearly as complex as Omniture Tracking in Flash. Well, it's time
to put my... um... code... where my mouth is? Does that sentence even
make sense? Anyway, this post is quite long, and I'm going to explain
things really thoroughly because the documentation out there is
difficult to find, misleading, and generally not helpful to developers.
So consider this a complete lesson.

*If you just want to download
everything and figure it out on your own, the download link can be found
below. Please note that due to Omniture licensing, I cannot include a
copy of the required Actionsource.swc file. Instructions to find it can
be found in the OmnitureTracker class.*

**Step 1: The OmnitureTracker -**
Omniture tracking is extremely powerful and requires a lot of initial
set up. Most of this will be done on the business end and not involve
the lowly developer at all until it comes time to implement. You'll want
to request as much information as possible about what to track in what
style, when and where. I can't stress this enough. If there's anything
that's consistently a problem with Omniture implementations in Flash
it's that you are never given all the information you need. Below I'll
give you a few pointers about what to expect at a minimum.

From a code implementation standpoint, know that we're going to handle
all of your tracking needs by piggybacking on the Flash event model.
This isn't exactly perfect, but it does a great job 95% of the time.
Since Flash events only bubble up through the display list, you'll need
to make sure that they get dispatched by something in the display, or
manually force your event to reach the OmnitureTracker. Otherwise, your
data will be lost in the ether.

The OmnitureTracker class, while not a singleton, will probably only
need a single instance in your application. I recommend instantiating it
at a high level. As soon as possible, add it to the stage. It has no
visual elements, but it extends the Sprite class. By adding it to the
stage it will auto-detect the display list and set up all the necessary
event listeners for you. At this point the class is technically active
and monitoring for tracking events, but before it can process them,
we'll need to set up the site-wide settings.

[OmnitureTracker.as](//github.com/jamestomasino/tomasino/blob/master/org/tomasino/tracking/omniture/OmnitureTracker.as)

**Step 2: OmnitureSettings -**
As soon as you've instantiated the OmnitureTracker, a settings property
becomes available in that instance. This settings property is itself an
instance of the OmnitureSettings class (below). This class sets up and
monitors site-level information necessary to track your data. Things
like "account", "dc", "trackingServer", "visitorNamespace", and
"movieID" are key values here. You may not fill in everything, but you
should have quite a bit of information to configure. This is one of the
first red flags in implementation as well. If your project manager /
tracking guru / whomever has not supplied you with these values, get on
them quick. Nothing works without this stuff.

You should only have to fill in the information once. Usually I set all
these properties as soon as I instantiate OmnitureTracker and just
before I add it to the display list. This way, if something needs
tracked right away, you'll be fully configured and ready to go ahead.

[OmnitureSettings.as](//github.com/jamestomasino/tomasino/blob/master/org/tomasino/tracking/omniture/OmnitureSettings.as)

**Step 3: OmnitureEvent -**
Now we're ready to track things. Any tracking you need to do, whether
an eVar, prop, product or heir value, they will all happen with an
OmnitureEvent (below). This class extends Event and is set to bubble by
default, so as long as you dispatch it from somewhere in the display
list, it will reach the tracker. If you are tracking something
non-visual, like the loading of an RPC, you'll need to find an
alternative way to reach the OmnitureTracker. To make this easier,
OmnitureTracker instances have a public method called track() that take
an OmnitureEvent as a parameter. See how helpful I am? You're welcome.

[OmnitureEvent.as](//github.com/jamestomasino/tomasino/blob/master/org/tomasino/tracking/omniture/OmnitureEvent.as)

**Step 4: OmnitureTrackData -**
So you know how to send out tracking data, but how do you actually tell
the application what you need to track? In every OmnitureEvent is a
public data property which is itself an instance of the
OmnitureTrackData class. This class is really just a big honkin' value
object. Need to track a Page Name, then put it in the pageName property!

Now, I alluded to Omniture documentation being unhelpful earlier and
made a suggestion that I'd try to be of some help. So let me take this
brief opportunity to explain some of the common properties you'll be
tracking and why they're weird.

-   [eVar] - These are extremely strange little guys. The best way I can
    explain them is to say that they are like buckets you are opening to
    collect event data. Sometimes your Omniture representative will use
    them in the same way as props, which are really just simple
    counters. eVars, though, are much more powerful. If you track 2
    eVars and an event together, that event will register as being
    tracked INSIDE those two eVars. Now, on the reporting end you can
    treat them just like counters if you want, but it's a huge waste of
    their potential. These, more than anything else in Omniture
    tracking, are vastly misunderstood by everyone from the good folks
    at Omniture in Salt Lake City, down to your analytics team. It would
    really behoove you all to have a nice long chat about them before
    you set up your reporting structure. Of course, you're a lowly
    developer, right? So who's going to listen to you.
-   [props] - Sometimes called "sprops" or "s.props" because of their
    implementation in javascript. These are glorified counters. Simple,
    useful.
-   [events] - These are like counters within counters when used right.
    See my comment on eVars above. You're probably wasting them if
    you're measuring them globally across all evars. Makes you feel
    good, right?
-   [products] - These are complex data types of their own that get
    serialized in the tracker. See the next step for more info. Not all
    applications use products at all.

Finally, please note the special type property. While it is a string, it
really should only have one of 3 values, given as the TYPE_ constants
in the class. If you're tracking an exit link, use TYPE_EXIT_LINK. If
the user is downloading something, say a PDF, use TYPE_FILE_DOWNLOAD.
For anything else, use TYPE_CUSTOM_LINK. The class defaults to this,
so don't trouble yourself unless you need a change. If you do use the
TYPE_EXIT_LINK value, linkName, linkURL, and linkWindow, will handle
the navigation for you automagically after the tracking is complete.
Handy!

[OmnitureTrackData.as](//github.com/jamestomasino/tomasino/blob/master/org/tomasino/tracking/omniture/OmnitureTrackData.as)

**Step 5: OmnitureProduct -**
The OmnitureProduct class is a little tricky. To be honest, I haven't
used it a whole lot. I took most of the following information from other
Omniture documentation. So far, I've had no complaints about the data,
so I can only assume it works properly. Sad as it is, we developers
rarely get to even see the data on the reporting side. Would this
process be easier if that weren't the case, you betcha.

[OmnitureProduct.as](//github.com/jamestomasino/tomasino/blob/master/org/tomasino/tracking/omniture/OmnitureProduct.as)

A final word or two: When you are doing your development and testing, be
sure to use a unique channel name at the very least. If possible, have a
testing account set up where you can verify everything long before the
live environment. This is no simple Google Analytics system here, and
you are bound to have hiccups along the way. Good luck, and try to keep
a cool head.

While I'd love to give you everything you need to implement this code
right away, it does rely on Omniture's Actionsource.swc file being
included in your project. In the rare case that you have access to it,
you can find this by going to the Admin Console in SiteCatalyst. You
will find the file under the Code Manager. If you don't have access,
just request the file up the chain of command. Once that's included in
your project, this code will make it 100x easier to work with.

As always, this code is free to use and modify with no attribution or
voodoo required. If you find it useful, I'd love to hear about it. Find
a bug, come up with a new idea, want to bake me cookies, then please
leave a comment below!
