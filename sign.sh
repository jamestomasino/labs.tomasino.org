#!/usr/bin/env bash

GPG_FINGERPRINT="4E0FEB0E09DDD7DF"
cache="cache"
f="$1"

if md5sum --check "${cache}/${f}.md5"; then
  printf "%s - cached\n" "$f"
else
  printf "%s - not cached\n" "$f"
  folder="$(dirname "${cache}/${f}")"
  mkdir -p "$folder"
  md5sum "${f}" > "${cache}/${f}.md5"
  gpg --batch --yes --local-user ${GPG_FINGERPRINT} --armor --detach-sign "${f}"
fi
