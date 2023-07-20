---
date: 2023-07-20 16:56:35 +0000
title: "Respecting GPC and DNT in GTM"
url: "/respecting-gpc-and-dnt-in-gtm"
draft: true
tags:
  - GPC
  - DNT
  - GTM
  - analytics
  - tracking
---

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



<!--  vim: set shiftwidth=4 tabstop=4 tw=80 expandtab: -->
