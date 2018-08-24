---
date: 2009-04-30T00:00:00Z
excerpt: Implementing an experiment to handle uploading files into Flash in a single
  step.
tags: as3 file-upload filereference service
title: AS3 One Step Image Upload
---

Tonight KeMo and I worked diligently for an extra hour or two after work
and came up with a wonderful solution that allows a user to upload an
image (or any file, for that matter) into Flash to be used directly. For
those of you who haven't tried to pull this off before, you might be
saying to yourself, "Why would that be hard at all?" Well, for one
thing, the FileReference Class has this nasty habit of not allowing
Flash to access data that is passing through on the way up to a web
POST. It's part of Adobe's Security policy that says, basically, Flash
should just blindly take the content and pass it up to the server. If
you try to access the data and manipulate it in any way it will throw an
error.

In the past, we've gotten around this problem by uploading to a
server-side script that stores the data in a database or on the server's
file system and passes a string back to Flash with the URL or database
ID. Its a solution that works reliably and is fairly straight forward.
The only problems we've had was in a situation on a load-balanced
server, but it was fairly esoteric.

Tonight, though, we really wanted to see if it was possible to just pass
the file into Flash and let the server immediately forget about it. We
don't need to keep these images online after the user plays with them in
their player, so we thought it would be a great opportunity to see if it
was possible.

KeMo had the first brilliant idea. He thought that we should be able to
simply write an image header from the server-side script and then output
the raw image data. Flash should, in theory, pick up that data in the
event that signals the upload's completion. We could then display the
file. That's when we found out a few nasty things about Flash's
FileReference Class.

The FileReference Class returns a DataEvent when an upload completes.
This seemed promising at first until we realized that DataEvent extends
TextEvent, an event usually used to monitor typed user input. The data
property of our DataEvent was hard-typed to text! It totally ignored the
mime-type of the returned data and forced it into a string.

Our next thought was to try and convert the returned string into a
ByteArray. Our thinking here was that once we had a ByteArray, we could
further convert it back into the BitmapData, and finally display it.
Sadly, there seems to be no documentation on exactly what type of
character encoding was used by the DataEvent when it forced the content
into a String. Therefore, we had no way of properly using ByteArray's
writeMultiByte method to convert it back. We were starting to get
worried. The solution was so close, but we were having trouble getting
there.

That's when the idea hit me. If Flash is going to force our returned
data to be a String, then so be it! We could serialize the data being
returned from our server-side script. Then, in Flash, we'd deserialize
it, convert the ByteArray to a Bitmap, and presto!

We decided to use Base64 encoding/decoding as our serialization
technique. There are probably smaller and faster options, but we were
just concerned about getting it working. After a few Google searches, we
found a fantastic Base64 decoder in AS3 by "foxarc". We did the encode
in PHP, the decode in Flash, and suddenly we were looking at a proper
ByteArray.

The final step of the puzzle was to take a ByteArray and convert it to a
Bitmap object. We found a few solutions that involved using the setPixel
method with a few nested loops and a horrible amount of bitshifting. The
blogs claimed it was very fast and efficient, but we wanted to go home
at some point tonight. Instead, I found a neat trick of the Loader
class. I had always wondered why Loader was in the flash.display package
instead of flash.net. Well, now I understand why. In addition to the
file loading capabilities, it also contains all of the necessary
mechanisms to convert a ByteArray into Flash datatypes. Specifically, in
this instance, Bitmaps. Here's the magic:

``` actionscript
private function uploadCompleteDataHandler (event:DataEvent):void
{
	var ba:ByteArray = new ByteArray();
	ba.writeBytes (Base64.decode(event.data));
	var loader:Loader = new Loader();
	loader.contentLoaderInfo.addEventListener (Event.COMPLETE,
	getBitmapData);
	loader.loadBytes (ba);
}

private function getBitmapData (e:Event):void
{
	var image:Bitmap = e.target.content as Bitmap;
	image.smoothing = true;
	addChild (image);
}
```

If you're curious like I was, this method will also allow you to load
uploaded SWFs just as easily as images. Basically you can upload any
file format at all and it will act like it came from a trusted domain.
Such a wonderful solution to get around one of Flash's nastier security
policies.

Now I don't want to post all of the code here, mainly because I don't
have a good CSS class set up for displaying code, but I wouldn't leave
you all without a way to get the files. The zip below has all the files
necessary to get your own file uploader working in Flash. Just edit the
classes and change the paths to the php file on your own localhost or
web server and you're good to go. Good luck.

**Edit:** I've installed a code highlighter plugin, so now I can start writing
more code posts!
