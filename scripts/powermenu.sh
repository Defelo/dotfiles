#!/bin/bash

CONFIG=~/.config/scripts/powermenu/
mkdir -p $CONFIG

row=$(cat $CONFIG/last 2> /dev/null)

save(){ echo $1 > $CONFIG/last; }

selection=$(cat << EOF | rofi -dmenu -i -selected-row ${row:-0} | cut -d' ' -f2-
 System Update
 Lock
 Logout
 Suspend
 Suspend then Hibernate
 Hibernate
 Shutdown
 Reboot
EOF
)

case "$selection" in
    'System Update')
        save 0
        st -i sh -c 'paru; read -sn1'
        ;;
    'Lock')
        save 1
        ~/scripts/lock.sh
        ;;
    'Logout')
        save 2
        i3-msg exit
        ;;
    'Suspend')
        save 3
        systemctl suspend
        ;;
    'Suspend then Hibernate')
        save 4
        systemctl suspend-then-hibernate
        ;;
    'Hibernate')
        save 5
        systemctl hibernate
        ;;
    'Shutdown')
        save 6
        poweroff
        ;;
    'Reboot')
        save 7
        reboot
        ;;
    *)
        exit 1
        ;;
esac
