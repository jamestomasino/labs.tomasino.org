---
url: "/github-code-in-wordpress"
date: 2011-10-26T00:00:00Z
excerpt: Writing a plugin for WordPress to embed code from Github and automatically highlight syntax.
tags:
  - code
  - github
  - highlighting
  - php
  - plugin
  - repository
  - syntax
  - syntax highlighting
  - wordpress
title: GitHub Code in WordPress
---

I like to include my source code in my WordPress posts, but it was
getting annoying to keep up-to-date. Every time I'd make a change to my
code and commit it to GitHub, I'd have to dig through WordPress to find
the old post, duplicate my changes there, and republish. That's entirely
too manual for me. I needed a better solution.

A little digging around on GitHub itself paid off. I ran across a
project called [GitHub Code Viewer][] written by [Steve Francia][].
(He's the creator of [spf13-vim][], the totally amazing [vim][]
profile.)

GitHub Code Viewer is a WordPress plugin that allows you to grab your
source code directly from GitHub and display it in a post. It was
perfect! The code, unfortunately, didn't work right with the latest
WordPress release. I was sad. (sadface)

I had some free time that day, thankfully, and took it upon myself to
fix the code up myself. It was my very first time forking a git
repository, or doing a pull request, or any of those fun group-git
things. It was very exciting. The end result is a working WordPress
plugin that lets me pull in code from my repository.

I already use a wonderful syntax highlighter called [SyntaxHighlighter
Evolved][]. Together with GitHub Code Viewer I can include all of my
source directly in my posts, have it look pretty, and be automatically
updated.

Now, in an experiment of hilarious recursion, you will find below the
code to GitHub Code Viewer displayed in my blog via GitHub Code Viewer.
But before that, I'll ALSO show you the code to use GitHub Code Viewer
to display GitHub Code Viewer. (Takes a bow).

[Github_Code_Viewer.php](https://github.com/jamestomasino/wp_GitHub_Code_Viewer/blob/master/GitHub_Code_Viewer.php)

  [GitHub Code Viewer]: //github.com/spf13/wp_GitHub_Code_Viewer
  [Steve Francia]: //spf13.com/
  [spf13-vim]: //github.com/spf13/spf13-vim
  [vim]: //www.vim.org
  [SyntaxHighlighter Evolved]: //wordpress.org/extend/plugins/syntaxhighlighter/
