---
date: 2026-07-31 21:55:00 +0000
title: "Film Ratings"
url: "/film-ratings"
tags:
  - glicko
  - film
  - rating
  - chess
  - trakt
  - netlify
---

My [film ratings website][] is a project I've been dreaming up for the last few
years. The core idea was simple: use the same rating system chess players use to
track their performance and apply it to my personal film rankings. Then I can
let the numbers evolve naturally as I compare movies head-to-head, the way
a tournament bracket works.

{{< figure src="/assets/images/film-ratings1.jpg" alt="My Film Ratings" >}}

What started as a straightforward rating tool sort of exploded into a full
system for tournament design, pool selection, pairing strategies, and automatic
film intake. Oops.

## Why Glicko2

Most rating systems you see online are static. You give something five stars,
that's it. The problem with static ratings is they don't account for how your
taste changes. A movie I loved in 2019 might feel different after watching
twenty more films in the same genre. My personal scale shifts.

Chess solves this with Elo, and later Glicko2. Instead of absolute scores, these
systems track relative performance. When a high-rated player beats a low-rated
player, the score barely moves. When the underdog wins, both ratings shift
dramatically. The system also tracks uncertainty, called RD (Rating Deviation).
A player who hasn't competed recently has a higher RD, meaning their rating is
less certain and will adjust faster once they start playing again.

This fits film ratings perfectly, or so I theorized. I have strong opinions
about some movies and vague feelings about others. Glicko2 allows me to simplify
scoring down to a simple choice: movie A or movie B?

## The Tournament Setup

You can't compare two thousand films at once, so my system runs tournaments,
pulling a pool of films and pairing them head-to-head. You pick left, right, or
draw. Each decision is captured back into the rating engine, and everything
updates.

The pool selection was the first unexpected complication. I needed films that
would actually produce useful comparisons, not random selections across the
whole library. My system now defines three bands as a starting point:

- **Normal** picks films clustered near an anchor rating. Comparisons are pretty
  tightly coupled and often difficult to judge.
- **Wide** broadens the range, plus it shifts weighting toward uncertain films.
  It's great at updating things in big broad moves.
- **Explore** samples across the full rating spread. It can sometimes surface
  major upsets if it targets a film I haven't rated much, or that I disagree
  with the public on generally.

The anchor itself is chosen by weighted random selection, biased toward films
with higher uncertainty. This means the system naturally gravitates toward
movies it knows least about, which is really helpful since I'll be adding new
films all the time.

Pairing then happens two ways. Round robin matches every film against every
other film in the pool, producing maximum data. This was what I built first
and... well it kinda sucks. Then I read about Swiss tournaments, and implemented
that pairing style as the new default. Swiss pairing runs fewer seeded
rounds, pairing winners against winners and losers against losers, like a real
Swiss chess tournament. Swiss is faster to complete and still produces solid
signal.

{{< figure src="/assets/images/film-ratings2.jpg" alt="Tournament Setup" >}}

## Seeding From TMDb

Starting from zero ratings means the system needs hundreds of head-to-head
comparisons before it settles on anything approaching accuracy. Nobody
wants to rate two hundred matchups just to get past the cold start.

I use TMDb (The Movie Database) as a seed. Their public ratings come with vote
averages and vote counts, which I transform through a Bayesian adjustment model.
The formula weighs each film's vote average against the population mean, with
confidence scaling logarithmically on vote count. A film with 10,000 votes gets
pulled hard toward its own average. A film with 50 votes gets pulled toward the
mean.

The adjusted rating maps to an Elo seed between 1200 and 1800, with the Glicko
RD set inversely to confidence. High-confidence films start with tight RD (they
won't move much from new comparisons). Low-confidence films start with wide RD
(they need more data).

This means my personal ratings align to my actual preferences much faster. The
system has a head start on knowing what I like.

Let me pause here really briefly because that tiny section represented the most
advanced math I've had to do in a really long time. I thought wikipedia would be
a good source of information on how to pull this off and I was absolutely wrong.
Thank goodness for Github and open source projects. I was able to steal enough
people's code to get my proof of concept functional, then push forward.

## Pulling Films From Trakt

I track everything I watch on [Trakt.tv][]. Not manually, of course. It's
connected to my Plex and that handles 98% of everything. I just need to remember
when I actually go to a theater to click on a button. Then, when I sync my watch
history, the system imports films automatically, pulling metadata from TMDb and
seeding ratings (per above) in a single import pass. New films appear in the
pool ready for comparison. The first time it worked I got up and did an old man
jig.

The sync runs through a job queue so it doesn't block the UI. Each history event
gets deduplicated, films get upserted, and poster images cache to persistent
storage via Netlify. It takes a few seconds to sync a full page of watch
history.

## The Architecture

The frontend is a React SPA built with Vite. The backend runs on Netlify
Functions with Neon Postgres for the database. Drizzle handles schema and
migrations. Poster images live in Netlify Blobs.

The scoring endpoints require authentication and rate limiting. Every write
operation needs explicit intent headers. The admin area handles film intake,
Trakt sync, and manual reseeding.

The database tracks films, watch events, tournaments, tournament entries, and
individual matches. Each tournament captures the starting ratings for every
film, so the Glicko2 update runs on a closed set at the end. When all matches in
a tournament are rated, the system applies the rating updates in one batch and
marks the tournament complete.

This was another area of experimentation. I originally tried to apply Glicko2
without using tournaments at all and nothing really worked right.

{{< figure src="/assets/images/film-ratings3.jpg" alt="Comparison" >}}

## What I Learned

Building this taught me more about tournament design than I expected. The
pairing strategy matters a lot. Pool selection matters most. A tournament that
pulls films too close together produces ratings that don't move. A tournament
that scatters too wide can create noise.

Glicko2 has proven itself viable for this purpose, though. That's the biggest
win. My theory that chess ratings would work for my personal film scoring is
accurate, and it's getting more accurate with time. Films I've compared
repeatedly have settled into stable ratings with low RD. Films I've only
compared once or twice remain volatile for now, just waiting for more data. The
system knows what it knows and what it doesn't.

It's a pretty remarkable little project and I'm really proud of how it's turned
out.


[film ratings website]: https://films.tomasino.org

[Trakt.tv]: https://trakt.tv

<!--  vim: set shiftwidth=4 tabstop=4 tw=80 expandtab: -->
