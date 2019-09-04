---
url: "/dotfiles"
comments: true
date: 2016-11-12T19:41:16Z
excerpt: Another update on my endless quest for the perfect shell personalization.
title: dotfiles
---

I made a fairly major modification to my [dotfiles][] yesterday when
I revisited the structure and installation by leveraging the gnu utility,
[stow][]. I was introduced to the idea thanks to my partner in
dotfile-crime, [Stephen Tudor][], who in turn found it off one of his
other config-crazy people.

In short, `stow` is designed to take a package of files and symlink them
into another directory as if they all belonged there. Since that's
primarily the way we install dotfiles, it's a perfect fit. There's some
sweet options in targeting, unloading, force-loading, and so on.
Everything is easy to use and keep organized. It was an easy update to
take on.

The final piece of this update is my use of a Makefile for installation.
Rather than running individual stow commands, or batch loading everything,
I went to a modular approach with some basic environment detection. Some
of my dotfiles require a follow-up step, or some directory preparation.
The [Makefile][] made it easy to put all that in place, and even add some
pretty output for myself in the future.

Check it out [over on github][].

   [dotfiles]: https://www.github.com/jamestomasino/dotfiles
      "James Tomasino's Dotfiles"
   [stow]: https://www.gnu.org/software/stow/
      "GNU Stow"
   [Stephen Tudor]: https://www.twitter.com/tagsoup
      "tagsoup@twitter"
   [Makefile]: https://github.com/jamestomasino/dotfiles/blob/master/Makefile
      "Makefile in James Tomasino's Dotfiles"
   [over on github]: https://www.github.com/jamestomasino/dotfiles
      "James Tomasino's Dotfiles"



<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
