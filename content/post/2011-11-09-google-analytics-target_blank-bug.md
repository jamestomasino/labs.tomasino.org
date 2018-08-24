---
date: 2011-11-09T00:00:00Z
excerpt: Patching a bug in Google Analytics related to target blank with jQuery and
  namespaced functions.
tags: google-analytics javascript jquery links tracking
title: Google Analytics target=_blank bug
---

There is a bug in GoogleAnalytics that causes links with target=_blank
to open a new window as well as navigating the current window to the new
link. This happens primarily in CMSs where you have the option to "Track
Outbound Links". Below is my solution to this problem.

First of all, my solution requires [jQuery][] (because if you're using
JavaScript, why would you use anything else).

Second, turn off "Track Outbound Links" if you have that option. We'll
do it manually.

Third, I've named my methods in such a way that they really shouldn't
collide with anything of yours.

Finally, I'm using namespaces on my click events so that I won't destroy
any other click events you might have on your links. My convention is to
make the namespace of the click equal the name of the method it calls.
It lends some semblance of organization to JS, I find.

``` javascript
jQuery(document).ready( google_analytics_documentready );

function google_analytics_documentready ($) {
	// unbind first in case we're doing weird stuff with ajax loading or
	whatevers.

	$('a[target=_blank]').unbind('click.google_analytics_trackoutbound');
	$('a[target=_blank]').bind('click.google_analytics_trackoutbound',
			google_analytics_trackoutbound );
}

function google_analytics_trackoutbound (e) {
	try {
		_gaq.push(["_trackEvent", "Outbound links", "Click", e.target.href]);
	}
	catch(err) { }
	return true;
}
```

Comments, as always, are welcome!

  [jQuery]: //jquery.com/ "jQuery"
