#!/bin/bash

dunstctl set-paused toggle
if [[ $(dunstctl is-paused) = "true" ]]
then
    ~/discord_utils.py status status > ~/.discord_status
    [[ $(cat ~/.discord_status) != invisible ]] && ~/discord_utils.py status dnd
else
    ~/discord_utils.py status $(cat ~/.discord_status)
    rm ~/.discord_status
fi
