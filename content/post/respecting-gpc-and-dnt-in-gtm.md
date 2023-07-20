---
date: 2023-07-20 16:56:35 +0000
title: "Respecting GPC and DNT in GTM"
url: "/respecting-gpc-and-dnt-in-gtm"
og_image: "/assets/images/gpc-and-dnt.jpg"
tags:
  - GPC
  - DNT
  - GTM
  - analytics
  - tracking
  - programming
  - web
---

{{< figure src="https://labs.tomasino.org/assets/images/gpc-and-dnt.jpg" >}}

I [recently
wrote](https://labs.tomasino.org/ccpa-and-don-t-sell-my-information/) about CCPA
and other state laws and the need for Global Privacy Control (GPC) support on
websites in the US. If you haven't read it yet, pop over real quick. It's quick.

Today I put together a little sample GTM container that adds in checks for GPC
to ensure compliance. While I was in there I also went ahead and added checks
for the older Do Not Track (DNT) signal as well. The sample container has sample
options to support either or both!

> Note: GPC and DNT are not the same. US state laws name GPC specifically in
their list of must-support technologies. DNT is not required by law. You
shouldn't implement support for just DNT alone.

## Implementation

{{< figure src="https://labs.tomasino.org/assets/images/gtm-variables.png" caption="GTM Variables" >}}

The configuration is based on a few custom javascript variables that test for
the presence of the GPC or DNT signals.

{{< figure src="https://labs.tomasino.org/assets/images/gtm-gpc-variable.png" caption="GPC Variable" >}}

These variables are very simple, and return a "1" if found.

{{< figure src="https://labs.tomasino.org/assets/images/gtm-triggers.png" caption="GTM Sample Triggers" >}}

Included in the Triggers section are three different versions of DOM Ready which
respect the GPC and DNT variables. We're using DOM Ready instead of Page View
because we need javascript to be fully available to test for the presence of
those signals. We can use these triggers in place of your typical Page View
triggers.

Also included is a sample link event trigger showing how to add a check for the
GPC and/or DNT signals before firing.

You can [download this sample GTM Container here](https://labs.tomasino.org/assets/gpc-and-dnt-gtm-container.json)
and import it into your own GTM workspace.

This solution should theoretically cover you for business use in the US against
policies like like CCPA and other upcoming state laws from a functionality
standpoint. There is no consent banner necessary because you'd be respecting the
signal in a frictionless manner. You'll still have legal text requirements on
a privacy page, though, so check in with the lawyers.

This solution **will not** cover you for GDPR. That system is explicitly opt-in.
There is no getting around the banner there.

This implementation might be a nice-to-have addition, however. If one were to
check GPC & DNT first, then if either is set it would be possible to not use the
cookie consent banner at all, and just assume the default answer is "no". We
can't assume a lack of signal is an opt-in, but a present signal is a clear
opt-out.

Wouldn't that mean you track fewer visitors? Yes, that's likely, but your
experience for those users would be improved. People don't like consent banners,
especially people who answer in the negative. If they have spent the effort to
set a GPC or DNT signal in their browser they're likely to react negatively to
the consent question. That might sour them on your website before they even get
started.

To what degree this sort of sentiment might affect your business is not clear,
nor is it clear whether it's worth the trade-off of less tracking data. Being
a good steward of data and preemptively adding these sorts of supports is also
just an ethically good choice.

Need even more arm twisting? If your site fails compliance in some other area
for some reason, you could point to this as an example of your attempt to go
above and beyond in favor of customer privacy. That might earn you some points
with a judge deciding your fines.

<!--  vim: set shiftwidth=4 tabstop=4 tw=80 expandtab: -->
