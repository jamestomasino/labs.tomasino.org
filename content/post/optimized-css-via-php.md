---
url: "/optimized-css-via-php"
date: 2011-11-30T00:00:00Z
excerpt: An experiment to create a basic CSS preprocessor and minifier using PHP.
tags: css gzip minify php preprocess style
title: Optimized CSS via PHP
---

I'm putting together a really tight little todo list manager right now,
and in the process I've been exploring some simple things on my ... todo
list. Hrm, that came out weird.

Anyway, I wanted to manually handle minifying and organizing my CSS
files. I wanted three important things:

1.  The CSS files, no matter how many, should be served up from a single
    HTTP request
2.  The CSS contents should be stripped down to take out unnecessary
    whitespace and comments
3.  The whole request should be properly gzipped

I found most of what I needed in a [really cool little blog post][](post removed), but
it needed a lot of surgery. Take a look.

[styles.css.php](//github.com/jamestomasino/ToDo/blob/master/html-template/css/styles.css.php)

I set my compression up with ob_gzhandler, and do a little magic with
the headers. Cache expires in a day, which I think is plenty often
enough, but feel free to tweak to your own needs.

Next I set up an array of CSS files. Notice they're all real CSS files,
not PHP files in disguise. I kept things simple. They'll be read into
PHP and cleaned up in the bottom section. Simple, right?

Oh, right... you can use it in your HTML just like you would a normal
CSS file:

``` html
<link rel="stylesheet" type="text/css" media="screen" href="css/styles.css.php" />
```

It may not be as robust as [Google Minify][] (though I'm stealing pieces
of it), but it's tiny and mine. Victory!

  [really cool little blog post]: //www.catswhocode.com/blog/3-ways-to-compress-css-files-using-php
    "3 ways to compress CSS"
  [Google Minify]: //code.google.com/p/minify/ "Google Minify"
