#!/bin/sh

# nosleep   turn on/off: the laptop stays awake with the lid closed (icon on waybar while on)

if systemctl --user is-active -q nosleep; then
    systemctl --user stop nosleep
    echo "nosleep: off"
else
    systemctl --user start nosleep
    echo "nosleep: on"
fi

pkill -RTMIN+9 waybar
