---
date: 2011-11-10T00:00:00Z
excerpt: A reference post for a JavaScript class template I'm using currently.
tags: class code javascript pretty syntax template
title: JavaScript Class Template
---

In an ongoing effort to make my javascript code not look like trash,
I've compiled the following template for all of my class files. It
allows for static, private, privileged, and public methods and
properties. It's a bit of an overkill because I wanted to account for
everything.

Due to the nature of the private and privileged methods and variables,
these will take up memory for every instance of the class (they are not
part of the prototype) and they will not allow for inheritance. I find
the tradeoff for encapsulation more important than inheritance which is
much more rare in JavaScript. Of course, if the class is going to end up
with a bajillion instances, you'd better rely primarily on the Publics.

It's important to take a moment to explain the scope of each of these
method types since JavaScript is infamous for its issues on that front.
First, public methods can only access other publics and privileged
methods and properties. Privileged methods can access public, privileged
and private methods and properties. Private methods can also access any
of the types. The limitation from the publics is related to their
definition in the prototype. Finally, the line "var that = this;" allows
for private and privileged methods to access the "this" scope of the
class. Due to a weird issue with scope inside closures, normally
accessing "this" inside one of those methods would fail.

I don't like how I'm forced to write my getters and setters currently.
There's the "__definegetter__" option, but from what I've read it
isn't standardized and might not work everywhere. Does anyone have
experience with this?

The semicolon at the beginning takes care of any improperly terminated
statements that might preface this class and cause it to poop out.
Thanks to [Dave Hamp][] for that idea!

Finally, everything is wrapped in a function to preserve scope.

[You can grab the latest version of this template from GitHub.][]

  [Dave Hamp]: //www.davidhamp.net "David Hamp"
  [You can grab the latest version of this template from GitHub.]: //github.com/jamestomasino/Javascript-Class-Templates/blob/master/Encapsulated.js
    "Encapsulated JavaScript Class Template"
