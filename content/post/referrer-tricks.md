---
date: 2019-07-21 18:25:22 -0400
title: "Referrer tricks"
url: "/referrer-tricks"
tags:
  - php
  - hack
---

I had a theoretical conversation with a coworker a few months back
where I posited that it should be possible to use the HTTP REFERER
(sic) header to determine if a link is coming from another site or
if it was an internal link between pages. In the later case, we
discussed hiding some elements in the site's header. The strategy
behind that is the introductory branding on the website was only
of value when initially reaching the page. When moving around
internally the content further down the page was the goal. If we
could hide some of that extra information we could streamline the
experience for users.

If the check failed, we'd just show everything. In theory it
should be pretty safe even if a user is doing something strange or
using an unexpected client.

Yesterday I put together a quick proof-of-concept test:

```php
<?php
  if(isset($_SERVER['HTTP_REFERER'])) {
    $host = parse_url($_SERVER['HTTP_REFERER'], PHP_URL_HOST);
    $name = parse_url($_SERVER['HTTP_HOST'], PHP_URL_HOST);
    if ($host === $name) {
      echo 'Internal Referrer';
    } else {
      echo 'External Referrer';
    }
  } else {
    echo 'External Referrer';
  }
?>
```

When I discussed the idea on [mastodon](https://mastodon.sdf.org),
one of my peers brought up the potential problem with caching. If
the site were to cache the page result on the server side
incorrectly, we could potentially serve the condensed site content
inappropriately.

Admittedly, server-side caching and how it relates to PHP on
various web servers is not a strong area for me, but the concept
sounds valid at a glance. I think there are two fairly trivial
solves for it.

1. The
   [Vary](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Vary)
   header could be set based on referer. That should differentiate caching
   based on our variable and solve things nicely. Both versions could be
   cached over time and help speed things up without risking serving bad
   content.

2. [ETAGS](https://whatis.techtarget.com/definition/entity-tag-Etag),
which I understand even less than normal caching stuff. Still, it
looks like it could get the job done.

I haven't put it into production anywhere yet. If you use the idea
in the wild, let me know. I'd love to hear how it turns out.


<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
