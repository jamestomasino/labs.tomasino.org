---
url: "/interfaces"
date: 2011-03-03T00:00:00Z
excerpt: An overview of Interfaces for developers unfamiliar with the concept using
  Flash AS3 as an example.
tags: as3 code-style collaboration interface
title: Interfaces
---

<amp-img width="427" height="345" layout="responsive" src="//labs.tomasino.org/assets/images/interfaces.jpg" alt="Interfaces"></amp-img>

A lot of AS3 Developers aren't from a traditional computer science
background. As a result, things like complex data structures and design
patterns aren't tossed around in common conversation. In fact, some
elements of Object Oriented Programming are often misunderstood or
overlooked. Interfaces, in my experience, are one of the major examples
of this.

Here's what [Wikipedia says about Interfaces][]:

	"In [object-oriented][] languages the term "interface" is often used
	to define an [abstract type][] that contains no data but *exposes*
	behaviors defined as [methods][]. A [class][] having all the methods
	corresponding to that interface is said to implement that interface.
	Furthermore, a class can implement multiple interfaces, and hence
	can *be* of different types at the same time."

So that's the definition, and it's fairly straight forward. Interfaces
are all about defining public methods. They're like a table of contents
to your class or classes. Any class that implements your interface will
have those public methods just as described. Lets take a look:

Interface Example:

``` actionscript
package org.tomasino.example
{
	public interface IExampleInterface
	{
		function exampleMethod ( parameter:String ):void;
	}
}
```

Implementation Example:

``` actionscript
package org.tomasino.example
{
	public class ExampleImplementation implements IExampleInterface
	{
		public function ExampleImplementation()
		{
		}

		public function exampleMethod ( parameter:String ):void
		{
			trace ( parameter );
		}
	}
}
```

So you can see from my really simple example, the interface is just a
layout of sorts for the class that will implement it. Using them is
pretty simple. That's not where people usually have trouble. It's more
the question of when to use them and why.

So why use an interface? Why not just extend a base class? There's lots
of reasons people on message boards will argue and shout about, but I
can only tell you my experience and the reality of what I've run across
in the real world. You want to use interfaces anywhere you need to
decouple code. (Learn more by searching about "[Loose Coupling][]"
systems)

The most common decoupling situation is when you're developing some sort
of class that's going to be extensible. Maybe you're building a library
that other developers will use, or you'll reuse with a new
implementation. Program your part so that it calls on something that
implements your interface and let the mysterious future developer do it
all from there. You create an actual separation in the code where one
class doesn't need to know exactly what the other one is, but just a few
details about it.

That's also why it can be good to program to interfaces when you're
developing a small section of a project and working with others. You can
create your interface first so the others know how to connect with your
code. Long before you finish the actual implementation, they'll know how
to call your methods, pass you data, or whatever. Helpful!

Traditionally developed programs that have an ongoing life-cycle with
iterative releases and whatnot demand cool solutions for loose coupling
so they can be maintained and changed without having to redevelop the
entire app, but so little of what we do in Flash has that sort of life.
Long-lived code lasts about a year in my experience. Even so, that
doesn't mean it's pointless to use or that you shouldn't know how to do
it. It also means that you don't need to go overboard. Use it when it's
right. Interfaces can be helpful, but adding them unnecessarily all over
the place can just add to code bloat and confusion.

All this theoretical talk is good, but I like concrete examples. In a
few of my past blog posts I've shared some of my tracking
implementations. I've talked about [Google Analytics][] and [Omniture][]
tracking, but I haven't shown my full Tracking Manager yet (look forward
to that post soon). A while back I developed a tracking system that
could wrap up any number of tracking implementations, whether they were
Google Analytics, Sagemetrics, Comscore, HBX, Omniture, or anything else
that might creep up at me. To do this, I developed a really abstract
system and plugged in specific analytics implementations, including
those classes I've shown you. At the heart of these tracking "types" (as
I called them) is a very simple interface.

``` actionscript
package org.tomasino.tracking.types
{
	import org.tomasino.tracking.TrackingData;

	public interface ITrackingType
	{
		function track (t:TrackingData):void;
	}
}
```

Since the tracking manager doesn't know anything about the specific
implementation, it still needs to know some way to communicate to the
classes that will be there. If you imagine two business people from
different countries meeting for the first time, it's very similar. They
have no idea how to interface at first. One option is for Mr. A to say,
"Hello," to Mr. B, and prepare for the contingency that Mr. B doesn't
speak English. That's basically like calling a method in a try..catch.
But if Mr. B approaches with his hand outstretched, suddenly Mr. A now
knows a safe way to ... interface. By having Mr. B implement the
interface IHandshake, now we have a guaranteed form of communication
between strangers.

That's the gist of interfaces. I hope you find it helpful. Remember, if
you don't use them that doesn't make you horrible. They're just another
tool, one that isn't incredibly important in AS3 development.

  [Wikipedia says about Interfaces]: //en.wikipedia.org/wiki/Interface_(computing)#Software_interfaces_in_object_oriented_languages
    "Interfaces at Wikipedia"
  [object-oriented]: //en.wikipedia.org/wiki/Object-oriented
    "Object-oriented"
  [abstract type]: //en.wikipedia.org/wiki/Abstract_data_type
    "Abstract data type"
  [methods]: //en.wikipedia.org/wiki/Method_(computer_science)
    "Method (computer science)"
  [class]: //en.wikipedia.org/wiki/Class_(computer_science)
    "Class (computer science)"
  [Loose Coupling]: //en.wikipedia.org/wiki/Loose_coupling
    "Loose Coupling"
  [Google Analytics]: //labs.tomasino.org/flash-googleanalytics-tracking/
    "Google Analytics"
  [Omniture]: //labs.tomasino.org/flash-omniture-tracking/
    "Omniture"
