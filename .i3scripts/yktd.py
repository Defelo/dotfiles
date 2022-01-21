#!/usr/bin/python

import socket
import os

s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
s.connect(f"/run/user/{os.getuid()}/yubikey-touch-detector.socket")


def update(touch):
    if touch:
        print("", flush=True)
    else:
        print(flush=True)

update(False)
while True:
    update(s.recv(5).decode().endswith("1"))
