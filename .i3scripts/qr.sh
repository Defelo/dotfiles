#!/bin/bash

f=$(mktemp)
xclip -o | qr > $f
feh $f
rm $f
