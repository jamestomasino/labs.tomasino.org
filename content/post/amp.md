---
url: "/amp"
date: 2016-07-31T00:00:00Z
excerpt: Integrating accelerated mobile pages into this blog for screaming fast performance. A weekend project.
tags:
  - amp
  - page-speed
title: AMP
---

<twitter width="375" height="330" layout="responsive" data-tweetid="759595551377719296"> </twitter>

The [AMP][] (Accelerated Mobile Pages) project has been floating around in the periphery for about a year, taunting me. I knew it was supposed to speed up mobile browsing, and it had something to do with articles, but that was the extent of it. I'm spending more and more time at [work][] educating coworkers and clients on mobile best practices, but not knowing AMP was making me feel a little hypocritical. Earlier this week I decided it was the right time to take the plunge.

Once I started reading the documentation I realized two things immediately:

- AMP improvements are all about speed and usability, but those things touch on a lot of areas. The project is even taking a deep look at how to improve mobile ad experiences for the benefit of content publishes, readers, and even advertisers.
- Second, this was going to take a lot of effort to convert an established site, but the promise of speed is so enticing!

AMP speeds are cool, but it's not a drop-in fix for all your woes. There's some very real challenges to face:

1. CSS is entirely in the HEAD tag. No inline styles, no external stylesheets. This was a big one for me since so many of my build tasks are set up with external in mind, including selective components to keep size down and only use selectors I need. Thanks to SASS, however, this was relatively easy to overcome.

2. Only certain CSS styles are allowed: no !important tags, limited pseudo selectors, minimal animation controls, etc. By this time I'd decided to try out AMP on a blog, so the danger here was pretty small. I don't do crazy stuff to display articles, after all. If I were approaching one of the big pharma sites I build at work, this could be a problem. If you're starting from scratch, reviewing these limitations should be done before you start designing to avoid pitfalls.

3. A whole bunch of AMP specific script files are needed for each component you leverage. In this blog I'm using `analytics`, `youtube`, `twitter`, `social-share`, and `font`, which each point to a CDN hosted JS file. Once those and the basic AMP script are in place, you'll need to write your markup in specific namespaced ways. For instance, to include the social share links at the bottom of this article, I did:

``` html
<section class="share">
	<social-share type="twitter" width="60" height="44"></social-share>
	<social-share type="gplus" width="60" height="44"></social-share>
	<social-share type="linkedin" width="60" height="44"></social-share>
	<social-share type="pinterest" width="60" height="44"></social-share>
	<social-share type="email" width="60" height="44"></social-share>
</section>
```

This component-based markup is nice, easy, and clean, but it is definitely limiting. There's no doubt about it, going with AMP is making a conscious choice to slim down the customization options of the web in order to take advantage of the speed, SEO, advertising, and engagement benefits.

Is it worth it? Well, that's ultimately up to you. Have a look around this blog, though, and I think you'll agree with me that we've entered _screaming fast_ territory. My [GTMetrix][] page scores haven't changed much, but the perceived load times are near-instant.

Interested in trying it yourself? Have a look at the introduction video below and then pop over to the [project page][] for documentation, examples, and discussion.

<youtube
    data-videoid="lBTCB7yLs8Y"
    layout="responsive"
    width="480" height="270"></youtube>


  [AMP]: https://www.ampproject.org/
	"Accelerated Moblie Pages Project"
  [work]: http://www.gsw-w.com
	"GSW"
  [GTMetrix]: http://gtmetrix.com
	"GTMetrix"
  [project page]: https://www.ampproject.org/
	"Accelerated Moblie Pages Project"
