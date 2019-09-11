---
date: 2019-09-11 13:06:33 +0000
title: "Reverse Proxy for VNC"
url: "/reverse-proxy-for-vnc"
tags:
  - work
  - vnc
  - ubuntu
  - osx
---

I'm attempting a setup where I can control a mac at the office from my
Ubuntu laptop at home. This is complicated by the work network where
simple dyndns & port forwarding are not an option.

## Set up MacOS for Remote Management

**From work machine:**

Open `Settings` -> `Sharing`.

Enable **Remote Management**.

Go to `Computer Settings...` and enable **VNC viewers may control screen
with password**.

Set up a password.

## Set up Ubuntu desktop for SSH server access

I'm running Ubuntu at home on my laptop. I'll need SSH running to support
the reverse proxy.

```bash
sudo apt install openssh-server
sudo systemctl enable ssh
```

## Set up Work machine via reverse proxy for SSH access

**From work machine:**

_Note: I'll need an ssh account on the remote machine._

Create a reverse SSH proxy opening port 22 on the work machine
via 7000 on the remote.

```bash
ssh -R 7000:localhost:22 remoteuser@remotepc
```

To verify this is working, the remote machine can try to SSH to localhost
7000 and it should attempt to login to the work machine.

## Set up SSH tunnel to allow VNC to reach work machine

**From the remote machine:**

Next, use ssh to proxy VNC's ports

```bash
ssh -L 5901:localhost:5900 workuser@localhost -p 7000
```

Now, the remote machine should be able to open a VNC connection to
localhost port 5901 and take control of the work machine.

<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->
