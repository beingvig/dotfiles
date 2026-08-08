#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
STATE_FILE="/tmp/wallpaper_index"

mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \
  \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort)

COUNT=${#WALLPAPERS[@]}
[[ $COUNT -eq 0 ]] && exit 1

INDEX=0
[[ -f "$STATE_FILE" ]] && INDEX=$(cat "$STATE_FILE")

DIRECTION=$1

case "$DIRECTION" in
  right) INDEX=$(( (INDEX + 1) % COUNT )) ;;
  left)  INDEX=$(( (INDEX - 1 + COUNT) % COUNT )) ;;
  up)    INDEX=$(( (INDEX + 1) % COUNT )) ;;
  down)  INDEX=$(( (INDEX - 1 + COUNT) % COUNT )) ;;
  on)    touch "$MODE_FILE"; exit 0 ;;   # called when entering submap
  off)   rm -f "$MODE_FILE"; exit 0 ;;  # called when leaving submap
  *) echo "Usage: $0 right|left|up|down"; exit 1 ;;
esac

echo "$INDEX" > "$STATE_FILE"

case "$DIRECTION" in
  right) TRANS="left" ;;
  left)  TRANS="right" ;;
  up)    TRANS="bottom" ;;
  down)  TRANS="top" ;;
esac

awww img "${WALLPAPERS[$INDEX]}" \
  --transition-type "$TRANS" \
  --transition-duration 0.8 \
  --transition-fps 60 \
  --transition-step 90

