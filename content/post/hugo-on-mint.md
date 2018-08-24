---
comments: true
date: 2017-08-25T09:20:49Z
excerpt: Installing Hugo on Linux Mint (or Ubuntu) can lead to weird compile problems.
  Here's the quick way to fix it.
tags: hugo mint linux static-site-generator
title: Hugo on Mint
---

I author this labs blog in [Jekyll][], but my [personal blog][] uses the
[Hugo][] static site generator. Jekyll has wonderful plugin support, but
it's incredibly slow. My meager labs blog takes a full minute to compile.
Hugo is written in Go and is screaming fast. Thousands of post? BAM
compiled in less than a second. It's all driven by a single binary, too.
No external dependencies to worry about. No obscure ruby gems that don't
version together well. It's got a powerful templating engine and it's easy
to customize.

I've been writing my blog on a Macbook Air where I had installed hugo with
homebrew:

```bash
brew install hugo
```

This morning I had to make a fix on a post on my Linux Mint laptop,
though. I cloned down my blog from Github and I installed hugo the way I'd
imagine I should:

```bash
sudo apt install hugo
```

Only it seems that the version that apt installs is criminally outdated.
When I tried compiling my blog I got hundreds of errors about incomplete
templates. I needed a more recent version of Hugo.

The Hugo documentation, if you read it, will try to talk you into
installing via `snap`, or failing that, compile with `go` and `govendor`.
I tried both methods and failed miserably. Finally I saw a post that said,
"Just download the .deb release from Github, dummy!" Yeah, that totally
works.

So there you have it. Need hugo on Ubuntu or Mint? Grab the .deb of the
latest release from Github and you're good to go.

  [Jekyll]: https://jekyllrb.com/
    "Jekyll Static Site Generator"
  [personal blog]: https://blog.tomasino.org
    "Personal Blog"
  [Hugo]: https://gohugo.io
    "Hugo Static Site Generator"

<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
