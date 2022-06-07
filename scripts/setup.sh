#!/bin/bash

# setup primary display for tray
# xrandr --output eDP-1-1 --primary

# no auto blank
xset s off
xset -dpms
xset s noblank

# cd into scripts folder
cd ~/scripts/

# configure touchpad
while ! ./setuptouchpad.sh; do
    sleep 1
done

# # start ssh agent
# gnome-keyring-daemon --start

# start gpg agent
gpgconf --launch gpg-agent && gpg-connect-agent updatestartuptty /bye

# setxkbmap de
setxkbmap -model pc105 -layout de,apl -variant nodeadkeys,dyalog -option grp:menu_switch

# xrdb -load ~/.Xdefaults
# sleep 1

# start mouse handler
~/mouse.py &
~/keyboard.py &

# start dunst
dunst &

# window transparancy and animation thingy
picom &

# hide mouse when typing
xbanish &

# start playerctld daemon for playerctl
playerctld daemon

# start flameshot
flameshot &

# start input daemon
fcitx5 -d

{{#if (command_success "type onboard")}}
# start on screen keyboard
onboard &
{{/if}}

# lock screen on suspend
xss-lock --transfer-sleep-lock -- ~/scripts/lock.sh &
