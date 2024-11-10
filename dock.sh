#!/bin/bash

size=$(xrandr -q | grep -A 1 "DP-2 connected" | tail -n +2 | cut -d " " -f 4)
width=$(echo $size | cut -d "x" -f 1)
height=$(echo $size | cut -d "x" -f 2)
wallpaper=~/.config/i3/themes/macos/winter_mountains.jpg

orientation=$1

docked_commands() {
	feh --bg-scale $wallpaper
	~/.config/polybar/panels/launch.sh
	betterlockscreen -u $wallpaper
	picom --config ~/.config/picom.conf --experimental-backends -b
}

# If first argument is "dock" then set up for docked mode
if xrandr --listactivemonitors | grep "DP-2";
then
	xrandr --output DP-2 --off
	docked_commands
else 
	if [[ $orientation == "left" ]]
	then
		xrandr --output eDP-1 --mode 1920x1200 --rate 60 --pos 0x0 --output DP-2 --mode ${width}x${height} --rate 60 --pos 1920x0
	elif [[ $orientation == "right" ]]
	then
		xrandr --output eDP-1 --mode 1920x1200 --rate 60 --pos 0x960 --output DP-2 --mode ${width}x${height} --rate 60 --pos 1920x0
	elif [[ $orientation == "up" ]]
	then
		horizontal_offset=$(( (width - 1920) / 2 ))
		xrandr --output eDP-1 --mode 1920x1200 --rate 60 --pos ${horizontal_offset}x${height} --output DP-2 --mode ${width}x${height} --rate 60 --pos 0x0
	fi
	docked_commands
fi
