#!/bin/bash

CONFIG=~/.config/scripts/powermenu/
mkdir -p $CONFIG

row=$(cat $CONFIG/last 2> /dev/null)

save(){ echo $1 > $CONFIG/last; }

case $(echo -e " System Update\n Lock\n Logout\n Suspend\n Hibernate\n Shutdown\n Reboot" | rofi -dmenu -i -selected-row ${row:-0} | cut -d' ' -f2-) in
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
    'Hibernate')
        save 4
        systemctl hibernate
        ;;
    'Shutdown')
        save 5
        poweroff
        ;;
    'Reboot')
        save 6
        reboot
        ;;
    *)
        exit 1
        ;;
esac
