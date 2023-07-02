#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
	pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}' 
}

function send_notification {
    volume=`get_volume`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" $(($volume / 3)) | sed 's/[0-9]//g')
    # Send the notification
    dunstify -i /usr/share/icons/mono-dark-flattr-icons/status/scalable/audio-volume-high-panel.svg -r 2593 -u normal "$bar"
}

case $1 in
    up)
	# Set the volume on (if it was muted)
	if [[ `is_mute` == "yes" ]] ; then
		pactl set-sink-mute 0 false
	fi
	# Up the volume (+ 5%)
	pactl set-sink-volume @DEFAULT_SINK@ +5%
	send_notification
	;;
    down)
	# Set the volume on (if it was muted)
	if [[ `is_mute` == "yes" ]] ; then
		pactl set-sink-mute 0 false
	fi
	pactl set-sink-volume @DEFAULT_SINK@ -5%
	send_notification
	;;
    mute)
    	# Toggle mute
	pactl set-sink-mute 0 toggle
	;;
esac
