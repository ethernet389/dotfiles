#!/bin/sh

WALLPAPERS_PATH=~/.config/sway/wallpapers/vanessa_collection/
LIFE_TIME=3600 # 1 hour

while true; do
    swaymsg "output * bg $(find $WALLPAPERS_PATH -type f | shuf -n 1) fill"
    sleep $LIFE_TIME
done
