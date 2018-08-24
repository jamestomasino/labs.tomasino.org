---
url: "/elf-name-generator"
date: 2011-02-23T00:00:00Z
excerpt: Generating silly names in the elvish style based on the components given
  in Tolkein's language notes.
tags: names nerd regex string-manipulation xml
title: Elf Name Generator
---

<amp-img width="517" height="402" layout="responsive" src="//labs.tomasino.org/assets/images/elfnamegenerator.jpg" alt="Elf Name Generator"></amp-img>

This might be the nerdiest of all lab projects, but hey, I'm a big nerd.
Wanna make somethin' of it? :)

I found some nice written resource about how to generate elf names from
a variety of stems & roots with different meanings. The spreadsheets
were extensive and I said to myself, this should be automated! Tada, now
it is.

Take a look at the XML file and you'll see you can define the way the
strings are generated. I also have a little check in there to avoid
doubled letters in combinations of things like "ade" and "ele". That
should make "adele" not "adeele", and now it does!

Nerds, [click here for Source & Project][].

  [click here for Source & Project]: //github.com/jamestomasino/elvishnames/
    "Elf Name Generator"
