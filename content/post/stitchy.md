---
date: 2019-12-31 17:13:03 +0000
title: "Stitchy"
url: "/stitchy"
tags:
---

During this slow week between Christmas and New Years my wife wanted to
crochet a lap blanket for my son. She had picked out a cute image of a sea
turtle. I noticed her sitting at the kitchen table with a piece of graph
paper taped over the turtle image. She was carefully filling in grid boxes
with the colors of her choice, all in preparation for this project.

It's not the first time I'd caught her doing something like this. The
process is painstaking but I just thought it was something she enjoyed.
Crochet, after all, is a repetitive process. I thought that was part of
the charm for her. It was not.

Later that day she asked me if I knew a way I could do the job in
Photoshop (note: I use [Photopea](https://www.photopea.com/)). I thought
about what was involved and figured it was doable, but as we sat and had
dinner I let the idea run around in my head a bit more. What if I could
automate the process for her?

She gave me some feedback on what she needed:

- Define the size of the grid height and width in "blocks"
- Layout the image on the grid
- Flatten it down to use the right colors in each grid block

I was pretty sure I could manage that using HTML Canvas, so I set out to
build it.

[Stitchy](https://jamestomasino.github.io/stitchy) is the result of that
build. In the process I discovered a few additional features that were
needed and implemented them as well.

{{< figure src="https://labs.tomasino.org/assets/images/seaturtle.png" alt="Sea Turtle Crochet Pattern" >}}

Dealing with the colors was the biggest challenge. In my first iteration
I cheated a bit by reading the pixel value directly in the center of each
grid block. That was my color for that square, and I used it to draw
a replacement grid on top. It worked, but it gave far too many colors for
crochet work, especially when there were gradients.

Instead I needed to get the average color from the square. That's not so
hard, really.

```javascript
// Get reference to raw canvas object in Konva
var content = document.querySelector('.konvajs-content')
var canvas = content.getElementsByTagName('canvas')[0]
var ctx = canvas.getContext('2d')

for (var i = 0; i < gw; ++i) {
    for (var j = 0; j < gh; ++j) {

      // Accumulators for the parts of the colors
      let R = 0
      let G = 0
      let B = 0
      let A = 0

      // Mobile devices threw off my math because of the pixel density.
      // Using devicePixelRatio fixes that calculation.
      const data = ctx.getImageData(i * hInc * window.devicePixelRatio, j * vInc * window.devicePixelRatio, hInc * window.devicePixelRatio, vInc * window.devicePixelRatio).data

      const components = data.length
      for (let i = 0; i < components; i += 4) {
        // A single pixel (R, G, B, A) will take 4 positions in the array:
        const r = data[i]
        const g = data[i + 1]
        const b = data[i + 2]
        const a = data[i + 3]
        // Add the color parts to our accumulator
        R += r
        G += g
        B += b
        A += a
      }

      // Then divide the total by the number of components (or pixels)
      const pixelsPerChannel = components / 4
      R = R / pixelsPerChannel | 0
      G = G / pixelsPerChannel | 0
      B = B / pixelsPerChannel | 0
      A = A / pixelsPerChannel / 255
      // …
    }
}
```

Once I had the average color in each block I store it in a 2D array.
I don't want to just use that, but rather I want to flatten the image to
only a fixed number of colors. The math on that was a bit more than I felt
like taking on for a weekend project, but thankfully I found a 3rd party
library, [ColorThief](https://github.com/lokesh/color-thief). Using that,
I was able to figure out the dominant colors in my image.

[nearest-color](https://github.com/dtao/nearest-color) is another library
I ran across. I used this to take my grid colors and figure out which of
the dominant colors was closest. Then I just substitute! Easy, right?

Finally I render the grid to the screen and everything looks awesome.

It was about this point that I realized two things:

1. I should probably give the user some way to tweak the colors after
   everything is rendered, just in case a pixel or two aren't quite right.
   I settled on making the grid clickable. Clicking just cycles that grid
   block through the list of dominant colors. Click-to-Fix!
2. If I hid the grid lines, this is a really cool way to make pixel art!

{{< figure src="https://labs.tomasino.org/assets/images/heart.png" alt="PixelArt Heart" >}}

If you are a crocheter or knitter,
[check it out](https://jamestomasino.github.io/stitchy) and let me know
how it works for you.

If you're a pixel artist, also hit me up with your creations. I'd love to
see what you can build.

If you're a coder and want to play with the code,
[go for it](https://github.com/jamestomasino/stitchy)!

<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
