---
date: 2020-01-26 11:41:16 +0000
title: "GNU Recutils"
url: "/gnu-recutils"
tags:
  - gnu
  - command line
  - database
---

{{< figure src="/assets/images/gnu-recutils.png" caption="Fred and George, Turtles in love">}}

There are hundreds of cool command line tools that have been made
over the years built on the [unix philosophy][]. Plain text is
powerful, ubiquitous, and human-centric. It was also the only
option for computing for quite a while. It's no surprise that some
of the most sophisticated tools are focused on it.

One such package is GNU Recutils, a set of tools and libraries to access
human-editable, plain text databases called recfiles. Using plain text
that is **primarily** human-readable as a database is just frankly cool as
hell.

Recutils is a collection of tools, like `recins`, `recdel`, and
`recsel` used to manage these recfiles/databases. They allow for
all the normal basic relational database operations, typing,
auto-incrementing, and even field-level crypto. All of this power
is yours with the bonus that your database is a human-readable
text file that you can grep/awk/sed freely, and a line-oriented
structure makes it perfect for version control systems.

## Recfiles

```recfile
%rec: Book
%mandatory: Title
%type: Location enum loaned home unknown
%doc:
+ A book in my personal collection.

Title: GNU Emacs Manual
Author: Richard M. Stallman
Publisher: FSF
Location: home

Title: The Colour of Magic
Author: Terry Pratchett
Location: loaned

Title: Mio Cid
Author: Anonymous
Location: home

Title: chapters.gnu.org administration guide
Author: Nacho Gonzalez
Author: Jose E. Marchesi
Location: unknown

Title: Yeelong User Manual
Location: home
```

A recfile begins with an optional structure definition using `%`
prefixes. There's a lot of power available in this, including the
defining of relations between tables, constraints, types, and
more. You can use the built-in type definitions or define your own
using regular expressions (plain text woo).

Following this header bit, the individual records are listed with
a blank line separating entries. Have a look at how amazingly
readable the data is!

Here's a more sophisticated example that shows a relationship in
action:

```recfile
%rec: Service
%key: Id
%auto: Id
%type: Provider rec Provider
%type: Mileage int
%sort: Mileage
%mandatory: Id Date Mileage Description Provider

%rec: Provider
%key: Id
%auto: Id
%mandatory: Id Name
```

_Car service examples courtesy of [dbucklin's gopher post][]._

## Queries & other operations

```bash
$ recsel -e "Location = 'loaned'" -P Title books.rec
The Colour of Magic
```

Querying your recfile database is usually done with `recsel`
(recfile select). You specify the table to query, expressions,
fields to return, and the file and the output comes to standard
out.

To insert data you use the `recins` (recfile insert) command:

```bash
$ recins -t Task              \
    -f Id -v 10               \
    -f Title  -v "New issue." \
    -f Status -v NEW          \
    TODO.rec
```

Again it's a simple syntax. You provide the table to insert into,
a list of fields & values (-f & -v, respectively), and the
filename. If you prefer, you can use the `-r` switch to provide
the field & value as one string.

How about deleting records? Can you guess the syntax?

```bash
$ recdel -c -t Task -e "Status = 'CLOSED'" TODO.rec
```

Yep, it's pretty much the same as the select, as one would expect.

## What else?

There's other convenient tools, like the ability to convert to and
from CSV formats, alternative output modes that make it work well
with awk, password-protected fields, and so on. The package is
quite robust and well maintained by Jose E. Marchesi, who can be
found in the #recutils room on irc.freenode.net.

The [full documentation][] is seriously impressive. Check it out.

I'll be adopting it into my tools immediately!

_(yes, the offical package image is [two gay turtles][])_

  [unix philosophy]: https://en.wikipedia.org/wiki/Unix_philosophy
  [dbucklin's gopher post]: https://gopher.tildeverse.org/sdf.org/0/users/dbucklin/posts/maintenance.txt
  [two gay turtles]: https://www.gnu.org/software/recutils/faq.html#whyturtles
  [full documentation]: https://www.gnu.org/software/recutils/manual/

<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
