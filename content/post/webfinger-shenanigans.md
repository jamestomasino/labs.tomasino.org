---
date: 2023-03-27 21:18:51 +0000
title: "webfinger shenanigans"
url: "/webfinger-shenanigans"
tags:
  - webfinger
  - fediverse
---

It turns out that creating a webfinger response at the `.well-known` path is
really easy!

What is webfinger? Well, it's one of several open source technologies that
underly the fediverse.

> WebFinger is a protocol specified by the Internet Engineering Task Force IETF
that allows for discovery of information about people and things identified by
a URI. Information about a person might be discovered via an acct: URI, for
example, which is a URI that looks like an email address. --Wikipedia

Just like its predecessor, finger, it lets you poke at an endpoint and get back
some basic info.

```bash
finger tomasino@gopher.black
```

[alexlehm](https://authors.cosmic.voyage/~alexlehm/) suggested that we implement
this on cosmic.voyage so that we can use our accounts there conveniently around
the fediverse. Normally users can find me at @tomasino@tilde.zone, but they may
not know that. Some may know me from my authorship on cosmic.voyage, or maybe my
time on [tilde.team](https://tomasino.tilde.team). Wouldn't it be nice if anyone
can insert my addresses at those places and just end up with the correct
account?

Well, alexlehm recommended [this
page](https://www.hanselman.com/blog/use-your-own-user-domain-for-mastodon-discoverability-with-the-webfinger-protocol-without-hosting-a-server)
to get started. It had lots of great info about how to structure a webfinger
response, but it all boils down to this:

A request will come in to the path
`/.well-known/webfinger?resource=acct:<username>@<domain>`. It needs to respond
with a json file with a mime type of `application/jrd+json`. That json file has
a bunch of info in it, but the easiest thing to do is just copy it from your
fediverse account!

```bash
curl https://<domain>/.well-known/webfinger?resource=acct:<username>@<domain>
```

So that's what I'm doing. Cosmic's web server is an express app running a thin
layer of HTML and styling on top of the core gopher site that powers everything.
That's not really important, though. It just needs something to handle that
well-known URL and point it to the json files for each user if they exist.

If you want to do that yourself, I recommend the solution that
[ben](https://ben.tilde.team) did. [Toss a PHP file at that
location](https://tildegit.org/team/site/src/branch/master/.well-known/webfinger/index.php),
strip any of your server-specific lingo, and check if the user has the webfinger
json file at some convenient location.

We've settled on using `~/.webfinger.json`, but maybe you have other opinions.

I even [wrote a quick shell
script](https://tildegit.org/cosmic/cosmic/src/branch/master/bin/webfinger) that
asks for a user's fedi account and does the fetching for them. Feel free to grab
it and modify for your own needs.

## In summary

You can now find me on fedi by using @tomasino@cosmic.voyage or
@tomasino@tilde.team or @tomasino@fuckup.club. It'll all redirect to my
tilde.zone account nicely. :)

## EDIT

For private systems that you don't share with others, you may want to just
serve a single webfinger file no matter what the query is. Everything at the
tomasino.org domain should point to me, right? Well, that site is a static one,
so php solutions are out. Instead I just made a quick nginx rule like so:

```
  location /.well-known/webfinger {
    add_header Content-Type application/jrd+json;
    alias /var/www/www.tomasino.org/.well-known/webfinger.json;
  }
```

<!--  vim: set shiftwidth=4 tabstop=4 tw=80 expandtab: -->
