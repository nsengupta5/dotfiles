# /bin/bash

size=$(xrandr -q | \grep -A 1 "DP-2 connected" | tail -n +2 | cut -d " " -f 4)
width=$(echo $size | cut -d "x" -f 1)
height=$(echo $size | cut -d "x" -f 2)

# If first argument is "dock" then set up for docked mode
if xrandr --listactivemonitors | \grep "DP-2";
then
	xrandr --output DP-2 --off

	feh --bg-scale ~/.config/i3/themes/macos/calming-blue-red.png

	 ~/.config/polybar/panels/launch.sh

	betterlockscreen -u ~/.config/i3/themes/macos/calming-blue-red.png
else 
	xrandr --output eDP-1 --mode 1920x1200 --rate 60 --pos 0x960 --output DP-2 --mode ${width}x${height} --rate 60 --pos 1920x0

	feh --bg-scale ~/.config/i3/themes/macos/calming-blue-red.png

	~/.config/polybar/panels/launch.sh

	betterlockscreen -u ~/.config/i3/themes/macos/calming-blue-red.png
fi
