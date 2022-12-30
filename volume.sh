#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep '%' | \grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume=`get_volume`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" $(($volume / 2)) | sed 's/[0-9]//g')
    # Send the notification
    dunstify -i /usr/share/icons/mono-dark-flattr-icons/status/scalable/audio-volume-high-panel.svg -r 2593 -u normal "$bar"
}

case $1 in
    up)
	# Set the volume on (if it was muted)
	pactl set-source-mute @DEFAULT_SOURCE@ toggle 
	# Up the volume (+ 5%)
	amixer set Master 5%+
	send_notification
	;;
    down)
	pactl set-source-mute @DEFAULT_SOURCE@ toggle 
	amixer set Master 5%-
	send_notification
	;;
    mute)
    	# Toggle mute
	pactl set-source-mute @DEFAULT_SOURCE@ toggle 
	if is_mute ; then
	    dunstify -i audio-volume-muted -r 2593 -u normal "Mute"
	else
	    send_notification
	fi
	;;
esac
