#!/bin/bash

function send_notification {
	brightness=$(light | sed 's/\..*//g')
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" $(($brightness / 2)) | sed 's/[0-9]//g')
    # Send the notification
    dunstify -i /usr/share/icons/ePapirus-Dark/16x16/actions/brightnesssettings.svg -r 2594 -u normal "$bar"
}

case $1 in
    up)
	# Up the brightness (+ 5%)
	light -A 10
	send_notification
	;;
    down)
	light -U 10
	send_notification
	;;
esac
