---
url: "/a-quick-assignment-operation"
date: 2011-05-11T00:00:00Z
excerpt: A reference post for doing fast assignment operations using the logical OR
  operator.
tags: as3 boolean operator tips
title: A Quick Assignment Operation
---

In AS3, like any programming language, there are lots of little tricks
you pick up that eventually become part of your own coding style. One
such for me was shown to me by Guy Wyatt (Guy, I wanted to make your
name a link, but I'm not sure where to send it):

``` actionscript
var foo:String = someValueThatMayBeNull || "Backup String";
```

In this assignment, the value of "someValueThatMayBeNull" may, in fact,
be null, an empty string, or something else that evaluates to false. If
that's the case, our variable "foo" will get the value "Backup String"
instead. It's just one of the neat things about order of operations and
assignment.

I've used this for a long time now, and it's pretty awesome, especially
for dealing with flashvars, but the other day I ran into an assignment
operator that was even cooler. I know, hard to believe, right?

This came up in a "getter" method, but I could see it being equally
useful in singleton instantiation. Check it out:

``` actionscript
return _privateVar ||= new InstanceOfPrivateVar();
```

The "||=" operator is really cool. It works just like the previous
example, but rather than just returning our new instance, it also
assigns it to _privateVar on the way. So next time we call that getter,
_privateVar will already be assigned. Woo!

Ok... so, there's got to be someone else out there who is as excited as
me about this. Share the love.
