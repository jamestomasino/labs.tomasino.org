---
date: 2023-06-12 14:26:47 +0000
title: "Makefiles for fun and profit"
url: "/makefiles-for-fun-and-profit"
tags:
  - make
  - scripting
  - shell
---

I use a lot of different tech stacks in my day job. When you add in all my hobby
projects from the tildeverse to fiction writing, the number of tools and setups
is quite silly. Trying to remember how the tools work is a losing battle.

Enter Makefiles!

[Lots
of](https://medium.com/stack-me-up/using-makefiles-the-right-way-a82091286950)
[articles
have](https://nystudio107.com/blog/using-make-makefiles-to-automate-your-frontend-workflow)
[been written](https://blog.boot.dev/stories/makefiles-to-improve-your-life/)
about using Makefiles to automate your projects. I'm going to share my personal
choices and explain my setup.

## How I build this blog

My first rule for all of my Makefiles is that the default task is always a phony
called "help". The help task is exactly the same in every one of my Makefiles:

```Makefile
help:
        @echo "targets:"
        @grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
        | sed -n 's/^\(.*\): \(.*\)##\(.*\)/  \1|\3/p' \
        | column -t  -s '|'
```

This task greps through the Makefile itself looking for any targets that have
a double-# comment. If so, that target is listed and the comment becomes the
help description. (e.g., `build: ## build hugo source`)

In the case of this blog, that looks like:

```bash
targets:
  new      create new post
  serve    start hugo watcher and webserver
  build    build hugo source
  sign     gpg sign blog content
  deploy   send built files to webserver
```

The majority of my other targets are simply wrappers for the specific commands
that apply to any given project. Is it a node thing? There's probably an NPM
command in there, or Yarn. Python? Oh, you better believe I've got some virtual
env activate/deactivate things in there.

I also commonly have a `deploy` task, whether that involves triggering a git
signing & tagging process, or rsyncing files, who knows. The point is I don't
need to remember. I know what I want to do and now I have a unified way of doing
it.

## So why make?

It's there. It works on all the systems I use. It's not very hard to work with
and it has some nice dependency management.

I know what you're thinking. "You're not even using the powerful features of
make! This might as well be a shell script." And, in many cases, you're right.
But not all.

On the contrary, I have several projects that use dynamic file-based targets to
generate compiled versions of source files with some really cool dependency
stuff. I built myself a typescript web environment that outputs raw html, css,
and js without any webpack fluff! In the case of this blog, I'm using a bit of
make magic to identify the signing files for each of my blogposts.

```Makefile
INDEX_FILES != find public/ -name 'index.html'
SIG_FILES := $(INDEX_FILES:%.html=%.html.asc)
GPG_FINGERPRINT="4E0FEB0E09DDD7DF"

sign: $(SIG_FILES) ## gpg sign blog content

public/%.html.asc: public/%.html
        gpg --batch --yes --local-user $(GPG_FINGERPRINT) --armor --detach-sign $<
```

It would even be smart enough not to re-generate the signing files for untouched
posts, except Hugo is greedy and regenerates the entire site everytime anything
is updated. Oh well.

## The long and short of it

I use Make to make things easier and simpler. If doing something in make is too
hard, I don't do that. I write a shell script and tell make to call it! Or
python, or golang, or node.

Should you use make? Eh, I don't care. If you have difficulty remembering the
ins-and-outs of lots of different setups, then maybe it would be helpful. Or you
could use Just or a shell script, or whatever. This isn't some universal life
lesson teaching you the One True Way™. It's just helpful to me.

- - - - -

Here's the full Makefile for this blog for reference:

```Makefile
INDEX_FILES != find public/ -name 'index.html'
SIG_FILES := $(INDEX_FILES:%.html=%.html.asc)
GPG_FINGERPRINT="4E0FEB0E09DDD7DF"

help:
        @echo "targets:"
        @grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
        | sed -n 's/^\(.*\): \(.*\)##\(.*\)/  \1|\3/p' \
        | column -t  -s '|'

new: ## create new post
        @test -n "$(title)" || read -p "Enter a title for your post: " title; \
        export title_slug=`echo $${title:-Untitled} | sed -E -e 's/[^[:alnum:]]/-/g' -e 's/^-+|-+$$//g' | tr -s '-' | tr A-Z a-z`; \
        export post_path=content/post/$$title_slug.md; \
        echo "Creating $$post_path"; \
        echo "---"                                                  >  $$post_path; \
        echo "date: `date +"%Y-%m-%d %H:%M:%S %z"`"                 >> $$post_path; \
        echo "title: \"$$title\""                                   >> $$post_path; \
        echo "url: \"/$$title_slug\""                               >> $$post_path; \
        echo "tags: "                                               >> $$post_path; \
        echo "  - meta "                                            >> $$post_path; \
        echo "---"                                                  >> $$post_path; \
        echo " "                                                    >> $$post_path; \
        echo " "                                                    >> $$post_path; \
        echo " "                                                    >> $$post_path; \
        echo " "                                                    >> $$post_path; \
        echo "<!--  vim: set shiftwidth=4 tabstop=4 tw=80 expandtab: -->" >> $$post_path; \
        vim $$post_path

serve: ## start hugo watcher and webserver
        hugo server -D

build: ## build hugo source
        hugo --gc --minify

sign: $(SIG_FILES) ## gpg sign blog content

public/%.html.asc: public/%.html
        gpg --batch --yes --local-user $(GPG_FINGERPRINT) --armor --detach-sign $<

deploy: build $(SIG_FILES) ## send built files to webserver
        rsync -rvhe ssh --progress --delete ./public/ labs.tomasino.org:/var/www/labs.tomasino.org/

.PHONY: new serve build deploy help sign
```

<!--  vim: set shiftwidth=4 tabstop=4 tw=80 expandtab: -->
