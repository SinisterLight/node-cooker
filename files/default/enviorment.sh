#!/bin/sh

for file in /etc/profile.d/node/*.sh ; do
  if [ -f "$file" ] ; then
    . "$file"
  fi
done
