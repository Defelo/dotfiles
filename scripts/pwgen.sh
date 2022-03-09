#!/bin/bash

length=$(rofi -dmenu -p Length)

pwgen -sy $length 1 | tr -d '\n' | xclip -selection clipboard
