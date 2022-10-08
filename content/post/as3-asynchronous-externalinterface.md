---
url: "/as3-asynchronous-externalinterface"
date: 2012-05-24T00:00:00Z
excerpt: Enabling AS3 ExternalInterface calls asynchronously through pure awesomeness and alchemy, or maybe just leveraging JavaScript.
tags:
  - actionscript
  - javascript
title: AS3 Asynchronous ExternalInterface
---

As I [may have mentioned before][], AS3 performs its ExternalInterface
operations synchronously. For the most part, this isn't a big issue, but
what happens when the javascript you need to execute grows extensive, or
what if it is a slow operation? In these cases, it's helpful to be able
to make an ExternalInterface call that is asynchronous so your
actionscript code can continue.

The following example does exactly that. It provides a layer between
your JS and your Flash for converting ExternalInterface.call methods to
an asynchronous method.

The first part of this method is the AS3 class, AsyncExternalInterface:

[AsyncExternalInterface](https://github.com/jamestomasino/AsyncExternalInterface/blob/master/org/tomasino/external/AsyncExternalInterface.as)

This class first tests whether ExternalInterface is available at all,
and then whether the necessary JavaScript class is on the page. If the
JavaScript is not loaded, it will degrade and use ExternalInterface
normally. If everything is in place, then your calls will be passed down
to the CallStack JavaScript class.
Here's CallStack.js:

[CallStack](https://github.com/jamestomasino/AsyncExternalInterface/blob/master/js/CallStack.js)

This class acts like a Singleton where you get the instance via the
CallStack method made available in window. This means that when you
include the JS in the page, you don't have to do any instantiating
yourself, or pass any variable names back to Flash. It'll figure all
that out itself. Of course, if you're using this with the AS3 class, you
don't need to know about any of that because it's all done behind the
scenes.

What's happening here is that every function call you make to
ExternalInterface is being stored in a stack. This quick storing of the
calls means your AS3 can continue on its merry way while JavaScript
delays, then makes calls to that stack later. The speed at which the
class works through the CallStack is set in the variable INTERVAL\_TIME.
For our test I've set that to 1 second. Before you use this in
deployment, you'll probably want to speed that up dramatically.

The class also has some cleanup methods so that while the stack is
empty, it doesn't waste any time polling an interval.

Finally, it's time to put the files together into an HTML wrapper.

[index.html](https://github.com/jamestomasino/AsyncExternalInterface/blob/master/index.html)

For our test, Flash is calling "testFunction" four times. The first
three have sequential parameters, and the last has no parameters. If you
[have a FlashLog.txt file set up][], you can also note the appearance of
the traces vs the alerts. In the AsyncExample.as file, the traces come
after the ExternalInterface calls. Were we using a normal
ExternalInterface, you wouldn't see any of those traces until after the
alerts completed. Because of the AsyncExternalInterface solution,
though, the traces will appear instantly, before the first alert has
time to fire.
The full example code can be [found over on github][]. Enjoy!

  [may have mentioned before]: https://labs.tomasino.org/as3-synchronous-url-xml-loading/
  [have a FlashLog.txt file set up]: https://livedocs.adobe.com/flex/3/html/logging_04.html
  [found over on github]: https://github.com/jamestomasino/AsyncExternalInterface
