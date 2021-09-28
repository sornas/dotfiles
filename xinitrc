#!/bin/sh

userresources=$HOME/.Xresources

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ "$1" = "dwm" ]; then
    exec dbus-launch $1
else
    exec dbus-launch /home/gustav/dev/penrose-bin/target/release/penrose-bin &> ~/.penrose.log
fi

