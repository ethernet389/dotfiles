#!/bin/sh

JOURNAL_PATH="$1"

MARKED_BACKGROUND_PATH="$2"
UNMARKED_BACKGROUND_PATH="$3"

setup-new-bg() {
  OLD_PID="$(pgrep -x swaybg)"

  swaybg "$@" &
  sleep 0.2

  if [ -n "$OLD_PID" ]; then
    kill -TERM $OLD_PID
  fi
}

setup-new-bg-configured() {
  setup-new-bg -m fill -o '*' -i "$1"
  echo "$1" > "$JOURNAL_PATH"
}

swap-bg-configured() {
  current_bg="$(cat "$JOURNAL_PATH")"

  if [ -z "$current_bg" ]; then
    setup-new-bg-configured "$MARKED_BACKGROUND_PATH"
    return 0
  fi

  case "$current_bg"
}


if $(pgrep -x swaybg); then
  

else
  

  setup-new-bg-configured "$(cat "$JOURNAL_PATH")" 
fi
