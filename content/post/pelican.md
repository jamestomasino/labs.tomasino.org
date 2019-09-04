---
url: "/pelican"
date: 2014-04-04T00:00:00Z
excerpt: Transforming this labs blog into the Pelican static site generator.
title: Pelican
tags:
  - meta
---

This past weekend I finally shed my Wordpress blogs and moved into the world of static site publishing. This site, and my [personal blog](//blog.tomasino.org) are now built using [Pelican](//pelican.readthedocs.org/en/3.3.0/), a Python based static site generator.

What does that mean, exactly? Well, for one thing, it means I no longer have to worry about someone exploiting a vulnerability in my server-side code to run malicious code or take over my website. My blogs may not be very popular or have much appeal to them from that perspective, but it's best to be safe anyway. Additionally, since the server no longer has the burden of compiling my web pages whenever they are requested, the site content serves much faster and with fewer cpu cycles. Since I use [cloud hosting](//greenqloud.com) and pay based upon my traffic and CPU usage, this actually saves me money! (Not a lot, but some.)

The experience of migrating content from Wordpress to Pelican wasn't very difficult. Setting up [Disqus](//disqus.com) for comments was a breeze as well, though it did take a bit of [vim](//www.vim.org) work to convert the URLs to their new locations. All in all, it was about 4 hours work for both blogs, much of which was spent cleaning up small formatting errors in the generated files.

I'm really looking forward to building this blog from the command line going forward. Now that I've written this post (in [markdown](//daringfireball.net/projects/markdown) mind you) I can build, test, and publish it by typing:

``` bash
make html
make serve
make rsync_upload
```

_**Edit**: This post is out of date. This blog is now being served in Jekyll._
