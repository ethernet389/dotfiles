#!/usr/bin/env bash

NOTIFICATION_LIFETIME=2000
BRIGHTNESS_CONTROL_ID="string:x-canonical-private-synchronous:brightness_control"


brightness_get_percentage() {
	brightnessctl get \
		| awk -v max_bright="$(brightnessctl max)" '{print int($1 * 100 / max_bright)}'
}

notify_send_configured() {
	notify-send \
		-t $NOTIFICATION_LIFETIME \
		-h $BRIGHTNESS_CONTROL_ID \
		"$@"
}


declare -a args
declare -a good_msg_args
declare -a bad_msg_args

case "$1" in
	increase)
		args=( set 5%+ )
		good_msg_args=( "Increase brightness" "$(brightness_get_percentage)%" )
		bad_msg_args=( "Failed to increase brightness" )
		;;

	decrease)
		args=( set 5%- )
		good_msg_args=( "Decrease brightness" "$(brightness_get_percentage)%" )
		bad_msg_args=( "Failed to decrease brightness" )
		;;

	toggle)
		min_value=1
		max_value=$(brightnessctl max)
		current_value=$(brightnessctl get)

		if [[ $current_value = "$min_value" ]]; then
			args=( set "$max_value" )
			good_msg_args=( "Maximize brightness" "$(brightness_get_percentage)%" )
			bad_msg_args=( "Failed to maximize brightness" )
		else
			args=( set "$min_value" )
			good_msg_args=( "Minimize brightness" "$(brightness_get_percentage)%" )
			bad_msg_args=( "Failed to minimize brightness" )
		fi
		;;

	*)
		echo "Unknown command" >&2
		exit 1
		;;
esac


if brightnessctl "${args[@]}"; then
	notify_send_configured "${good_msg_args[@]}"
else
	notify_send_configured "${bad_msg_args[@]}"
fi
