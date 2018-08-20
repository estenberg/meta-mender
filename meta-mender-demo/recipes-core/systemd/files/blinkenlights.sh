#!/bin/bash

# Blink the D2 LED on a MinnowBoard Turbot board
# D2 LED is GPIO 360
LED2=360
# Tell the system we'll be using the GPIO for the D2 LED
if [ ! -d /sys/class/gpio/gpio$LED2 ]; then
        echo $LED2 > /sys/class/gpio/export
fi
# and we'll be using it for Output (out) and not Input (in)
echo out > /sys/class/gpio/gpio$LED2/direction
# alternate writing a 0 (ON) and 1 (OFF) every second, until interrupted
i=0
while true ; do
        echo $i > /sys/class/gpio/gpio$LED2/value
        sleep 2
        i=$(((i==0?1:0)))
done
