#!/usr/bin/env bash

NOTIFICATION_LIFETIME=2000
BRIGHTNESS_CONTROL_ID="string:x-canonical-private-synchronous:brightness_control"

brightness_get_percentage() {
  brightnessctl get | awk '{print int($1 * 100 / '$(brightnessctl max)')}'
}

notify-send-configured() {
  notify-send \
    -t $NOTIFICATION_LIFETIME \
    -h $BRIGHTNESS_CONTROL_ID \
    "$@"
}


if [ "$1" = "increase" ]; then
  brightnessctl set 5%+ \
    && notify-send-configured "Increase brightness" "$(brightness_get_percentage)%" \
    || notify-send-configured "Failed to increase brightness"

elif [ "$1" = "decrease" ]; then
  brightnessctl set 5%- \
    && notify-send-configured "Decrease brightness" "$(brightness_get_percentage)%" \
    || notify-send-configured "Failed to decrease brightness"

elif [ "$1" = "toggle" ]; then
  MIN_VALUE=1 
  MAX_VALUE=$(brightnessctl max)

  current_value=$(brightnessctl get)

  if [ $current_value = $MIN_VALUE ]; then
    brightnessctl set $MAX_VALUE \
      && notify-send-configured "Maximize brightness" "$(brightness_get_percentage)%" \
      || notify-send-configured "Failed to maximize brightness"

  else
    brightnessctl set $MIN_VALUE \
      && notify-send-configured "Minimize brightness" "$(brightness_get_percentage)%" \
      || notify-send-configured "Failed to minimize brightness"
  fi

fi
