#!/bin/bash

set -e

if [[ $UID -ne 0 ]]; then
    echo You need to run this script as root!
    exit 1
fi

on() {
    echo 0 > /sys/module/zswap/parameters/enabled
    modprobe zram
    echo lz4 > /sys/block/zram0/comp_algorithm
    echo $1 > /sys/block/zram0/disksize
    mkswap --label zram0 /dev/zram0
    swapon --priority 100 /dev/zram0
}

off() {
    swapoff /dev/zram0
    rmmod zram
    echo 1 > /sys/module/zswap/parameters/enabled
}

case "$1" in
    enable|on|1)
        size=${2:-32G}
        on $size
        echo zram with size $size has been enabled
        ;;
    disable|off|0)
        off
        echo zram has been disabled
        ;;
    *)
        echo "usage: $0 enable [size]"
        echo "       $0 disable"
        ;;
esac
