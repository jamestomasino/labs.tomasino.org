---
url: "/the-vic-cipher"
date: 2011-08-20T00:00:00Z
excerpt: An experiment to recreate the famous VIC cipher encoders and decoders using
  Flash AS3.
title: The VIC Cipher
tags:
  - cryptography
---

A [while back][] I had mentioned that I was working on a bigger cipher
project. This is it!

For me, the VIC Cipher represents the ultimate challenge in hand-created
cryptography. It is the epitome of thousands of years of code
development and one of (if not the) last functional hand-created cipher
before the advent of computers. In a way, the VIC is a collection of
other ciphers: [lagged fibonacci generators][], sequential substitution,
digit-based (non-carrying) addition & subtraction, [straddling
checkerboards][while back], and various types of [transpositions][].

If you want to know all about this amazing feat of code-making, here's
the full story from the CIA: [link.][]

Before I continue, I need to put a special thanks out to "raincomplex"
over at everything2.com whose [extremely detailed post][] really enabled
me to build this. If you'd like to try encoding or decoding a message
with VIC cipher by hand, I recommend you follow his instructions.

1) How to encode a message
--------------------------

To encode a message you will need to memorize three bits of information.
Luckily, they're all quite simple mnemonics!

1.  A song lyric that has at least (20) characters in it, not counting
    spaces or punctuation.
2.  A date. It will be formatted as dd/mm/yyyy with no leading 0's.
3.  A personal ID number. It needs to be between 0 and 16. (The math
    just works out that way)

Finally, each message will have a 5 digit random number added in. You
don't need to remember this after sending the message, and the recipient
doesn't need to know it in advance. So, if you can remember those three
things above, and pick 5 digits, you can send a message! Let's try it.
You can type anything you want, but only letters, numbers, and the
period (full stop) characters will be saved. (That's flash below, not an
image. You can try it right here!)

[Vic Cipher Source](//github.com/jamestomasino/Vic)

~~In the latest versions of
Flash, Adobe has removed the Date Chooser component. As a result, and
due to my laziness, I'm using one I found [here][]. It does a decent job
and remains fairly light-weight. Still, it's a bit limiting when
changing years. I should really look around for something more feature
rich.~~

**Update:**
*Thanks to Carl Leiner the VIC Coders now have an awesome Date Chooser
that can quickly update the year based on your typed input, or by the
more familiar expanded calendar. Thanks Carl! Awesome work.*

If you look carefully at your generated code, you'll notice that (5)
digit random message ID you added can be found in plain text near the
end of the code. Its position is determined by the last digit of the
date. Cool, right? Ok... lets look at decoding.

The requirements to decode are the same as those to encode. As long as
your keys match up, you should have no problems. Your message may have
some extra characters at the end. This jibberish is called "null
characters" in code-speak. It's just there so our numeric code is always
in pretty units of 5 digits. If you don't see any jibberish, it's
because your message already fit into groups of five perfectly.

And that's it, folks. A VIC Cipher encoder / decoder written in AS3.
Why, you might ask--I have no idea. It just seemed like a lot of fun.
Now, get encoding. Leave me some coded comments on this post. :)

All the source for this lab project can be found [here][1]. All the
libraries for the encoding can be found at my GIT repository [here][2].

  [while back]: //labs.tomasino.org/straddling-checkerboard/
    "Straddling Checkerboard"
  [lagged fibonacci generators]: //en.wikipedia.org/wiki/Lagged_Fibonacci_generator
    "Lagged Fibonacci Generator"
  [transpositions]: //en.wikipedia.org/wiki/Transposition_cipher
    "Transposition Cipher"
  [link.]: //www.cia.gov/library/center-for-the-study-of-intelligence/kent-csi/vol5no4/html/v05i4a09p_0001.htm
    "VIC Cipher at CIA.gov"
  [extremely detailed post]: //everything2.com/user/raincomplex/writeups/VIC+cipher
    "VIC Cipher"
  [here]: //www.sickworks.com/tools/DateChooser/
    "Sickworks' AS3 Date Chooser"
  [1]: //github.com/jamestomasino/vic
    "VIC Cipher Lab Project"
  [2]: //github.com/jamestomasino/tomasino/tree/master/org/tomasino/encoding
    "Encoding Package"
