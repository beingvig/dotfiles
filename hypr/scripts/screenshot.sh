#!/bin/bash

file=$(mktemp --suffix=.png)

grim -g "$(slurp)" "$file" || {
    rm -f "$file"
    exit 1
}

# Copy immediately
wl-copy < "$file"

# Show notification and wait for interaction
action=$(dunstify \
    -I "$file" \
    -A "open,Open" \
    -t 5000 \
    -w \
    "Screenshot taken" \
    "Click to open in Satty")

if [ "$action" = "open" ]; then
    satty -f "$file" --copy-command wl-copy
fi

rm -f "$file"
