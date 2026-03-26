#!/usr/bin/env bash

NOTIFICATION_LIFETIME=2000
PLAYER_CONTROL_ID="string:x-canonical-private-synchronous:player_control"


notify_send_configured() {
	notify-send \
		-t $NOTIFICATION_LIFETIME \
		-h $PLAYER_CONTROL_ID \
		"$@"
}

playerctl_configured() {
	playerctl --player=vlc,mpd,%any,firefox "$@"
}

playerctl_data() {
	playerctl_configured metadata --format "{{$1}}"
}


declare -a playerctl_args
declare -a good_msg_args
declare -a bad_msg_args

case "$1" in
	play-pause)
		playerctl_args=( play-pause )
		good_msg_args=( "Play-pause player ($(playerctl_data playerName))" )
		bad_msg_args=( "Failed to play-pause player ($(playerctl_data playerName))" )
		;;

	next)
		playerctl_args=( next )
		good_msg_args=( "Play next on player ($(playerctl_data playerName))" "$(playerctl_data title)" )
		bad_msg_args=( "Failed to play next player ($(playerctl_data playerName))" )
		;;

	previous)
		playerctl_args=( previous )
		good_msg_args=( "Play previous on player ($(playerctl_data playerName))" "$(playerctl_data title)" )
		bad_msg_args=( "Failed to play previous player ($(playerctl_data playerName))" )
		;;

	stop)
		playerctl_args=( stop )
		good_msg_args=( "Stop player ($(playerctl_data playerName))" "$(playerctl_data title)" )
		bad_msg_args=( "Failed to stop player ($(playerctl_data playerName))" )
		;;

	increase-level)
		playerctl_args=( volume 0.05+ )
		good_msg_args=( "Increase player ($(playerctl_data playerName)) volume by 5%" "$(playerctl_data volume)" )
		bad_msg_args=( "Failed increase player volume ($(playerctl_data playerName))" )
		;;

	decrease-level)
		playerctl_args=( volume 0.05- )
		good_msg_args=( "Decrease player ($(playerctl_data playerName)) volume by 5%" "$(playerctl_data volume)" )
		bad_msg_args=( "Failed decrease player volume ($(playerctl_data playerName))" )
		;;

	*)
		echo "Unknown command" >&2
		exit 1
		;;
esac


if playerctl_configured "${playerctl_args[@]}"; then
	notify_send_configured "${good_msg_args[@]}"
else
	notify_send_configured "${bad_msg_args[@]}"
fi
