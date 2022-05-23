#!/usr/bin/env bash

count=0

disconnected="%{u#000}%{-u}"
wireless_connected=""
ethernet_connected=""

function measure() {
    ms=$(ping -c 5 -i 1 1.1.1.1 2> /dev/null | tail -n1 | cut -d/ -f5)
}

function is_ethernet() {
    [[ "$(ip link | awk '/state UP/ {print $2}')" == e* ]]
}

while true; do
    measure
    if [[ -n "$ms" ]]
    then
        if is_ethernet
        then
            echo "$ethernet_connected $ms ms" # ; sleep 25
        else
            echo "$wireless_connected $ms ms" # ; sleep 25
        fi
        sleep 25
    else
        echo "$disconnected" ; sleep 2
    fi
done
