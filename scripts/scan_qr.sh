#!/bin/bash

if ! res=$(zbarimg -q <(flameshot gui -r -s)); then
    dunstify -u critical -t 1500 "QR Code not found!"
    exit 1
fi

type=$(cut -d: -f1 <<< "$res")
link=$(cut -d: -f2- <<< "$res")
xclip -sel clip -rmlastnl <<< "$link"
dunstify "$type" "$link"
