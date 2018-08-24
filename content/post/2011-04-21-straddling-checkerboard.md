---
date: 2011-04-21T00:00:00Z
excerpt: Exploring the early days of cryptography by recreating manual techniques
  using Flash AS3.
tags: as3 cryptography encode flash straddling-checkerboard
title: Straddling Checkerboard
---

Back in the ancient days before computers and the interweb, the
transmitting of secrets was an art. There were many masters, and many
more who claimed to be. Interestingly, most of the great ideas and
techniques followed the same basic formulas, and masters' claimed
innovations were often nothing more but a rehash of old techniques. Some
of these techniques formed the basic ciphers. (The word "cipher" or
"cypher" was the ancient term for zero. Many interesting theories exist
on how it gained its modern meaning.)

The basic ciphers (e.g., [substitution][], [transposition][], modular
rotation, p[olyalphabetic substitution][]) were developed early on, most
before the fall of the Roman Empire. Little was changed until the
renaissance, when advances in mathematics revealed the importance of
letter frequency, letter combinations, and other tell-tale patterns in
the art of codebreaking. The old substitution codes you're used to
seeing in the newspaper were suddenly easy to crack. Polyalphabetic
substitutions helped some, but were far from impregnable.

In what may be the first in a series of posts on traditional
cryptography (hand encoded/decoded), I would like to introduce you to
the [Straddling Checkerboard][], also known as a monome-dinome cipher.
This is one of the more elegant ciphers to come along, though not
perfectly secure. In fact, it is one of several combined components of
the infamous [VIC cipher][].

In this cipher, the characters are substituted by numbers using a grid.
High frequency letters, those that appear most often in English, are
placed in the first row and are thus written with single digits. This
cuts down on the length of the overall code in what's called
"compression". The rest of the characters fill in the next two lines,
with two special characters used signals to say that the following
character is a literal number. You can read all about how to encode and
decode the cipher [at the wiki page.][Straddling Checkerboard]

The above flash piece (yes, it's flash... you can use it right in this
page) generates a random straddling checkerboard key and handles the
encryption automatically. Type something into the message box in
plaintext and the code will be generated in ciphertext in the box below.

So why am I making this? So you can teach your kids how to use the
checkerboard and leave each other messages on your fridge! No, not
really, but that'd be cool. It's part of a bigger project that's even
nerdier, which I will reveal in the next post. Until then, enjoy writing
codes.

[Source & Example][]

  [substitution]: //en.wikipedia.org/wiki/Substitution_cipher
    "Substitution Cipher"
  [transposition]: //en.wikipedia.org/wiki/Transposition_cipher
    "Transposition Cipher"
  [olyalphabetic substitution]: //en.wikipedia.org/wiki/Polyalphabetic_substitution
    "Polyalphabetic Substitution"
  [Straddling Checkerboard]: //en.wikipedia.org/wiki/Straddling_checkerboard
    "Straddling Checkerboard"
  [VIC cipher]: //en.wikipedia.org/wiki/VIC_cipher "VIC cipher"
  [Source & Example]: //github.com/jamestomasino/straddlingcheckerboard/
    "Source & Example"
