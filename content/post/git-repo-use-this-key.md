---
date: 2023-07-12 17:47:26 +0000
title: "git repo use this key"
url: "/git-repo-use-this-key"
tags:
  - git
  - cli
---

I learned a new git trick a few weeks ago. I wanted a local git folder to use
a specific ssh key to connect to the remote git repository. This particular
server is hosting a few different repos and they each have their own relevant
deploy key in use.

I have those keys in my `.ssh` folder, but I had been using a horrible hack of
setting the git command as a shell environment variable before any git
instructions, like so:

```bash
GIT_SSH_COMMAND="ssh -i ~/.ssh/my-private-deploy-key" git ...
```

It was annoying and broke easily. I just wanted to set the setting somewhere so
I could go about my git life and not worry about it. Enter `core.sshCommand`!

Here's what you do:

```bash
git config core.sshCommand "ssh -i ~/.ssh/my-private-deploy-key -F /dev/null"
```

That's it. The info is stored in `.git/config`. It's safe in your local
environment and doesn't break anything for anyone else.


<!--  vim: set shiftwidth=4 tabstop=4 tw=80 expandtab: -->
