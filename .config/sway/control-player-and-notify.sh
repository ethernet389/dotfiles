#!/bin/sh

PLAYERCTL_OPTS="--player=vlc,mpd,%any,firefox"
NOTIFICATION_LIFETIME=2000
PLAYER_CONTROL_ID="string:x-canonical-private-synchronous:player_control"

notify-send-configured() {
  notify-send \
    -t $NOTIFICATION_LIFETIME \
    -h $PLAYER_CONTROL_ID \
    "$@"
}

playerctl-configured() {
  playerctl $PLAYERCTL_OPTS "$@"
}


if [ "$1" = "play-pause" ]; then
  playerctl-configured play-pause \
    && notify-send-configured "Play-pause player" "$(playerctl-configured status)" \
    || notify-send-configured "Failed to play-pause player"

elif [ "$1" = "next" ]; then
  playerctl-configured next \
    && notify-send-configured "Play next on player" "$(playerctl-configured metadata --format '{{title}}')" \
    || notify-send-configured "Failed to play previous"

elif [ "$1" = "previous" ]; then
  playerctl-configured previous \
    && notify-send-configured "Play previous on player" "$(playerctl-configured metadata --format '{{title}}')" \
    || notify-send-configured "Failed to play previous on player"

elif [ "$1" = "stop" ]; then
  playerctl-configured stop \
    && notify-send-configured "Stop player" "$(playerctl-configured metadata --format '{{title}}')" \
    || notify-send-configured "Failed to stop player"

elif [ "$1" = "increase-level" ]; then
  playerctl-configured volume 0.05+ \
    && notify-send-configured "Increase player volume by 5%" "$(playerctl-configured volume)" \
    || notify-send-configured "Failed to increase player volume"

elif [ "$1" = "decrease-level" ]; then
  playerctl-configured volume 0.05- \
    && notify-send-configured "Decrease player volumeby 5%" "$(playerctl-configured volume)" \
    || notify-send-configured "Failed to increase player volume"



fi
