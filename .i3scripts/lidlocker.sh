#!/bin/bash

while true; do
	if [ "`pidof i3`" = "" ]; then
		exit
	fi

	if [ "$(cat /proc/acpi/button/lid/LID/state | grep open)" == "" ]; then
		if [ "$(pidof i3lock)" == "" ]; then
			$HOME/.i3scripts/lock.sh
		fi
	fi
	sleep .2
done
