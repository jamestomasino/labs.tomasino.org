---
url: "/touring-my-terminal"
comments: true
date: 2017-12-29T13:24:55Z
excerpt: A quick walkthrough of my terminal setup across multiple systems
tags: terminal cli
title: Touring my terminal
---

[![Terminal Asciicast](https://asciinema.org/a/bmRtmRZfdNhCKmy6PTdCQcJBB.png)](https://asciinema.org/a/bmRtmRZfdNhCKmy6PTdCQcJBB)

## My configuration:

I live in the terminal. Whether I'm at work on my MacBook Air, or at home on my
Dell XPS13, I've got at least one full screen window that's all terminal.

Here's a rundown of what I'm using. Where appropriate, I've linked to my
configuration files.

- Terminal: [st][] / [iterm2][]
- Shell: [bash][]
- Multiplexer: [tmux][]
- Editor: [vim][] / [neovim][]
- Chat: [weechat][]

### Terminal

In my terminals I either use Inconsolata or [FiraCode][], a beautiful
fixed-width font with ligatures that will blow your mind. Inconsolata
looks better at small sizes, so I tend to stay with it on my Mint box
where I run at a higher resolution.

### Shell

Some of my coworkers and friends are die hard advocates for [zsh][], but
I prefer the ubiquity of bash. I know it so well and I've customized
things just the way I like them. Plus, on the off chance my system is
bare-bones, I like knowing that my environment will work.

My configuration for bash breaks up the normal start-up scripts like
`.bashrc` into multiple files, like `.environment` and `.alias` so I can
keep organized. I also have an ever-growing collection of functions I have
found or written that speed me along.

Take one example: `fe` ([source][])

```bash
#!/usr/bin/env bash

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
```

This comes from the author of the amazing fuzzy-finder [fzf][]. It's
a super fast tool for fuzzy-finding anything. Files, tags, bookmarks, it
doesn't matter. FZF is designed to work with whatever. This script allows
me to type `fe` and fuzzy-find files in the directory tree. Once I've
typed enough to highlight what I want, I hit enter and it opens in vim.

### Multiplexer

The shell would be a terribly simple and boring place without the ability
to create new windows, panes, and sessions. Tmux solves all that with
style. If you are familiar with tmux, my set up probably looks strange.
I've customized the look a ton, and I've rebound basically every
operation. Have a look at my [tmux.conf][] for the goodies.

One thing I want to note here is that I don't like using the fancy patched
fonts you'll see in Powerline. Not every system I am on has the ability
for me to install and use custom fonts. Instead I use some subtle color
changes to create gradients. I think they look nice, don't you?

I keep sessions for broad categories of activites, like "personal" and
"work" and "writing". I have some script I've written in Bash that make
use of the session name, too. My [todo][] program is context-aware.

### Editor

I've written about vim before. It's the best editor. It's not hard to
learn, despite what people say. Focus on learning the movement keys and
get away from the arrows as quickly as possible. I don't just mean HJKL
movement keys, but $ ^ 0 w e b M ) } and so on. Use them until they're
natural, then learn the action keys. Everything in vim is done by
composing actions and movements, so once you know how to move the rest
comes quick.

My theme is romainl's Apprentice. It's soft on the eyes but gives me
enough visual separation when coding. When working with prose I make heavy
use of the Pencil plugin series as well as Goyo and Limelight to go
full-screen and focus. My vimrc is pretty well annotated if you want to
browse it.

### Chat

Finally, I use weechat to hop on IRC and keep in touch with everyone.
I didn't include a link to a config here because my weechat isn't very
portable at the moment. Different systems have different plugin support.
I use a lot of buffers on [SDF][], but just one on tilde.town. Regardless,
weechat is very powerful. If you don't use IRC yet and want to get
started, your best bet is either weechat or irssi. Both are great.

  [st]: https://st.suckless.org/
  [iterm2]: https://iterm2.com/
  [bash]: https://github.com/jamestomasino/dotfiles/tree/master/bash
  [tmux]: https://github.com/jamestomasino/dotfiles/blob/master/tmux/.tmux.conf
  [vim]: https://github.com/jamestomasino/dotfiles/blob/master/vim/.vimrc
  [neovim]: https://github.com/jamestomasino/dotfiles/blob/master/neovim/init.vim
  [weechat]: https://weechat.org/
  [zsh]: http://ohmyz.sh/
  [FiraCode]: https://github.com/tonsky/FiraCode
  [source]: https://github.com/jamestomasino/dotfiles/blob/master/bash/.functions/fe
  [tmux.conf]: https://github.com/jamestomasino/dotfiles/blob/master/tmux/.tmux.conf
  [todo]: https://github.com/jamestomasino/dotfiles/blob/master/bash/.functions/todo
  [fzf]: https://github.com/junegunn/fzf
  [SDF]: http://sdf.org

<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
