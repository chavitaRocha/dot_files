#!/bin/sh

MEMORY=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print 100 - int($5)}')

case "${MEMORY}" in
  [0-9]|[1-3][0-9]) ICON="󰍛"
  ;;
  [4-6][0-9]) ICON="󰍜"
  ;;
  [7-8][0-9]) ICON="󰍝"
  ;;
  *) ICON="󰀪"
esac

sketchybar --set "$NAME" icon="$ICON" label="${MEMORY}%"
