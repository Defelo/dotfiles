#!/bin/bash

mkdir /tmp/screenshots
tempdir=$(mktemp -d)
cd $tempdir
scrot
file=$(ls)
mv $file /tmp/screenshots
cd
rm -rf $tempdir
feh -F /tmp/screenshots/$file
