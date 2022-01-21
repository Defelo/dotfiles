#!/usr/bin/python3

from subprocess import getoutput
import sys

assert len(sys.argv) == 2, "invalid cmd"
arg = sys.argv[1]

isvalidint = lambda x: all([a in "1234567890" for a in x])

FILE = "/sys/class/backlight/intel_backlight/brightness"
MFILE = "/sys/class/backlight/intel_backlight/max_brightness"
getoutput("sudo chmod 666 " + FILE)

current = int(open(FILE).read())
maxb = int(open(MFILE).read())
perc = round(current / maxb * 100)

if arg.startswith("+") and isvalidint(arg[1:]) and 0 <= int(arg[1:]) <= 100:
	perc += int(arg[1:])
elif arg.startswith("-") and isvalidint(arg[1:]) and 0 <= int(arg[1:]) <= 100:
	perc -= int(arg[1:])
elif isvalidint(arg) and 0 <= int(arg) <= 100:
	perc = int(arg)
else:
	getoutput("sudo chmod 644 " + FILE)
	assert False, "invalid cmd"

perc = min(max(perc, 0), 100)

val = round(perc / 100 * maxb)
assert 0 <= val <= maxb, "math is broken"

with open(FILE, "w") as file:
	file.write(str(val) + "\n")
	file.flush()
	file.close()

getoutput("sudo chmod 644 " + FILE)
