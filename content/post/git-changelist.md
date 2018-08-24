---
date: 2013-11-14T00:00:00Z
excerpt: A git alias that shows a list of files modified after an abstract date.
title: git changelist
---

Today I needed to get a list of all the files that had changed in a git
repository over the last two weeks. I played around with some great git
commands, awk and sort to make the following git alias (toss it in the
[Alias] block of your .gitconfig):

``` bash
changelist = "!git whatchanged --since='\$1' --oneline | awk '/\^:/ {print \$6}' | sort -u; \#"
```

To use:

``` bash
git changelist "2 weeks ago"
```

You can use a lot of different unix date formats in there.

Enjoy!
