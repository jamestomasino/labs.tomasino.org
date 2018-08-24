---
url: "/underlines"
comments: true
date: 2017-08-23T16:55:49Z
excerpt: Making the perfect underlines that work on superscripts, like a boss
tags: underline css html
title: Underlines
---

We build a lot of websites with superscripts in pharma. Whether it's
a registration mark &reg; or a superscripted reference number<sup>1</sup>,
getting them to properly underline is a real issue. Usually the underline
on the superscript will move up off the baseline. In the past, we've
solved this by adding a border-bottom to the text instead of an underline,
but that will only work on single-line text. It blows up badly when your
text is multi-line or rags off the end of a line.

A little googling revealed a possible solution in the [comments of
this gist](https://gist.github.com/unruthless/413930). Someone way more
brilliant at CSS than I am came up with a way to use a linear gradient
that repeats in the X axis. It wraps around long lines just fine and
scales with the text perfectly. I've married it up with the default CSS
for all good, sane, sup tags and developed the following:

```css
sub, sup {
  /* Specified in % so that the sup/sup is the
     right size relative to the surrounding text */
  font-size: 75%;

  /* Zero out the line-height so that it doesn't
     interfere with the positioning that follows */
  line-height: 0;

  /* Where the magic happens: makes all browsers position
     the sup/sup properly, relative to the surrounding text */
  position: relative;

  /* Note that if you're using Eric Meyer's reset.css, this
     is already set and you can remove this rule */
  vertical-align: baseline;
}

sup {
  /* Move the superscripted text up */
  top: -0.5em;
}

sub {
  /* Move the subscripted text down, but only
     half as far down as the superscript moved up */
  bottom: -0.25em;
}

a {
  /* Use linear-gradients with a horizontal repeat to
     create the underline effect */
  text-decoration: none;
  background: -moz-linear-gradient(left, red, red 100%);
  background: -ms-linear-gradient(left, red, red 100%);
  background: -o-linear-gradient(left, red, red 100%);
  background: -webkit-gradient(linear, 0 0, 100% 0, from(red), to(red));
  background: -webkit-linear-gradient(left, red, red 100%);
  background: linear-gradient(left, red, red 100%);
  background-position: 0 100%;
  background-size: 10px 1px;
  background-repeat: repeat-x;
}
```

If you want to see a working demo, here is a [jsfiddle
example](http://jsfiddle.net/yyHNp/534/)

<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
