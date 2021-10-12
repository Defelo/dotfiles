#!/bin/bash

function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

function update() {
    title=$(urldecode $(basename $1 .mp3))
    notify-send "VLC Media Player" "$title"
}

function loop() {
    playerctl -F -p vlc metadata xesam:url 2>/dev/null | while read -r line
    do
        if [[ ! "$line" ]]
        then
            break
        fi
        update "$line"
    done
}

loop &
/usr/bin/vlc -I ncurses "$@"
pkill playerctl
