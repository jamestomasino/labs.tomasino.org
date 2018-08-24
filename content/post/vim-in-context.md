---
url: "/vim-in-context"
date: 2015-03-28T00:00:00Z
excerpt: Creating project specific settings for vim to enable custom abbreviations
  and spelling in writing projects.
title: Vim in Context
---

I've mentioned [before](https://labs.tomasino.org/tools/) that I firmly love vim and use it for just about everything. Well, that's probably underselling it.

I spent most of this Saturday taking my copious notes and materials that I use to write my book and moving them into a [Markdown](http://whatismarkdown.com/) work-flow, powered by vim. At the heart of this move is an absolutely wonderful series of plugins written by [Reed Esau](https://twitter.com/reedes). The most famous of these is [vim-pencil](https://github.com/reedes/vim-pencil) (links to the others are at the bottom of his README) which has too many awesome writing enhancements to count here. With his deft hand at writing in Vimscript, he's turned my code editor into my everything editor.

I've been using vim to author this blog and [my other blog](http://blog.tomasino.org) for some time, but writing prose in vim for anything longer than these posts had a bit of overhead to it. Vim-pencil and its sister plugins really eased things out. Still, taking on the writing of my book would bring the challenge to another level.

I had two immediate problems I needed to solve to make the book authoring via vim a reality. They were:

1. A custom spelling dictionary for the vast number of made up words, places, and people.
2. A tool to handle abbreviations for long, cumbersome names--some names having special characters as well.

These weren't insurmountable, but they did take some effort to solve that I thought was worthy of a post. Both problems necessitated the same core ability: to define part of my vim configuration on a per-project basis.

Take the spelling dictionary for example. I have thousands of words that I've created from the gibberish of my mind and weaseled into my novel. I don't want these words to show up in my blog posts, code, emails, or anything else without vim highlighting the misspellings and making suggestions. I don't want to muddy up my whole environment with that spelling dictionary.

<img width="617" height="155" layout="responsive" src="//labs.tomasino.org/assets/images/spelling.png" alt="Spelling"></img>

On the other side of that argument, by default the spelling dictionaries in vim are stored in your `~/.vim/` directory on the system you're working on. This means that if I use the full ubiquity of vim--AKA use it on multiple systems--then my dictionary won't be everywhere. Not a good solve.

Luckily others have paved the way forward for setting up a `.vimrc` solution on a per-project basis. I tried a few plugins and they all seem to work to some degree or another, but the most robust and solid plugin I found was [Localvimrc](https://github.com/embear/vim-localvimrc).

Localvimrc allows me to create a `.lvimrc` file anywhere on my file system. If I edit a file, the plugin searches up the directory tree for any of those `.lvimrc` files and executes them in order (highest to lowest by default). There's a number of configuration options, but my setup only required these:


``` vim
" Local vimrc loading
let g:localvimrc_sandbox=0
let g:localvimrc_ask=0
```

No more prompting or security sandboxing for me! I'm happy to see those options enabled by default, but they're not necessary in my setup.

So, now I have a `.lvimrc` file that will execute after my `.vimrc` setup is complete. This is good! It's time to solve the problems.

### Solution #1 - local project dictionary

In this code block, I read in the directory location of the current file (my `.lvimrc`) and I use that path and some vim options to create a new spelling dictionary in the same folder. I give it a dot-name so it's hidden from view, and all is well.

``` vim
" Spellfile to use project based file
let s:safespelllang = join(split(&spelllang, "_"), "-")
let s:safeencoding = join(split(&encoding, "_"), "-")
let s:spellfileurl = expand('<sfile>:p:h') . '/.proj.' . s:safespelllang . '.' . s:safeencoding . '.add'
let &spellfile = s:spellfileurl
```

### Solution #2 - local project abbreviations

The native vim abbreviation tools are robust, but a bit wordy. Tim Pope's [Vim-Abolish](https://github.com/tpope/vim-abolish') plugin comes to the rescue here. It's really a collection of three separate features, but one of them does exactly what I want. Here's my setup:

``` vim
"Abolish Setup in this project

" We'll use this location to save new abbreviations as
" they are added.
let g:abolish_save_file = expand('<sfile>:p')

" quit if no Abolish
if !exists(":Abolish")
	finish
endif

" Setup abolish abbreviations below
```

In a similar solution to the dictionary, I'm using the location of the `.lvimrc` file in the file itself. In this case, I'm letting the vim-abolish plugin know that any new abbreviations I add on the fly should be saved to the end of my `.lvimrc` by default. Handy! Now I can set up any that I want to use and not even bother to open the file.

The best part of all of this is that my `.lvimrc` file and my project dictionary files are part of my git repository now. When I clone the project down on another machine, as long as my [vim setup is the same](https://github.com/jamestomasino/dotfiles), so is my writing environment.


  [Spelling]: //labs.tomasino.org/assets/images/spelling.png
