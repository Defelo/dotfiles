#!/bin/bash

case $(echo -e " Lock\n Logout\n Suspend\n Shutdown\n Reboot" | rofi -dmenu -i -selected-row 2 | cut -d' ' -f2) in
    'Lock')
        ~/scripts/lock.sh
        ;;
    'Logout')
        i3-msg exit
        ;;
    'Suspend')
        systemctl suspend
        ;;
    'Shutdown')
        poweroff
        ;;
    'Reboot')
        reboot
        ;;
    *)
        exit 1
        ;;
esac

