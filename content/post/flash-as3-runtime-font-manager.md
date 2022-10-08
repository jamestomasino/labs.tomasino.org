---
url: "/flash-as3-runtime-font-manager"
date: 2009-07-16T00:00:00Z
excerpt: Creating a library to handle the loading and management of fonts at runtime in Flash AS3.
tags:
  - as3
  - font
  - font manager
  - runtime
title: Flash AS3 Runtime Font Manager
---

Thanks to the move and new job (more on this later), I've recently found
the time to complete my runtime font loader! I'm pretty sure I'm not the
only one totally psyched about it, either. Well, here it is,
step-by-step, complete and unabridged.

The runtime font system has four parts to it:

-   The Font Manager - The core of the system that handles loading the
    fonts, all the events, and manages which have already gone into
    memory.
-   The Font Manager Extension - The application-specific manager
    describes which fonts are loadable in this application and sets up
    some string constants to make things easier to use.
-   The Font Manager Implementation - The application needs to implement
    the manager in order to use it. This is where that happens.
-   The Font File - Very important indeed, we need to actually prepare
    the fonts we want to use at runtime.

The Font Manager will provide the methods for loading fonts, managing
which have already been loaded, dispatching events properly when loading
groups of fonts, and so on. The application will lean on these events to
know when the fonts are ready for each view.

My manager uses the [BulkLoader][] project. It's released under the MIT
License, so you can grab a copy for yourself over at Google Code. The
role it plays in this class is important, but I don't think it would be
too difficult to re-author the batch loading algorithm to cut out the
dependency. If someone else wants to tackle this, I'd be happy to use
it.

[FontManager.as](https://github.com/jamestomasino/tomasino/blob/master/org/tomasino/fonts/FontManager.as)

This seems like a good place to talk about the work-flow of the
FontManager. When we implement this code into our project, we're
expecting the following behavior:

1.  Register one or more fonts with the Manager
2.  Load the font(s) we need.
3.  Listen for the COMPLETE event to know our fonts are now ready
4.  Display our text using the font
5.  Repeat as necessary from #1 or #2

The FontManager class handles the majority of the operations on its own,
straight out of the box. The parts that are missing from the equation
are the list of which fonts to load, the fonts themselves, and a place
to implement them. The Extension class, which we'll look at next,
provides the specific list of fonts to use, where to find them, and some
constants to make things cleaner.

The Font Manager Extension looks like this:

``` actionscript
package org.tomasino.example.fontmanager
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.errors.IllegalOperationError;

	import org.tomasino.fonts.FontManager;

	public class Fonts extends FontManager
	{
		private var urls:Object = new Object();

		// String Literal must match FontName property.
		public static const ARIAL:String = 'ArialFont';
		public static const GROTESQUE:String = 'GrotesqueMTFont';

		// Statics for Singleton Construction
		private static var _instance:Fonts;
		private static var _allowInstantiation:Boolean;

		public function Fonts ():void
		{
			super();
			if (!_allowInstantiation)
			{
				// There can be only one!!!
				throw new IllegalOperationError("Error: Instantiation failed: Use
						Fonts.instance instead of new.");
			}

			urls[ARIAL] = '/fonts/arial.swf';
			urls[GROTESQUE] = '/fonts/grotesque.swf';

			for (var s:String in urls)
			{
				register (s, urls[s]);
			}
		}

		public static function get instance():Fonts
		{
			if (_instance == null)
			{
				_allowInstantiation = true;
				_instance = new Fonts();
				_allowInstantiation = false;
			}
			return _instance;
		}
	}
}
```

As you can see, I made this font into a Singleton for easy use in any of
the views in my application. That is, however, not necessary. Even if
you instantiate a new copy of the Manager, the data properties are all
static and will work regardless. I've defined two static constants
(ARIAL, GROTESQUE) which are given string literal names as values. These
are **important**, as they'll be the
names we give our actual fonts in a moment. They should not match a
font's native name. I like suffixing the font with "Font".

Inside the constructor the important part to note is the call to the
register method. Since this class extends FontManager, we've inherited
that method. The urls object is just an organization mechanism and isn't
really necessary as long as you've called register() properly. The
second parameter in the register method is the path to your font swfs
(which we'll make in a minute). Simple, right?

Now lets look at the font implementation:

``` actionscript
package org.tomasino.example.fontmanager
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.tomasino.example.fontmanager.Fonts;

	public class FontImplementation extends Sprite
	{
		public function FontImplementation ():void
		{
			Fonts.instance.addEventListener (Event.COMPLETE, onFontLoaded);
			Fonts.instance.loadFont(Fonts.ARIAL);
			Fonts.instance.loadFont(Fonts.GROTESQUE);
			Fonts.instance.start();
		}

		public function onFontLoaded ( event:Event ):void
		{
			var myTextTextField = new TextField();
			myText.embedFonts = true;
			myText.defaultTextFormat = new TextFormat(Fonts.GROTESQUE, 12,
					0xFFFFFF, true);
			myText.text = "This is the Grotestque Font";
			addChild(myText);
		}
	}
}
```

In this example, I've created a new FLA and I'm using this file as the
document class. It would work equally well in an ActionScript project,
or even in a Flex project. If the font is already loaded, the COMPLETE
event will fire immediately, so be ready. Once we're done loading, I've
created a TextField and TextFormat object, and I'm using that same
static constant of the font name to reference the actual font in memory.
Keen!

Finally, you'll probably want to know how to actually build the fonts
for runtime. This is the trickiest part because it involves dealing with
ugly Unicode ranges. I've included a website I use for reference in
here. Again, this file is a document class of a Flash file (CS4 is
required to use the Embed syntax), an ActionScript project, or–though I
wouldn't recommend it–a Flex file.

``` actionscript
package org.tomasino.example.fontmanager
{
	import flash.display.Sprite;
	public class FontArial extends Sprite
	{
		/** Fonts By Unicode Range:
		 * //www.alanwood.net/unicode/fontsbyrange.html#u0000
		 */
		[Embed(systemFont="Arial",
				fontName="ArialFont", /* This name must match the string literal in
										 your class */
				mimeType="application/x-font",
				unicodeRange="U+0000-U+007E,U+2000-U+206F")]
			var regular:Class;

		[Embed(systemFont="Arial",
				fontName="ArialFont",
				mimeType="application/x-font",
				fontWeight="bold",
				unicodeRange="U+0000-U+007E,U+2000-U+206F")]
			var bold:Class;

		public function FontArial ():void
		{
			Font.registerFont(regular);
			Font.registerFont(bold);
		}
	}
}
```

This file gives an example of how to embed the Arial font into a swf.
I've included both the regular and bold type faces here to show you that
they can be stored with the same "fontName", which is pretty handy.
Obviously, you can omit one or the other, or include italic,
bold-italic, or whatever else by using the same method. Once you publish
this, just put the swf into the location you defined in the Extension
class. Oh, and by the way, U+0000-U+007E is the basic character set
you'll almost always want to include. See that URL in the source to find
others. If you want to embed the whole font, just remove the
unicodeRange parameter from the Embed all together. To build another
font, just make sure the "systemFont" parameter equals whatever Flash
calls your font in the IDE, and make sure that "fontName" is a different
string that matches the String Literal value in your Extension class.

That's the jist. If you have any questions, ask away and I'll try to
answer or clarify things for you.

*Update: Please make sure
to get the latest version of this code from my [github
repository][].*

  [BulkLoader]: //code.google.com/p/bulk-loader/
  [github repository]: //github.com/jamestomasino/tomasino/blob/master/org/tomasino/fonts/FontManager.as
