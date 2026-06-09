#!/bin/bash

device=$(bluetoothctl devices Connected | cut -d' ' -f3-)

if [ -n "$device" ]; then
    echo "<span font_size='10pt'><small>󰂱</small></span> $device"
else
    echo "<span font_size='10pt'><small></small></span>"
fi
