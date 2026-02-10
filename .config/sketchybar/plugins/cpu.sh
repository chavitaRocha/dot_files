#!/bin/sh

CPU=$(top -l 1 | grep -E "^CPU" | awk '{print int($3 + $5)}')

case "${CPU}" in
  [0-9]|[1-2][0-9]) ICON="󰡳"
  ;;
  [3-5][0-9]) ICON="󰡵"
  ;;
  [6-7][0-9]) ICON="󰊚"
  ;;
  *) ICON="󰀪"
esac

sketchybar --set "$NAME" icon="$ICON" label="${CPU}%"
