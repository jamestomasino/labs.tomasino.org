---
date: 2019-08-21 16:53:48 +0000
title: "FlashForge Finder with Cura"
url: "/flashforge-finder-with-cura"
tags:
  - 3D Printing
---

{{< figure src="/assets/images/flashforge-finder.gif" alt="FlashForge Finder" >}}


I brought my 3D printer with us to
[Iceland](https://blog.tomasino.org/tags/iceland). My rationale was it's
expensive to ship small things here, and so being able to print my own
would save us the effort. There was only one small complication. In our
old house I had the printer software installed on my Windows PC, since
that's what the bundled software runs on. I didn't move the Windows
machine with us, though. We're 100% linux in this apartment, and so
I needed to be a little bit creative.

Flashforge's bundled software was the only software I was able to make
work reliably in the past, which is unfortunate with such fantastic
slicers available. In particular I really wanted to use Cura, which gets
excellent reviews.

Today is a new day, though, so I figure I'll give it another shot. After
all, it seems much easier than trying to get the other software to run
under Wine.


{{< figure src="/assets/images/flashforge-finder-settings.png" alt="FlashForge Finder Settings" >}}

There are a few forum postings with people requesting the settings to use
FlashForge Finder in Cura as a manual printer, but I couldn't find any
working replies. The closest I came was one person who posted their
settings (above). They also included a bunch of G-code that didn't work,
which I've trimmed.

The real meat & potatoes of a printer configuration in Cura is the G-code
that starts and ends the print. I really didn't want to have to learn to
write this stuff manually (spoiler: I still did, a bit), so I dug around
for other sources that might provide me a good starting point.

I found what I was looking for on
[TinkerCAD](https://www.tinkercad.com/)! The FlashForge Finder has this
nifty integration with [Polar Cloud](https://polar3d.com), which saves me
the trouble of running a USB cable to my laptop across the room. Polar
Cloud was so kind as to inform me that it has integrations to print
directly from TinkerCAD for the FlashForge Finder. This set off the alarm
bells. If it can print to my printer, it MUST know the G-code to use.


{{< figure src="/assets/images/flashforge-finder-settings-full.png" alt="FlashForge Finder Settings" >}}

I grabbed the start and end codes from TinkerCAD and it almost worked,
honestly. Unfortunately I kept facing a weird issue where it would print
fine for a minute and then fail to extrude. After some debugging
I realized that the printer was heating up the extruder, but not keeping
it hot during the print. The culprit was the heat setting variable that
TinkerCAD uses vs Cura. Once I fixed that I was pretty much there.

## Start Code

```conf
xgcode 1.0
;start gcode
M140 S0
M104 S{material_print_temperature} T0
M104 S0 T1
M107
G90
G28
M132 X Y Z A B
G1 Z50.00 F400
G161 X Y F3300
M6 T0
M907 X100 Y100 Z40 A80 B20
M108 T0
G1 Z.20 F400
```

## End Code

```conf
M104 S0 T0
G28 X Y
M132 X Y Z A B
G91
M18
```

You'll notice in the screenshot above I set my filament size to 1.75mm
instead of the default in Cura. Finally, in my project settings I enabled
the visibility of the default temperature setting and changed it to 220°C
instead of the default 200°C and set the flow to overflow at 110% to
smooth out my prints. These may be specific settings to the individual
printer, though, and your mileage may vary.

So, there it is: Cura settings that actually work with FlashForge Finder.
Go forth and create!

{{< peertube "toobnix.org" "f6853c15-39cf-4312-8182-6f77096b9b2a" >}}
