---
date: 2020-01-05 16:13:29 +0000
title: "Identity vs. Secrecy"
url: "/identity-vs-secrecy"
tags:
  - identity
  - secrecy
  - biometrics
  - privacy
---

Yet [another story][] has released showing the vulnerability of
facial recognition software to relatively simple countermeasures.
AI company, Kneron, fooled banks, border controls, and airports
with 3D printed masks designed to look like other individuals.
They were able to fool security systems and automated payment
vendors.

The story isn't unique, and it's not limited to facial
recognition. We're deep into generations of fingerprint scanners
which still fail to balance between too-sensitive-to-work and
recognizes-anyone-that-tries. Privacy experts will warn you, don't
use a fingerprint to lock your device. Police-watchers will warn
you that you can be compelled to open a device with a fingerprint
lock.

So what's the take-away? Should we toss out biometrics? Is the
premise dead on arrival? Or maybe we just need to keep developing
the technology until it can defeat the next line of attack.

I will argue that the industry behind biometrics is fighting the
wrong battle. At its heart, biometrics are about identity, not
privacy or secrecy.  This is a vital distinction, not a semantic
argument. Identity is about establishing that a subject is who
they claim to be. It's a science of its own, and notoriously
difficult in the digital space. Having biometrics play a role in
this aspect of digital transactions is helpful. Rather than a user
needing to remember a complex unique identifier, their identity is
permanently etched into their body. Let the face be scanned or
finger swiped! Let the system use that to infer who we are. Just,
please, don't let that be the entire process.

It has been well established that identity proofing is only part
of the process. The [NIST Identity Guidelines][], recently
updated, separates the concerns of identity proofing from
authentication wisely. These are separate tasks and both necessary
(as well as other aspects like federation).

Take the example of the United States social security number. This
is a unique identifier given to each citizen around birth (i.e.,
Identity). It has no mechanism to be changed. Citizens are told to
guard it from prying eyes (i.e., Secret). It is used to
authenticate financial transactions and is used for government
services. So when the Office of Personnel Management (OPM) was
[breached][] and leaked millions of individuals' social security
numbers, that secrecy was forever lost. Without a mechanism to
reset it, there is no fix.

I don't need to cover the hundreds of other data breaches which
have widened the issue over the last few years. The entire SSN
system, it can be said, is effectively dead as a reliable
authentication method.

So how should it work? Well, it's not far off. Let's take an
example from Iceland's [IceKey][] system as a reasonable parallel
to the SSN of the United States.

Every individual registered in Iceland has a unique identifier
called a Kennitala. This is a number made up of the individual's
birth date and 4 control digits. It is used for everything from
banking to hospital visits to utility billing. But it is not used
alone. For identity purposes a Kennitala may be sufficient, but
for authentication a second step is brought in.

IceKey is a system of single-signon (oAuth) which is run by
Registers Iceland. It allows individuals to attach a password or
passphrase to their Kennitala. In this way the identity number can
be thought of as the username.

This is good. A username is an identifier. A proper secret is used
to handle the authentication, and all is well with the world.
IceKey has methods to safely generate a unique initial passphrase
for individuals signing up, and offers delivery of that initial
phrase either by mail or electronically through delivery to the
individual's bank. The password can later be changed in case it is
lost.

These management aspects are important. Having a true secret is
important. Biometrics cannot solve these two problems for us and
shouldn't be applied that way.

A fingerprint cannot be changed. It can easily be lost. You leave
it on everything you touch, in fact. A face is worse! You post it
publicly, share it on thousands of security cameras and wave it in
front of friends and enemies alike. It is, by definition, not
secret. It provides nothing beyond a reasonable assumption of
identity, like a username. And any system that needs to reliably
assure itself of that identity to complete a transaction MUST
endeavor to properly authenticate that assumption with a true
secret.

Biometrics represents a fantastic technological innovation in the
realm of identity assumption. It cannot, and should not, be used
for identity proof or authentication. It will fail. This is not
a limit of technology, but a limit of philosophy.


  [another story]: https://interestingengineering.com/printed-masks-fool-airport-facial-recognition-technology-researchers-discovered
    "Printed Masks Fool Airport Facial Recognition Technology, Researchers Discovered"

  [NIST Identity Guidelines]: https://pages.nist.gov/800-63-3/
    "NIST Identity Guidelines"

  [breached]: https://en.wikipedia.org/wiki/Office_of_Personnel_Management_data_breach
    "Office of Personnel Management data breach"

  [IceKey]: https://www.island.is/en/icekey-e---certificate/about-icekey/
    "About the IceKey system"

<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
