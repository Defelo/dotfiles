#!/bin/bash

WALLPAPER=~/Pictures/Wallpapers/cryptic.jpg

if [[ -n "$WAYLAND_DISPLAY" ]]; then
    pkill swaybg
    swaybg -i $WALLPAPER &
else
    feh --bg-scale $WALLPAPER
fi
