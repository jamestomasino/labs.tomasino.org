---
url: "/for-parents"
comments: true
date: 2015-04-09T00:00:00Z
excerpt: Creating an infinite-scroll photo gallery in Python using the Flickr API.
tags: python flickrapi gallery
title: For Parents
---

My son was born in the summer of 2012, capping off one of my most intense years. He was a month early, arriving the very night after being blessed in the womb by over one hundred Jesuit priests. Despite not having the crib assembled, we weren't completely caught off guard. For one thing, my camera was charged and ready to go.

Photos of the kid completely took over my Flickr account. Where once you might find artistic shots of shadows across empty parks, now there was a chubby faced little boy. It's one of the many wonders of being a new parent. You take thousands of pictures that most folks will only glance at out of politeness, but still there is an enormous pride and joy in seeing them for yourself.

The number one audience for my son's pictures is our parents. Grandparents love pictures of their grandkids. It's their God-given right to see them as much as possible and to proudly tout them to their friends. This is fairly simple if one's parents are local, or if you send prints, but what happens when your family isn't all that savvy at browsing Flickr?

I'm a developer and a developer solves problems. Here was a very simple issue:

>My parents need a very simple interface to see pictures of my son. They only care about pictures of him, not my entire collection. They may look at these pictures on their phones or on the computer. The site should update automatically and involve as little work as possible by me to maintain it.

That's not a hard solve when you get right down to it. What I decided to do was pull in my photos of my son from Flickr using their API and display the results in a single column infinite-scrolling website. For videos, I host my content on Vimeo, which I feel has a much better quality than YouTube and sees far fewer comment trolls. [Here](//wit.tomasino.org) is the final site.

Toggling between pictures and videos is done with the icon in the top left corner. Each page follows the same rules: responsive display of content, scrolling to see more. Finally, in the header of the home page I added a tiny bit of JavaScript to display my boy's current age in either weeks, months, or years (appropriately for his total age).

There were some challenges, especially with Flickr. First of all, when querying a set or album in Flickr's API, the result is nice enough to give you the id of the image, but not the URL for the actual image source. Therefore, you have to waste two API calls before you can get the image. Knowing which size you're getting is a little tricky too. I decided to handle this in Python, which has a really friendly Flickr API library and is frankly a joy to write in.

``` python
flickr = flickrapi.FlickrAPI(config.get_api_key(), config.get_api_secret())
set = flickr.walk_set(config.get_set_id(), 500)
```

Getting a set is a pretty simple affair. It's backwards, of course, because nothing is easy.

``` python
rev_set = list(set)[::-1]
```

But python makes working with lists early.

In my Python script, I decided I'd go ahead and cache the direct URLs for the images that are requested into a local sqlite3 database. Instead of wasting a ton of API calls for the same thing again and again, I can do a quick lookup in the table to see if I have the info already, then just request the new bits. Doing this server-side means only the first person to access the list will make the request and store it. It was surprisingly easy to set up in Python as well.

``` python
con = lite.connect('web.db')
cur = con.cursor()
sql = 'CREATE TABLE IF NOT EXISTS photos ( Id TEXT PRIMARY KEY, Source TEXT )'
cur.execute(sql)
```

Getting Python to run on the server is a little pain in the butt, too, but I won't get into that here. Suffice to say, once I can properly format and respond back with a JSON feed of the images I want to display, jQuery can take that and put it to work.

``` javascript
function getPage ( page ) {
	$.getJSON ('flickr.py?page=' + page, function (data) {
		var photos = data.photos;
		for (var i=0; i < photos.length; ++i ) {
			var photo = photos[i];
			var img = $('<img></img>');
			var ahref= $('<a></a>');
			img.attr('src', photo.source );
			img.attr('alt', photo.photo_title);
			ahref.attr('href', 'http://www.flickr.com/photos/' + photo.photo_owner + '/' + photo.photo_id + '/');
			ahref.attr('data-label', photo.photo_title);
			ahref.append(img);
			$('#images').append(ahref);
		}
		if (!isScrollListenerActive) {
			$('#loading').hide();
			setTimeout( addScrollListener, 2000 );
		}
	})
}
```

I've wrapped this method up with a faux pagination implementation. Adding a really simple scroll listener allows me to detect if we've scrolled to the bottom of the display. If so, bam, next page loads. Infinite scrolling in 6 or 7 lines of code.

That's really all there is to it. The photo site loads quickly and works across devices. I bookmarked it on the home screen of my mom's cell phone and now she can see the latest pictures any time she wants.

The video portion of the page is even easier. Vimeo provides an RSS feed of albums, so getting that working in JavaScript was just a matter of converting XML to JSON.

``` php
class XMLtoJSON {
	public function Parse ($url) {

		$fileContents = file_get_contents($url);
		$fileContents = str_replace(array("\n", "\r", "\t"), '', $fileContents);
		$fileContents = trim(str_replace('"', "'", $fileContents));
		$simpleXML = simplexml_load_string($fileContents);
		$json = json_encode($simpleXML);
		return $json;
	}
}

header('Content-Type: application/json');
print XMLtoJSON::Parse("http://vimeo.com/album/2286122/rss");
```

I found the class portion of this code with a quick google search on converting XML to JSON. Toss in a header and output the results, done.

Vimeo does have one annoying quirk. When you make the request to embed the player on your page, you need to tell it the width of the video or it can be a little ridiculous.

``` javascript
var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
width = Math.min(640, width);
var url = '//www.vimeo.com/api/oembed.json?url=' +encodeURIComponent(videoUrl) + '&callback=embedVideo&width=' + width;
```

Frankly there's nothing innovative here. I used Python for half the site and PHP for the other. There's no rhyme or reason to it, and my code isn't particularly elegant. Still, it was a very effective solution to my little problem. That counts for something.
