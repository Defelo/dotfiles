#!/bin/bash

function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

function update() {
    title=$(urldecode $(basename $1 .mp3))
    notify-send "VLC Media Player" "$title"
}

while true; do
    playerctl -F -p vlc metadata xesam:url 2>/dev/null | while read -r line
    do
        if [[ -n "$line" ]]
        then
            update "$line"
        fi
    done
done
