---
url: "/streaming-video-player"
date: 2011-07-13T00:00:00Z
excerpt: Creating a new Streaming Video Player to fix the glaring inconsistencies and missing functionality in the native AS3 component.
tags:
  - as3
  - component
  - netstream
  - streaming video
title: Streaming Video Player
---

<img width="750" height="486" layout="responsive" src="https://labs.tomasino.org/assets/images/flash-video-player.jpg" alt="Flash Video Player"></img>

Well, as promised, it's time to reveal the video player I've built on
top of [SimpleNetStream][]. I don't care for components in Flash; I
never have. Using the FLVPlayback component is usually an overkill for
me, and often leaves me wanting for control that's [obfuscated][] away.
Inevitably, I need to do something with that bloody NetStream object
directly. It's frustrating! Also, it's kinda huge, and not in a good
way. So, without further ado, here's the StreamingVideoPlayer class.

[StreamingVideoPlayer.as](https://github.com/jamestomasino/tomasino/blob/master/org/tomasino/video/StreamingVideoPlayer.as)

Now lets look at how it works:

``` actionscript
// To create a new player...
_videoPlayer = new StreamingVideoPlayer (REMOTE_SERVER, VIDEO_URL,
MAX_WIDTH, MAX_HEIGHT, AUTO_RESIZE, VOLUME);

// For Example
_videoPlayer = new StreamingVideoPlaye (null, 'test.flv', 550, 400);
addChild ( _videoPlayer ); // Yup, that's it!

/* If you want to connect to a streaming server, that 'REMOTE_SERVER' parameter
will be the server location, not null. For local file loads, just toss
a null in there and you're done!
*/

// Some Public Methods
_videoPlayer.play ();
_videoPlayer.pause ();
_videoPlayer.togglePause ();
_videoPlayer.seek ( timeInSeconds );
_videoPlayer.destroy (); // for cleanup

// Some Public Properties

// First, the Read-Only ones:
_videoPlayer.time; // current time of playback
_videoPlayer.duration; // total time of video
_videoPlayer.paused; // is it paused?
_videoPlayer.isSeeking;
_videoPlayer.loadProgress;

// Now the writeables
_videoPlayer.repeat = true; // Default is false
_videoPlayer.smoothing = false; // Default is true
_videoPlayer.mute = true;
_videoPlayer.volume = .5; // yeah, you've got volume control built right in
```

Perhaps the most important thing about the whole player is that every
event of NetConnection & NetStream (SimpleNetStream in this case) is
being dispatched from the StreamingVideoPlayer. Anything that's in
org.tomasino.net.vo.NetConstants is fair game (with the exception of the
SharedObject stuff). I tried to handle all the basics you'd need your
actual player to be able to handle, but just in case you can tap into
those events yourself. That includes those nice new events I created for
SimpleNetStream. You get it all, baby!

I've also fixed a bug with 'NetStream.Seek.Notify' events as mentioned
[in this post][](post removed). In short, when you were to seek to a new position, it
would dispatch that event before the 'time' property was updated with
the new time. The biggest result you've probably seen from this in the
wild is when you drag a progress slider to a new position, let go, and
it flashes back to its old position briefly before updating. I really
liked the solution they came up with, so I lifted a bit of their code in
that post, but tweaked it to use the actual event, just fired at the
correct time.

Remember, this class requires all those nifty net package classes from
SimpleNetStream, as well as my logging package. You can pick up the
[whole repository over at GitHub.][]

Or just [grab this file's source from GitHub][]

  [SimpleNetStream]: //labs.tomasino.org/netstream-sucks/
    "SimpleNetStream"
  [obfuscated]: http://whitewolf.wikia.com/wiki/Obfuscate_(VTM)
    "Obfuscate"
  [in this post]: //www.brooksandrus.com/blog/2008/11/05/3-years-later-netstream-still-sucks/
    "3 Years Later NetStream Still Sucks"
  [whole repository over at GitHub.]: //github.com/jamestomasino/tomasino
    "GitHub - Tomasino"
  [grab this file's source from GitHub]: //github.com/jamestomasino/tomasino/blob/master/org/tomasino/video/StreamingVideoPlayer.as
    "StreamingVideoPlayer"
