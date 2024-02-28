---
date: 2024-02-28 10:09:07 +0000
title: "Cookie Consent with Google Consent Mode V2"
url: "/cookie-consent-with-google-consent-mode-v2"
tags:
  - analytics
  - tracking
  - google
---

Next month Google is rolling out Consent Mode V2 for Google Tags in Europe and
applicable other markets around the globe. In brief, this is a change to how
cookie consent and "don't sell my data" directives are handled in relation to
Google tags. There are two parts to be aware of:

1. The mechanism of validating whether tags can transmit or store data is
   changing to use Google's new internal mechanism and definitions (more on what
   these are below).

2. If the "advanced mode" is configured, Google will still track anonymous
   action data even when people have opted out. This part is highly questionable
   and will almost certainly see court action in the EU in years to come.

## Why should I care?

If you're using Google analytics, Google Ads, or anything related (eg,
retargeting) this will probably affect you even if you aren't in the EU. Google
seems to be going heavy-handed on these changes, assuming if you don't set up
Consent Mode properly that you don't have consent. That could throttle your data
collection in a very significant way starting next month.

But what if you already have cookie consent configured? If you're using
a platform like OneTrust or CookieInformation then your platform has probably
been gearing up for this change already. Some are rolling out the changed
implementation automatically while others require a checkbox to be set.
Unfortunately all of these platforms differ slightly on how they have been
implementing this logic, and the move to Google's method may not be obvious on
what needs to change. You may be using more data-capturing than just Google's
offerings, after all.

If you have tags going to Adobe Analytics, for instance, your cookie consent
solution will still need to provide the same sort of technical solutions they
have in the past. We're now going to face a fragmentation as Google throws
weight around forcing a combination of efforts.

And there's also the possibility that you aren't using one of these paid cookie
consent platforms at all and you're trying to handle this yourself. If that's
you, definitely read on.

## So what do I do?

If everything is going into Google Tag Manager then your pathway is pretty
clear. You'll want to adopt this Consent Mode V2 shenanigans in your banner code
on your website and make sure that the consent settings are making their way
into GTM properly.

There is a fairly comprehensive [overview of this setup available here](https://www.simoahava.com/analytics/consent-mode-v2-google-tags/).

And Google's own help is not complete trash this time around. There's a great
[overview video about Tag manager consent
mode](https://support.google.com/tagmanager/answer/10718549?hl=en) in the help
which walks through implementing a working solution from scratch.

If you're facing a more complex setup with several non-Google services, or data
collection that happens outside of Google's ecosystem then you're going to need
to work with your specific cookie consent solution to ensure you cover all your
bases. If you have Facebook tags getting dropped via GTM, however, you can
continue with the Google-centric approach.

## So what exactly is Consent Mode V2?

Google's consent mode is a combination of "granted/denied" settings related to
various types of consent and data storage. The mechanism for choosing these is
left to the implementation, but the signals must be sent to GTM via the
dataLayer in two phases.

First, the "default" settings should be put into the dataLayer before GTM is
loaded. These will be set during GTM's Consent Initialization Phase, before
normal tagging takes place.

Next, the user's choices from the cookie banner can be passed along through an
update.

If this isn't the first visit you can pass the user's previous consent choices
directly in that default load. Perhaps you stored them in localStorage for the
future?

On the GTM side we need to enable Consent Mode (it's in Admin, Container
Settings). From there we can use the new shield icon in our Tags list to ensure
that each tag is aligned with the correct consent types and storage types (see
list below). If so, the choice to send/save data or not will happen
automatically by GTM.

One magic thing that *should* work is that your GTM data which is collecting in
a session prior to updating the consent mode should release once permission is
granted. This could help capture initial pageload information and acquisition
data which might have been otherwise lost if consent was required before the
first load data could be captured. (I've not yet verified that this is
happening.)

Another awesome things is that all the Google tags (Analytics, Ads, Floodlight)
have their consent mode configuration pre-set. If you're just using those you're
pretty much done! If you have other types of tags you'll need to set up which
consent settings need to be "granted" for the tag to fire. The great thing here
is that you don't need to change your triggers or set up special variables. The
settings apply directly to the tags. You can optionally require extra settings
if you want on your tags as well.

![Full Consent Settings](https://labs.tomasino.org/assets/images/full-consent-settings.jpg")

## What are these different consent and storage settings?

The naming convention for the various settings leaves a lot to be desired. It's
not clear at a glance what refers to actual storage settings vs consent, and
there's some overlapping behavior as well. Here's a breakdown:

```
Setting Name            Used by Google    Description
ad_storage              Yes               Enables storage (such as cookies) related to advertising
analytics_storage       Yes               Enables storage (such as cookies) related to analytics e.g. visit duration
ad_user_data            Yes               Whether Google’s services can use user data for building advertising audiences
ad_personalization      Yes               Whether Google’s services can use the data for remarketing
functionality_storage   No                Enables storage that supports the functionality of the website or app e.g. language settings
personalization_storage No                Enables storage related to personalization e.g. video recommendations
security_storage        No                Enables storage related to security such as authentication functionality, fraud prevention, and other user protection
```

### Lets talk details

First out of the gate lets clarify that even in the super-strict EU
`functionality_storage` and `security_storage` are both considered necessary for
functionality and don't require consent. You're perfectly fine leaving those out
of your consent banner and hard-coding them to 'granted'.

That final non-google storage setting, `personalization_storage` is on the lists
from Google but has no effect on any of their products. You are welcome to
collect it, but they word it as if they're providing examples of other things
you could request permission on. Add your own and use them to determine which
tags to fire, they say. So in that regard, if you were to not collect it because
it's not applicable to your site you're within your rights.

That leaves us the four google-specific consent settings. Two are about cookies
and two are about data collection. If you're looking for guidance on how to
prompt your users, I suggest `ad_storage` and `ad_user_data` both go under the
heading of "marketing", `analytics_storage` could be "analytics", and
`ad_personalization` as "partners".

This last one is worth some extra discussion. It deals with the resale of
personal information to 3rd parties for things like remarketing. Remember, even
sharing that user data with a 3rd party you are paying for is enough to trigger
this "resale" clause in some places. The California laws around ["Do not Sell My
Information"](https://labs.tomasino.org/ccpa-and-don-t-sell-my-information/)
come into play around this setting. As we've seen from lawsuits
already filed in that state, you will want to ensure your cookie banner solution
is also checking for the [Global Privacy
Control](https://labs.tomasino.org/respecting-gpc-and-dnt-in-gtm/) signal when
checking this setting. If the user "Agrees to all" but they have GPC set, you
should be setting ad_personalization to "denied" regardless.

To that end, DoNotTrack has been getting dusted off recently in some legal
discussions. You may want to check for that setting and respect it as a valid
"denied" choice for ad_storage, analytics_storage, and ad_user_data.

## What if I don't have a cookie banner?

I'm here for you. I find it really frustrating that there's all these pay
solutions for something that's really just a block of HTML, CSS, and Javascript.
There should be open source solutions for this sort of thing. So I made one.

[Cookie Consent](https://github.com/jamestomasino/cookieconsent) has the code
you'll need to get going on the front-end. I provide a JS and CSS file for the
cookie banner. I also have a sample index.html file in there that shows you how
to drop them into your project. With those two files in place you'll be relaying
the correct consent information to GTM in no time at all.

You're still going to need to enable Consent mode in GTM and ensure your tags
are set up properly. Here's a bit of what that looks like:

![Enable Consent Settings](https://labs.tomasino.org/assets/images/enable-consent-settings.png")

![Shield Consent Settings](https://labs.tomasino.org/assets/images/shield-consent-settings.png")

It's really that simple!

## Summary

This move by Google could be seen as consolidating a fractured area of web
development or it could be seen as yet-another-standard fracturing it further.
Microsoft is apparently looking to follow suit with something that's very
similar. And now that all the big banner players are forced to adopt this,
perhaps they'll change to be more interoperable.

The biggest unknown is that shady bit about how tracking can happen even when
permission is denied. No user data will be transferred, but there will still be
signals sent. More on that in the future!
