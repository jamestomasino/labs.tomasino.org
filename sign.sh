#!/usr/bin/env bash

GPG_FINGERPRINT="4E0FEB0E09DDD7DF"
cache="cache"
f="$1"
gen=0
if [ -f "${f}.asc" ]; then
  if ! md5sum --check "${cache}/${f}.md5"; then
    gen=1
  fi
else
  gen=1
fi

if [ 1 -eq "$gen" ]; then
  folder="$(dirname "${cache}/${f}")"
  mkdir -p "$folder"
  md5sum "${f}" > "${cache}/${f}.md5"
  gpg --batch --yes --local-user ${GPG_FINGERPRINT} --armor --detach-sign "${f}"
fi
