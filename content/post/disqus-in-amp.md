---
url: "/disqus-in-amp"
comments: true
date: 2016-08-25T12:30:11Z
excerpt: Enabling comments in AMP pages
title: Disqus in Amp
tags:
  - comments
---

As a follow up to my [previous post][] where I converted this blog to take advantage of the [AMP Project][], I've finally managed to reintegrate [comments][]. I wasn't expecting this to be nearly as difficult as it was, but a few barriers quickly popped up.

- AMP doesn't allow 3rd party javascript
- No `comments` component yet created
- IFrame support is tricky

Ok, so it's hard. So what?

> &ldquo;Nothing in the world is worth having or worth doing unless it means effort, pain, difficulty… I have never in my life envied a human being who led an easy life. I have envied a great many people who led difficult lives and led them well.&rdquo; &mdash; Theodore Roosevelt

## Make it so

I scoured [StackOverflow][] and dug around on the AMP forums for solutions. There were two camps of opinions:

1. It can't be done since you can't have custom JS
2. It can be done, probably, with the `iframe` component

Not surprisingly, I favored opinion #2!

My first go-around I attempted to bypass the need for JavaScript on my side by embedding Disqus comments in the normal way, but in the `iframe`. That blew up spectacularly. Next I tried taking the HTML output from a proper Disqus embed and shoving that into a Jekyll template and duct taping it into an IFrame. Somehow that magic didn't work out either.

Finally I found a breakthrough. One commenter on the AMP forums asked a question about domain challenges he was hitting while attempting to do exactly what I was doing. He dropped off the comment thread after a bit and I got suspicious. Why would he leave unless he figured it out?

Enter [Nemo64][] and his blog [Die Marco Zone][]. Marco's website was attempting to implement AMP pages as alternate views rather than the entire site like I'm doing here. Still, he wanted the comments to be enabled in that format as well. I dug around in his code and found what looked like an almost working solution.

I pulled out pieces and tweaked them to fit my needs. Here's the rundown of the changes I made:

### HTML Template changes

First I needed to add the `iframe` component. I only need it on posts, so I added a little Liquid test.

``` html
{{ "{%" }} if page.layout == 'post' %}
<script async custom-element="iframe" src="https://cdn.ampproject.org/v0/iframe-0.1.js"></script>
{{ "{%" }} endif %}
```

Next I needed a template that would become the content of my IFrame for each post. This is almost verbatim from Marco, and brilliantly done. The resizing portion was especially helpful. I did add one minor test to make sure we don't send any resize messages to the container if they are under 100px in height as that makes AMP throw console errors.

``` html
---
sitemap: false
---
<!DOCTYPE html>
<html lang='{{ "{{" }} page.language }}'>

    <head>

        <meta charset="utf-8">
        <title>{{ "{{" }} page.title }}</title>
        <meta name="viewport" content="width=device-width,minimum-scale=1">
        <style>
            html, body {
                margin: 0;
                padding: 0;
            }
        </style>

    </head>

    <body>

        <div id="disqus_thread"></div>
        {% assign url = page.url | replace: '/disqus','' %}
        <script>
            var disqus_config = function () {
                this.page.url = '{{ "{{" }} url | prepend: site.baseurl | prepend: site.url }}';
                this.page.identifier = '{{ "{{" }} url }}';
            };

            (function () {  // DON'T EDIT BELOW THIS LINE
                var d = document, s = d.createElement('script');

                s.src = '//{{ "{{" }} site.disqus_name }}.disqus.com/embed.js';

                s.setAttribute('data-timestamp', +new Date());
                (d.head || d.body).appendChild(s);
            })();

            (function () {
                function checkSizeChange() {
                    var viewportHeight = window.innerHeight;
                    var contentHeight = document.getElementById('disqus_thread').clientHeight;
					if (viewportHeight !== contentHeight && contentHeight > 100) {
                        window.parent.postMessage({
                            sentinel: 'amp',
                            type: 'embed-size',
                            height: contentHeight
                        }, '*')
                    }
                }

                var mutationObserverAvailable = typeof window.MutationObserver === 'function';

                function bindObserver() {
                    var frame = document.getElementsByTagName('iframe')[0];

                    // if the frame is not available yet try again later
                    if (frame === null || frame === undefined) {
                        setTimeout(bindObserver, 200);
                        return;
                    }

                    // check the size now since the frame is now available
                    checkSizeChange();

                    var resizeObserver = new MutationObserver(checkSizeChange);
                    resizeObserver.observe(frame, {
                        attributes: true,
                        attributeFilter: ['style']
                    });
                }

                // use mutation observers to quickly change the size of the iframe
                if (mutationObserverAvailable) {
                    bindObserver();
                }

                // also check periodically for the size of the frame
                setInterval(checkSizeChange, mutationObserverAvailable ? 5000 : 500);
            })();
        </script>

    </body>

</html>
```

For the last bit of HTML, I needed to actually add the IFrame code to my Post layout.

``` html
<section class="post-comments" id="comments">
	<iframe
		height="300"
		sandbox="allow-forms allow-modals allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts"
		resizable
		frameborder="0"
		src="{{ "{{" }} page.url | prepend: '/disqus' | prepend: site.baseurl | prepend: site.alt_url }}">
		<div overflow tabindex="0" role="button" aria-label="Read more">Read more!</div>
	</iframe>
</section>
```

### Configuration

I'm not hard-coding my Disqus user name into these scripts, so I had to add it to my configuration file.

``` yaml
disqus_name: superlabsblog
```

### Ruby plugin

Finally I needed to add a Generator class and plugin to create all these individual HTML pages for the IFrames. This got a little tricky since `site.posts` has changed in the API and I couldn't find any good documentation. A little trial and error got me through.

``` ruby
module Jekyll

  class DisqusPage < Page
    def initialize(site, base, post)
      @site = site
      @base = base
      @dir = File.dirname(File.join('disqus', post.url))
      @name = File.basename(post.destination('/'))

      self.process(@name)
      self.read_yaml(File.join(base, '_special'), 'disqus.html')
      self.data['related_page'] = post
      self.data['title'] = post.data['title']
    end
  end

  class DisqusPageGenerator < Generator
    safe true

    def generate(site)
      site.posts.docs.each do |post|
        site.pages << DisqusPage.new(site, site.source, post)
      end
    end
  end

end
```

### The Great Domain Debacle

With all this code in place (actually the code above is the final working version. The few tweaks described below were added in) I figured I was golden. I had the HTML content for the IFrames generating properly. I had my templates in place and Liquid pulling things through correctly. I opened up my site to test it out and... nothing.

Here's where I caught up with Marco. Due to some quirks of `iframe` (I will assume the reasoning is legitimate and wise being that I read the explanations and understood almost none of it) I was unable to have my IFrame load content from the same domain that was serving my AMP content. In not-so-many words, my IFrames can't be on labs.tomasino.org.

I looked back at what Marco had done and there it was, he'd created another domain to host the generated IFrame html pages.

Well, I run this site on Amazon EC2 with a wildcard SSL cert for tomasino.org, so adding a new subdomain took only a minute. I created https://labscomments.tomasino.org and mapped it to the exact same folder as this blog, updated the IFrame source to look there instead and PRESTO CHANGE-O, we were in business.

As you can see below, we're able to comment now.

### Cleanup

The generation of these new HTML pages does make them show up in your Sitemap.xml file if you're using `jekyll-sitemap` like I am. The little `sitemap: false` you see above in the HTML template fixes that.

I also need to tweak some `.htaccess` rules to hide directory indexes for the disqus folder of html, and I think I'll add a rewrite for any traffic trying to link directly to the wrong domain.

It was a [beast and a half][], but it's done. Please, please comment below so that this was all worth it.

_Oh, and as always, the source for this entire site is available [on Github]._


## UPDATE 2016-08-27

Thanks to a helpful comment below, the `disqus.html` example above can be greatly simplified, and performance increased, by listening for the resize message sent by Disqus itself rather than polling for changes. It can be implemented by removing the entire function beginning with:

``` javascript
(function () {
	function checkSizeChange() {
```

And replacing it with:

``` javascript
window.addEventListener("message", receiveMessage, false);
function receiveMessage(event)
{
	if (event.data) {
		try {
			JSON.parse(event.data);
		} catch (e) {
			return false;
		}
		var msg = JSON.parse(event.data);
		if (msg.name == 'resize') {
			window.parent.postMessage({
				sentinel: 'amp',
				type: 'embed-size',
				height: msg.data.height
			}, '*');
		}
	}
}
```

Thanks [Webrender][]!

## UPDATE 2016-09-18

Thanks to the fantastic [Dan Goldin][] I was able to remove the entire generation of amp comment iFrame pages and instead point to a single dynamic [page on an s3 bucket][]. Currently I'm "borrowing" his page, but I'll likely dupe it to my own s3 instance in the near future and see if I can improve it even more. It's my turn after all, right Dan?

Due to an unforeseen string replacement snafu in the old method, the Disqus identifier for this page and only this page was screwed up. I'm attempting to migrate the comments over to this correct URL, but in the meantime comment history may be missing. I'm going to lock comments below until I can get it sorted out.

## UPDATE 2017-01-22

I've finally gotten around to self-hosting my comment iFrame at https://comments.tomasino.org. You can [view the source][] to grab my latest iteration, or point directly to my page. To use it in your own sites, you only have to construct the iframe tag with a few query parameters. Here's my version:


``` html
<section class="post-comments" id="comments">
	<iframe
		height="300"
		sandbox="allow-forms allow-modals allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts"
		resizable
		frameborder="0"
		src="https://comments.tomasino.org?disqus_title={{ page.title | cgi_escape}}&url={{ page.url | prepend: site.baseurl | prepend: site.url | cgi_escape }}&disqus_name=https%3A%2F%2F{{ site.disqus_name }}.disqus.com%2Fembed.js">
		<div overflow tabindex="0" role="button" aria-label="Read more">Read more!</div>
	</iframe>
</section>
```

As long as you pass along `disqus_title` (title of your article), `url` (url of your article), and `disqus_name` (a full url to your disqus embed js file) it will work. You can also pass along an optional `identifier` parameter if you don't use URLs for that purpose in Disqus. Since my blog is using Jekyll, my parameters are being escaped in the Liquid templates using `cgi_escape`. If you're passing parameters yourself, just be sure to make them URI friendly.

  [previous post]: https://labs.tomasino.org/amp/
    "AMP Pages | Tomasino Labs"
  [AMP Project]: https://www.ampproject.org/
    "Accelerated Moblie Pages Project"
  [comments]: http://disqus.com/
    "Disqus"
  [StackOverflow]: https://stackoverflow.com
    "Stack Overflow"
  [Nemo64]: https://github.com/Nemo64
    "Marco Pfeiffer's Github Page"
  [Die Marco Zone]: https://www.marco.zone/
    "Die Marco Zone (German)"
  [beast and a half]: http://amzn.to/2bS2JGX
    "A Giraffe and a Half by Shel Silverstein"
  [on Github]: https://github.com/jamestomasino/labs.tomasino.org
    "Tomasino Labs on Github"
  [Webrender]: https://disqus.com/by/webrender/
    "Webrender user on Disqus"
  [Dan Goldin]: https://twitter.com/dangoldin
    "Dan Goldin on Twitter"
  [page on an s3 bucket]: https://s3.amazonaws.com/dangoldin.com/disqus.html
    "Dan Goldin's hosted s3 Disqus Amp interface"
  [view the source]: https://comments.tomasino.org/
    "View source of Comment iFrame"
