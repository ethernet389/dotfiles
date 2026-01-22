#!/bin/sh

BATTERY_PATH="/sys/class/power_supply/BAT1/"

predeath_level=2
extreme_low_level=5
low_level=20

delay=5
level_threshold=5

last_status=""
last_notified_level="$(cat "$BATTERY_PATH/capacity")"

while true; do
  current_status="$(cat "$BATTERY_PATH/status")"

  if [ "$current_status" != "Discharging" ]; then
    last_status="$status"
    sleep $delay
    continue
  fi

  current_level="$(cat "$BATTERY_PATH/capacity")"
  current_delta=(($current_level - $last_notified_level))

  if [ $current_level -le $predeath_level ]; then
    notify-send "Predeath Battery Level!" "Beg you, charge me now ($current_level)."
  elif [ $current_level -le $extreme_low_level ] && [ $current_delta -ge $level_threshold ]; then
    notify-send "Extreme Low Battery Level!" "Please, charge me ($current_level)."
    last_notified_level=$current_level
  elif [ $current_level -le $low_level ] && [ $current_delta -ge $level_threshold ]; then
    notify-send "Low Battery Level!" "Charge me ($current_level)."
    last_notified_level=$current_level
  fi

  last_status="$status"
  sleep $delay
done
