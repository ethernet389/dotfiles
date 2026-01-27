#!/bin/sh


BACKGROUND_PATH="$1"

OLD_PID="$(pgrep -x swaybg)"

swaybg -i "$1" -o '*' -m center &

if [ -n "$OLD_PID" ]; then
  sleep 0.2
  kill -TERM $OLD_PID
fi
