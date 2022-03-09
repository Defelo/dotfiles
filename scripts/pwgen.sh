#!/bin/bash

length=$(rofi -dmenu -p Length)
[[ $(echo -e 'Yes\nNo' | rofi -dmenu -p "Include symbols" -i -no-custom) = Yes ]] && symbols=y

pwgen -s$symbols $length 1 | tr -d '\n' | xclip -selection clipboard
