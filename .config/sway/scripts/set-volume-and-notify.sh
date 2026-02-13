#!/usr/bin/env bash

NOTIFICATION_LIFETIME=2000
AUDIO_CONTROL_ID="string:x-canonical-private-synchronous:audio_control"

notify-send-configured() {
  notify-send \
    -t $NOTIFICATION_LIFETIME \
    -h $AUDIO_CONTROL_ID \
    "$@"
}


if [ "$1" = "increase-sink" ]; then
  wpctl set-volume @DEFAULT_SINK@ 2%+ \
    && notify-send-configured "Increase sink volume" "$(wpctl get-volume @DEFAULT_SINK@)" \
    || notify-send-configured "Failed to increase sink volume"

elif [ "$1" = "decrease-sink" ]; then
  wpctl set-volume @DEFAULT_SINK@ 2%- \
    && notify-send-configured "Decrease sink volume" "$(wpctl get-volume @DEFAULT_SINK@)" \
    || notify-send-configured "Failed to decrease sink volume"

elif [ "$1" = "toggle-sink" ]; then
  wpctl set-mute @DEFAULT_SINK@ toggle \
    && notify-send-configured "(Un)mute sink" "$(wpctl get-volume @DEFAULT_SINK@)" \
    || notify-send-configured "Failed to (un)mute sink"

elif [ "$1" = "increase-source" ]; then
  wpctl set-volume @DEFAULT_SOURCE@ 2%+ \
    && notify-send-configured "Increase source volume" "$(wpctl get-volume @DEFAULT_SOURCE@)" \
    || notify-send-configured "Failed to increase source volume"

elif [ "$1" = "decrease-source" ]; then
  wpctl set-volume @DEFAULT_SOURCE@ 2%- \
    && notify-send-configured "Decrease source volume" "$(wpctl get-volume @DEFAULT_SOURCE@)" \
    || notify-send-configured "Failed to decrease source volume"

elif [ "$1" = "toggle-source" ]; then
  wpctl set-mute @DEFAULT_SOURCE@ toggle \
    && notify-send-configured "(Un)mute source" "$(wpctl get-volume @DEFAULT_SOURCE@)" \
    || notify-send-configured "Failed (un)mute source"
fi
