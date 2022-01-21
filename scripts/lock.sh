#!/usr/bin/env bash

icon="$HOME/icon_small.png"
tmpbg='/tmp/screen.png'
tmpicon='/tmp/icon.png'

(( $# )) && { icon=$1; }

scrot -o "$tmpbg"
convert $HOME/icon.png -resize 100x100 $tmpicon
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
convert "$tmpbg" "$tmpicon" -gravity NorthEast -geometry +10+10 -composite -matte "$tmpbg"
convert $tmpbg -resize 1366x769 $tmpbg


dunstctl set-paused true

i3lock -n -u -i "$tmpbg"

dunstctl set-paused false
