---
date: 2023-06-23 22:45:34 +0000
title: "CCPA and Don't Sell My Information"
url: "/ccpa-and-don-t-sell-my-information"
tags:
  - CCPA
  - cookies
  - data
  - analytics
  - programming
  - web
---

{{< figure src="https://labs.tomasino.org/assets/images/ccpa.jpg" caption="Edited from a photo by Joshua Earle on Unsplash" link="https://unsplash.com/photos/XnDQ9uXILRE?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" >}}

The California Consumer Privacy Act (CCPA) is striking some fear into the hearts
of website operators in the US in much the same way that GDPR has done for
Europe. The law, while not quite as strict, has many of the same familiar
elements and restrictions upon data collection and usage. And it isn't alone.
Both Colorado and Connecticut have upcoming legislation akin to the California
act. Clearly California's landmark law will not be the end of this story.

## So what is the CCPA exactly?

In brief, it's an act which grants California citizens some rights regarding
their digital information. What rights?

1. access their personal information;
2. know what personal information businesses collect, keep, sell and share;
3. prevent the sale of their personal information; and
4. request that businesses delete their personal information.

## Who is required to comply?

The only organizations subject to CCPA are for-profit companies doing business in California that collect consumers' personal data and do the following:

Only for-profit companies doing business in California or with California
residents which do at least one of the following:

* have annual gross revenues of at least $25 million
* buy, sell, receive or share personal information from more than 50,000 individuals, households or devices for commercial purposes
* get at least half of their annual revenues from selling personal information

That's a lot of companies, but not a concern for your independent blog.

## Quick history?

The law came into being at the start of 2020, and was enforced as of July of
that year. If you find yourself on the wrong side of things, you have a 30 day
grace period to fix it. That's helpful, and in the first year about 75% of
companies hit by a penalty did just that. Others decided that the bite wasn't as
big as the bark. Penalties for CCPA are not nearly as severe as GDPR, and some
companies find the cost insignificant, or the resolution too costly to bother.

That may be starting to shift, however.

[Sephora's recent
case](https://oag.ca.gov/news/press-releases/attorney-general-bonta-announces-settlement-sephora-part-ongoing-enforcement)
ended with a $1.2 million settlement. That's got to hurt. And it came with some
warnings from the California Attorney General.

On Jan 1st of 2023 the 30-day grace period that saved so many early on has
expired. Along with it so did the state AG's patience. More aggressive
enforcement is to be expected.

We also learned some interesting insights into the governmental interpretation
of compliance. Notably the [Global Privacy
Control](https://globalprivacycontrol.org/) (GPC) was mentioned 10 times.

## What's the GPC?

> The GPC is a browser setting that notifies websites of a user's privacy
> preferences, such as not to share or sell personal data without their consent,
> by sending a signal to each website a user visits. -- Onetrust

If that sounds familiar it's because it's been re-invented about 6 times now by
various parties. The most famous was the really-good-idea-without-any-teeth,
["Do Not
Track"](https://www.wired.com/2012/10/yahoo-microsoft-tiff-highlights-the-epic-failure-of-do-not-track/).
In fact, some of the brainpower involved in that effort helped GPC get going.

This time the work was spearheaded by the Electronic Frontier Foundation (EFF)
and Duck Duck Go and has a [public
specification](https://privacycg.github.io/gpc-spec/). But most importantly it
has legislation backing it's requirement. California clearly sees it as
fundamental to the implementation of its act. Colorado and Connecticut mention
it by name in their laws which should come out in 2024 and 2025 respectively.

## Growing regulation

The CCPA allows for California to enact and expand regulations to implement the
act. Those rules have been shifting slightly since its launch, and in the
November 2022 draft regulation updates some new considerations were added. We're
seeing these come into effect soon, with enforcement scheduled for January of
2024.

### What's included?

We had some basics already:

* Global opt out from sale and sharing of personal information, including a direction to limit the use of sensitive personal information.
* Choice to “Limit the Use of My Sensitive Personal Information.”
* Choice titled “Do Not Sell/Do Not Share My Personal Information for Cross-Context Behavioral Advertising.”

And now we see more rules around these opt-signals coming up:

* All opt-out preference signals satisfying certain technical requirements shall be processed.
* A valid opt-out preference signal shall be treated as a request to opt-out for a browser or device, any associated consumer profile including pseudonymous profiles, and, if known, the consumer.
* Recognizing opt-out preference signals is in all cases mandatory.

This all sounds a lot like the cookie-banner stuff we've been seeing everywhere
the last few years. Is it the same? Well, no, and regulations make that quite
clear.

In its draft regulations, the California Privacy Protection Agency clarifies
that banners seeking affirmative acceptance of web cookies are **not suited to
meet requirements to enable opt-out requests under CCPA**, because cookies
concern the collection of personal information and not the sale or sharing of
personal information.

If you want to meet these requirements you'll need to add specific language in
your privacy policy per the lists above. You'll need a link on your homepage
that is clearly labeled "Do Not Sell or Share My Personal Information". Even
better, have that link on every page, and certainly wherever personal
information is captured.

Pretty solid guidance there, if annoying in scope.

{{< figure src="https://labs.tomasino.org/assets/images/confused-book-on-face.jpg" caption="Edited from a photo by Ryan Snaadt on Unsplash" link="https://unsplash.com/photos/TsRnxEVecbs?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" >}}

## An exception to the rule?

What's really interesting to me, though, is that there seems to be some sense of
a carrot along with the stick. The new regulations include a specific exception
for a lot of this extra notice content if the opt-signals are processed in
a "frictionless" manner.

> Businesses that process opt-out preference signals in a frictionless manner,
include particular information in their privacy policy, and are able through the
signal to fully effectuate a consumer's request to opt out are not required to
also post a "Do Not Sell or Share My Personal Information" link.

### What does _frictionless_ look like?

*   Shall not (1) charge a fee or require any valuable consideration if the
    consumer uses an opt-out preference signal, (2) change the consumer's
    experience with the product or service offered by the business, or (3)
    display a notification, pop-up, text, graphic, animation, sound, video, or
    any interstitial content in response to the opt-out preference signal (but
    displaying if a consumer has opted out is ok)

*   Shall include in its privacy
    policy (1) a description of the consumer's right to opt-out of the sale or
    sharing of their personal information by the business, (2) a statement that
    the business processes opt-out preference signals in a frictionless manner,
    (3) information on how consumers can implement opt-out preference signals in
    a frictionless manner, and (4) instructions for any other method by which
    the consumer may submit a request to opt-out of sale/sharing

*   Shall allow the
    opt-out preference signal to fully effectuate the consumer's request to
    opt-out of sale/sharing

Huh? In short…

> “Frictionless” means the business may not charge a fee, change the user’s
experience on the site, or display any pop-up or notification in response to the
opt-out.

## Summary

TLDR;

**Bad news (for businesses):** The US rules are quickly approaching GDPR-like
requirements and states are writing the regulations for enforcement in real
time. Cookie policy opt-outs and preference choices aren't going to cut it.
There is a legal differentiation between collecting data and selling that data,
and now we have a standard for indicating an opt-out of that later type.

**Good news (for developers):** If you implement
[GPC](https://globalprivacycontrol.org/) in a "frictionless" manner, you can get
by without a bunch of the other stuff! By law you already **have** to respect
GPC no matter what, so just implement it carefully and save yourself from
another pop-up blocking users from your content.

**Annoying news (for everyone):** No matter how you approach it, you're going
to have to talk to lawyers.

<!--  vim: set shiftwidth=4 tabstop=4 tw=80 expandtab: -->
