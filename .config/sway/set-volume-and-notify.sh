#!/bin/sh

NOTIFICATION_LIFETIME=2000

AUDIO_CONTROL_ID="string:x-canonical-private-synchronous:audio_control"

if [ "$1" = "increase-sink" ]; then
  wpctl set-volume @DEFAULT_SINK@ 2%+

  notify-send \
    -t $NOTIFICATION_LIFETIME  \
    -h $AUDIO_CONTROL_ID \
    "Increase sink volume" \
    "$(wpctl get-volume @DEFAULT_SINK@)"

elif [ "$1" = "decrease-sink" ]; then
  wpctl set-volume @DEFAULT_SINK@ 2%-

  notify-send \
    -t $NOTIFICATION_LIFETIME \
    -h $AUDIO_CONTROL_ID \
    "Decrease sink volume" \
    "$(wpctl get-volume @DEFAULT_SINK@)"

elif [ "$1" = "toggle-sink" ]; then
  wpctl set-mute @DEFAULT_SINK@ toggle

  notify-send \
    -t $NOTIFICATION_LIFETIME \
    -h $AUDIO_CONTROL_ID \
    "(Un)mute sink" \
    "$(wpctl get-volume @DEFAULT_SINK@)"

elif [ "$1" = "toggle-source" ]; then
  wpctl set-mute @DEFAULT_SOURCE@ toggle

  notify-send \
    -t $NOTIFICATION_LIFETIME \
    -h $AUDIO_CONTROL_ID \
    "(Un)mute source" \
    "$(wpctl get-volume @DEFAULT_SOURCE@)"
fi
