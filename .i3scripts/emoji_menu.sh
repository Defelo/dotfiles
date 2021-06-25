#!/bin/bash

emoji=$(cat ~/.i3scripts/emoji_map.json | jq -r 'to_entries[] | .value + " :" + .key + ":"' | rofi -dmenu | cut -d' ' -f1)
printf "$emoji" | xclip -selection clipboard
sleep .01
if [ $(xdotool getwindowname $(xdotool getactivewindow)) = "st" ]; then
    xdotool key alt+v
else
    xdotool key ctrl+v
fi
