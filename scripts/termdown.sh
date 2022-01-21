#!/bin/bash

duration=$(rofi -dmenu -window-title termdown)
msg=$(rofi -dmenu -window-title message)
#st -i -g 24x1 termdown "$duration" && notify-send "Timer Expired" "$msg"
st -i -g 24x1 -T "$msg" termdown --no-figlet -W -T "$msg" "$duration" && notify-send "Timer Expired" "$msg"
