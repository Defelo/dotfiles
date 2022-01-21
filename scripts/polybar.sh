#!/bin/bash

for m in $(polybar --list-monitors | cut -d":" -f1); do
    if [[ $m = "eDP1" ]]; then
        tp=right
    else
        tp=none
    fi
    TRAY_POSITION=$tp MONITOR=$m polybar --reload main &
done
