---
date: 2022-02-03 16:59:46 +0000
title: "scroll-frame"
url: "/scroll-frame"
tags:
---

Today I published my first npm package. That feels weird to say, but I've just
never bothered contributing back my individual code features into the node
ecosystem before. I hope to do more of it soon.

[This npm package](https://www.npmjs.com/package/@jamestomasino/scroll-frame) is
called `@jamestomasino/scroll-frame` and it marries the features of
`requestAnimationFrame` with a scroll listener.

A common pattern I run into is the desire to run some code when the browser is
scrolling. In the past we used to set up scroll event listeners. Later we
learned to debounce these listeners to keep things sane. Later still we got
access to `requestAnimationFrame` and people did away with scroll listeners
altogether. That method is pretty light on resources and gives us a great update
resolution. But in those situations where I'm using it specifically for handling
scroll behaviors I don't want it processing my callback functions over-and-over
when the browser window is still.

The solution is simple: check if the browser changed its scroll position since
last frame. If not, skip it. If so, run the callbacks. And that's what this
little package does. It wraps it all up nicely and encapsulates the loop
management and exposes two functions: `addScrollListener` and
`removeScrollListener`. They each take one parameter, a callback function. This
package will reuse the same `requestAnimationFrame` loop and process all the
callbacks that have been registered when the scroll position changes.

I've avoided using some of the newer object methods on Array in order to keep
browser support pretty wide. This will work back to IE10.

Things I'm thinking of adding:

* optional second parameter that makes the callback binding weak. If the
callback is triggered and it throws an error, if "weak" I'll remove it from the
callback list going forward and the app will continue.

* um, well, that's it so far.

Have any ideas? Comments? Hate my code? [Throw a PR on
there](https://github.com/jamestomasino/scroll-frame) or chat me up.

<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
