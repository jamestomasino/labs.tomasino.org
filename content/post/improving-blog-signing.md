---
date: 2024-04-06 15:55:44 +0000
title: "Improving Blog Signing"
url: "/improving-blog-signing"
tags:
  - meta
  - gpg
  - cryptography
---

In [a previous post](/signing-posts-with-gpg) I set up a system to sign the
pages of this blog with gpg. If you aren't familiar with that post, I recommend
checking it out. I think it's pretty interesting.

I had a technical challenge in my implementation because I'm using Hugo as my
static site builder. Hugo is very fast at generating pages, but perhaps because
of that it doesn't do incremental builds. Every time it generates the entire
site. I'd prefer to only resign a page if it has changed, but detecting that
became more difficult as a result.

My normal strategy is just to use the native timestamp checking in a Makefile.
If the entire blog wasn't being regenerated I could check if that particular
html page had been, and if so, resign. Since that's not an option I've been just
suffering through the lengthy re-signing of every page for the last year.

Today that changes.

If I can't use timestamp the next best bet is a simple hash and checksum. If the
content changes I'll know it!

```bash
#!/usr/bin/env bash

GPG_FINGERPRINT="XXXXXXXXXXXXXXX"
cache="cache"
f="$1"
gen=0
if [ -f "${f}.asc" ]; then
  if ! md5sum --check "${cache}/${f}.md5"; then
    gen=1
  fi
else
  gen=1
fi

if [ 1 -eq "$gen" ]; then
  folder="$(dirname "${cache}/${f}")"
  mkdir -p "$folder"
  md5sum "${f}" > "${cache}/${f}.md5"
  gpg --batch --yes --local-user ${GPG_FINGERPRINT} --armor --detach-sign "${f}"
fi
```

This is my new technique:

1. First I check if the asc file exists at all. If not, we can go ahead and
   assume we need to make it.

2. If it does exist I then check the latest html file and compare it against my
   cached checksum. Checksum doesn't exist or checksum doesn't match? Generate
   a new gpg signature file and update the checksum in the cache.

For the life of me I couldn't remember how to combine a bash if statement that's
checking for a command exit code along with a boolean test, so I split up my
block a bit. Whatever. It's so much faster than before!

Of course I made sure the cache folder I introduced is git-ignored, and the
first time I clone the repo I'll have to do the whole blog generation one time,
but after that it's super simple.

For those of you wondering about my Makefile, I did make one small change there
to call this new sign script:

```
public/%.html.asc: public/%.html
	@./sign.sh "$<"
```

Donsies! Now to test it out on this article...





<!--  vim: set shiftwidth=4 tabstop=4 tw=80 expandtab: -->
