#!/bin/bash

f=$(mktemp)
xclip -o -selection clipboard | qr > $f
feh $f
rm $f
