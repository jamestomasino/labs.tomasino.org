---
date: 2013-07-12T00:00:00Z
excerpt: A mathematical experiment in using the Chess ELO rating system for the comparison
  of an abstract pool.
tags: design javascript
title: Chess Ratings
---

<amp-img width="524" height="485" layout="responsive" src="//labs.tomasino.org/assets/images/chess-rating.png" alt="Chess Ratings"></amp-img>

[See it in action][]

The development team [where I work][] will soon be celebrating the
launch of our new company website a good old fashioned chess tournament.
Now, like any good development team, we have our fair share of geeks;
geeks with interests in a wide variety of [geekery][]. One such geek is
a big fan of [fantasy sports][], so we tasked him with organizing said
tournament. As a result, we will be doing a round-robin tournament to
establish a relative ELO rating for each player, then use these ratings
to seed a double elimination bracket tournament (I'm about 60% sure I
got the names right for all that stuff). Anyway, the key component for
the round robin is having a method to establish our ratings.

The [ELO rating system][] is the most widely used in the chess world,
and with good reason. When you have a [sport][] played by some of the
greatest minds in the world, it only makes sense to have an overly
complex and highly accurate way of showing relative strength. In fact,
it's so impressive that just about nobody outside of official chess
organizations actually does it properly. The rest of the world kind
estimates an ELO, or approximates it. I am happy to be one of those
folks.

I have neither the time nor the care to implement a 100% accurate chess
rating system. All I need for the tournament is something that works
decently well. So, [I built it][]!

My chess ratings page allows you to enter the starting rating for each
player, pick the outcome of the game, and it will show you the new
ratings. How do I do this? Well, I use a formula I lifted from
[RedHotPawn.com][]! I didn't steal their code or anything. I just
followed the instructions on their FAQ (mostly).

Why don't you go try it out! And if you're interested in my algorithms
and junk, here's the [main code].

  [Chess Rating]: //labs.tomasino.org/assets/images/chess-rating.png
  [See it in action]: //github.com/jamestomasino/chessrating/
  [where I work]: //gsw-w.com "GSW Worldwide"
  [geekery]: //www.gotmead.com/ "Got Mead?"
  [fantasy sports]: //deadspin.com/5865635/fantasy-curling-is-a-real-thing-and-it-is-glorious
    "Fantasy Curling"
  [ELO rating system]: //en.wikipedia.org/wiki/Elo_rating_system
    "ELO Rating System"
  [sport]: //www.chess.com/article/view/is-chess-a-sport
    "Is Chess a Sport?"
  [I built it]: //github.com/jamestomasino/chessrating/
    "Chess Ratings"
  [RedHotPawn.com]: //RedHotPawn.com "Red Hot Pawn"
  [main code]: //github.com/jamestomasino/chessrating/blob/master/sjs/main.js
