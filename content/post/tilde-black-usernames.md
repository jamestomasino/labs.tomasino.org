---
date: 2019-11-10 16:15:36 +0000
title: "Tilde Black Usernames"
url: "/tilde-black-usernames"
tags:
---

On one of my public access unix systems (tilde.black), I offer
pseudo-anonymous access under usernames that are generated from
the dictionary. I got the idea from CryptoCat's chat system which
drops you into chat with a random dictionary username by default.
I wanted to offer something a little different on this system, and
that sounded like a nice option.

Additionally, since I'm generating thousands of possible usernames
and not expecting many users, when I get a new account signup
I automatically assign 10 of these usernames at random to the new
account. If they get a couple duds, no big deal.

I have never really documented how I built the system around that,
so I thought I'd do a little piece of that documentation now.
Honestly, I didn't keep very good records of the commands I used
as I didn't expect the site to actually get real users or survive
more than a week. I have some old code in a /tmp directory still,
so lets look at what it does:

First, I need a list of words that will become usernames. What
better way to do that than to get them from the dictionary. The
OpenBSD system I was on has dictionary files in `usr/share/dict`,
so lets check those out.

This script tears through the dictionary files available on the
system looking for words between 3 and 5 characters. Later this
was changed to 4-5 characters.

```bash
#!/usr/bin/env bash

LANG=C

for wordlist in $(find /usr/share/dict/ -type f)
do
 prunedlist="${wordlist//\//_}"
 prunedlist="${prunedlist/.txt}-pruned.txt"

 echo "source:  $wordlist"
 echo -n "Total number of words in list:              "
 < "$wordlist" wc -l

 echo "target:  $prunedlist"
 echo -n "Used lower case words ( 3 < length < 5 ):  "

 < "$wordlist"  tr -d '\015'| \
 grep '^[a-z]\{3,6\}$' | \
 tee "$prunedlist" | \
 wc -l
 echo "-------"
done
```

I wanted to avoid situations where a 3 letter username was
a substring of a longer 4 letter username. If the username was
"woo" then I didn't also want a "woot". This was stylistic, but
I also thought it might avoid problems with tab-completion or poor
scripting later on.

To accomplish this I needed to process all the shorter usernames
first, then remove any longer usernames that might use them.
I decided not to be greedy about the username starting with the
same substring. Ending with it was fine too. It's not de-duping
per se, but sort of like de-similar'ing.

I had the hardest time sorting these by line length on a non-Gnu
system. Rather than waste a bunch of time digging in man pages,
I just stitched together some utilities I knew. This only needed
to be run once anyway, so I didn't need to optimize it.

```bash
# Print line-length and the line
awk '{ print length, $0 }' words.txt |

# Sort numerically by line-length
sort -n                           |

# Remove line-length number
cut -d' ' -f2-
```

I piped the output of this to "sort.txt".

Once the file is in the correct position I was ready to do my
substring testing. Again, speed and pretty code weren't important.
I just poked at this until I got it working. You can see the sort
of monster script that results in…

```bash
cp sort.txt test.txt
while [ $(cat "./test.txt" | wc -l) -gt 0 ]; do
  line=$(head -n 1 "test.txt")
  echo "processing:  ${line}"
  sed '1d' test.txt > tmpfile; mv tmpfile test.txt
  if ! grep -q "$line" "test.txt"; then
    echo "$line" >> "out.txt"
  fi
done
```

I then played around with shuffling that list for different tasks,
but eventually realized it wasn't necessary.

Sadly, that's where my collection of tmp scripts ends, and
I hadn't yet up set command history on the box to go back and see
exactly what I did next. Here's the basics of what I remember:

- Created new user accounts with each of the words. This resulted
  in just over 10,000 of them. I did increase some OpenBSD
  settings to make things not explode, but I can't remember what
  exactly. I can't even remember the command I used to make the
  accounts on the system automatically. `useradd` I suppose.

- Realized that words like "admin" and "mail" were in my list and
  I just created user accounts that overlapped with system ones.
  Whoops. Fixed that.

- Wrote a [script](https://tildegit.org/tilde.black/ops/src/branch/master/assign.sh)
  to assign these existing accounts ssh pubkeys for new users.

- Generated a `public_html` folder in every new account directory
  as a symlink to a user folder available in the web root. Then
  I changed permissions on each of these web folders to give them
  to the users. Why all this extra work? Well, I'm using OpenBSD's
  httpd instead of nginx or apache for some reason, which offer
  userdirs in an easy way.

- Started some cron tasks to check if any users' html directory
  has an index file. If so, I added it to the website main page.

- Do the same things I did for the web for gopher too.

And so on. The site grew from there.

That's all I remember. If anyone else recreates the process,
I would suggest you do a better job documenting it as you go than
I did.

<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
