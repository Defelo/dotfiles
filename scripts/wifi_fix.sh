#!/bin/bash

set -ex

sudo iw dev wlo1 set power_save off
sudo iw phy0 set frag 512
sudo iw phy0 set rts 500
