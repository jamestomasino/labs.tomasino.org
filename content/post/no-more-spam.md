---
url: "/no-more-spam"
date: 2011-11-08T00:00:00Z
excerpt: My technique for organizing, obfuscating, and generally over-engineering
  my email to avoid spam via aliases.
tags: alias cron cronjob email forwarder gmail pop3 spam
title: No More Spam
---

<img width="750" height="300" layout="responsive" src="//labs.tomasino.org/assets/images/spam.jpg" alt="Spam"></img>

In an effort to never, ever get a single bit of spam, I instituted a bit
of a ridiculous solution. Here's what I did:

I never use my real e-mail address publicly. This includes my friends
and family. Nobody has it. Period.

-   If someone somehow discovers my private account, I can move to a new
    one by simply updating all the forwards.

I create a unique alias for every website/account I use. For instance,
yahoo@jamesrocks.com, wachovia@jamesrocks.com, etc.

-   If any of these accounts sell my address to a spammer, or send me
    annoying things without offering an unsubscribe, I can simply delete
    the alias and my problems are gone.

For aliases I want to send mail "from", I create a full pop3 email
account.

-   I can then use the smtp server to send mail as that account without
    getting the annoying "on behalf of..." message in certain email
    clients.
-   I run a cron job to automatically clear out the contents of the mail
    account nightly. Since the mail is all being forwarded anyway, I
    don't actually need to pull anything from the account. This cleans
    things up nicely and avoids using up space unnecessarily.

Since my actual email account is at GMail, I have to handle separately
the spam I receive directly at that account. Luckily it seems that most
spammers that brute-force mail every letter combination at GMail do not
include dots (.) in the addresses. I can use this to my advantage by
filtering the "deliverto:" property and auto-deleting these messages.

-   In the GMail filters, under "Has the words" include
    "deliveredto:realaddresswithoutdots@gmail.com" (no quotes).
-   That will capture things delivered to your address whether or not
    you are included in the TO: field or BCC: or whatever. It's awesome,
    right?

It's a bit of overkill, but it gets the job done.
