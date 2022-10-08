---
url: "/lat-long-distance"
date: 2011-02-23T00:00:00Z
excerpt: An experiment to implement major distance calculation formulae using latitude and longitude, and comparing results.
tags:
  - cosine law
  - distance
  - haversine
  - latitude
  - longitude
  - math
  - oblique spheroid
  - sphere
  - vincenty
title: Lat-Long Distance
---

When you want to calculate distance on a sphere or sphere-like shapes,
there are three good options. The [Cosine Law][] method is the easiest
and can be done by hand. The [Haversine formula][] isn't too much
rougher, but unless you really like math, you're probably not going
there. These two methods give remarkably similar results, and they're
great on a perfect sphere! So if you're measuring things on a sphere,
you're done reading. No really, go. It's ok. \*Sniff\*

But if you're like me, you're most likely dealing with these distance
calculations because some awesome designer decided that you should be
able to measure distances between two points on Earth. That'd be
awesome! Of course, despite what all your globes teach you, the Earth
isn't a sphere. It's squished. It's called an oblique spheroid. Sounds
dirty to me.

So if you want to measure distance on an oblique spheroid you need a
more accurate formula. Please allow me to introduce you to your new
friend, [Vincenty's Formula][]! Now, unless you are really, really (and
I mean really) into math, this thing is going to suck. Luckily for you,
I converted it into an AS3 class. See how nice I can be?

Have some lat/long coordinates you need to measure? Have a project where
you can use this sort of info? Take and use. Let me know if you love me.
I can use some love.

[Source & Example][]

  [Cosine Law]: https://en.wikipedia.org/wiki/Law_of_cosines "Cosine Law"
  [Haversine formula]: https://en.wikipedia.org/wiki/Haversine_formula
    "Haversine Formula"
  [Vincenty's Formula]: https://en.wikipedia.org/wiki/Vincenty's_formulae
    "Vincenty's Formula"
  [Source & Example]: https://github.com/jamestomasino/latlondist/
    "Source & Example"
