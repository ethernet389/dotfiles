#!/bin/sh


MARKED_BACKGROUND_PATH="$2"
UNMARKED_BACKGROUND_PATH="$3"

JOURNAL_PATH="$4"

update-bg() {
  local OLD_PID="$(pgrep -x swaybg)"

  swaybg -o '*' -m fill -i "$1" &
  sleep 0.1

  if [ -n "$OLD_PID" ]; then
    kill -TERM $OLD_PID
  fi
}

update-bg-and-journal() {
  update-bg "$1" && echo "$1" > "$JOURNAL_PATH"
}

restore-bg() {
  if bg_path="$(cat "$JOURNAL_PATH")"; then
    update-bg "$bg_path"
  else
    update-bg-and-journal "$UNMARKED_BACKGROUND_PATH"
  fi 
}

swap-bg() {
  if pgrep -x swaybg && bg_path="$(cat "$JOURNAL_PATH")"; then
    case "$bg_path" in
      "$UNMARKED_BACKGROUND_PATH")
        update-bg-and-journal "$MARKED_BACKGROUND_PATH"        
      ;;

      *)
        update-bg-and-journal "$UNMARKED_BACKGROUND_PATH"
      ;;
    esac
  else
    update-bg-and-journal "$UNMARKED_BACKGROUND_PATH"
  fi 
}


case "$1" in
  "restore")
    restore-bg
  ;;

  "swap")
    swap-bg
  ;;
esac
