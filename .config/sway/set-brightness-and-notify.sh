#!/bin/sh


NOTIFICATION_LIFETIME=2000

BRIGHTNESS_CONTROL_ID="string:x-canonical-private-synchronous:brightness_control"


brightness_get_percentage() {
  brightnessctl get | awk '{print int($1 * 100 / '$(brightnessctl max)')}'
}

if [ "$1" = "increase" ]; then
  brightnessctl set 5%+

  notify-send \
    -t $NOTIFICATION_LIFETIME \
    -h $BRIGHTNESS_CONTROL_ID \
    "Increase brightness" \
    "$(brightness_get_percentage)%"

elif [ "$1" = "decrease" ]; then
  brightnessctl set 5%-

  notify-send \
    -t $NOTIFICATION_LIFETIME \
    -h $BRIGHTNESS_CONTROL_ID \
    "Decrease brightness" \
    "$(brightness_get_percentage)%"

elif [ "$1" = "toggle" ]; then
  MIN_VALUE=1 
  MAX_VALUE=$(brightnessctl max)

  current_value=$(brightnessctl get)

  if [ $current_value = $MIN_VALUE ]; then
    brightnessctl set $MAX_VALUE

    notify-send \
      -t $NOTIFICATION_LIFETIME \
      -h $BRIGHTNESS_CONTROL_ID \
      "Maximize brightness" \
      "$(brightness_get_percentage)%"

  else
    brightnessctl set $MIN_VALUE

    notify-send \
      -t $NOTIFICATION_LIFETIME \
      -h $BRIGHTNESS_CONTROL_ID \
      "Minimize brightness" \
      "$(brightness_get_percentage)%"
  fi

fi
