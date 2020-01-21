---
date: 2020-01-21 15:31:22 +0000
title: "prefers-color-scheme"
url: "/prefers-color-scheme"
tags:
  - hugo
  - css
---

{{< figure src="/assets/images/prefers-color-scheme.png" caption="Color Scheme Options">}}

I finally got around to implementing [prefers-color-scheme][] themes on
this blog, and [my personal one][]. I really love this new CSS feature and
I've been trying to take time to implement it everywhere I can.

Taking a look at the code for this site we can see that it's relatively
low-effort to make something look good. In my case the "default" theme is
light, with dark text on white. I only need to implement alternative code
for the dark theme using `prefers-color-scheme: dark`, like so:

```css
@media (prefers-color-scheme: dark) {
	body {
		background: #303030;
		color:#c1c1c1;
		font-weight: 400;
	}
	h3 {
		font-weight: 400;
	}
	a {
		color: white;
		text-shadow: 1px 1px 0 #303030, -1px 1px 0 #303030, 2px 0 0 #303030, -2px 0 0 #303030;
		transition: box-shadow 0.7s;
		box-shadow: 0 0 0 0 #303030, 0 1px 0 0 #97ecec;
	}
	a:hover {
		box-shadow: 0 0 0 0 #303030, 0 3px 0 0 aqua;
	}
	h1 a,
	h2 a,
	h3 a {
		transition: box-shadow 0.7s;
		box-shadow: 0 0 0 0 #303030, 0 1px 0 0 #97ecec;
	}

	h1 a:hover,
	h2 a:hover,
	h3 a:hover {
		box-shadow: 0 0 0 0 #303030, 0 3px 0 0 aqua;
	}
	#index li a,
	#tags li a {
		color: #888;
	}
	#back {
		color: #fff;
	}
	time {
		color: #888;
	}
}
```

Beyond color changes (and some box-shadows for fancy underline effects)
I also found I needed to lower the font-weight on most of my copy. Light
colored text on dark backgrounds has a bleeding halo effect that makes the
text appear more bold than it really is. Dropping things down to 400
weight on the brightest bits cleaned up most of the issues. I also moved
the fancy-pants underlines away from the text on the dark theme for
similar reasons. On the light theme it's really cool how descenders in the
links cut into the underline and punch it out. That effect is lost on the
dark theme, though. The brightness messes with your eye and it just seems
blurry. So, coolness aside, I just increased space a bit and tweaked the
hover animation.

Are you implementing prefers-color-scheme on any of your sites? Have you
seen it in use on anything corporate yet?

  [prefers-color-scheme]: https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme
  [my personal one]: https://blog.tomasino.org

<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
