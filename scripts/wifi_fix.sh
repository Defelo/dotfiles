#!/bin/bash

set -ex

sudo iw phy0 set frag 512
sudo iw phy0 set rts 500
