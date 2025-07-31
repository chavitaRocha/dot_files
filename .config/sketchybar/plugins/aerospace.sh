#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

# Get the currently focused workspace
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

# The workspace name passed as argument
WORKSPACE=$1

if [ "$WORKSPACE" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set space.$WORKSPACE background.drawing=on
else
    sketchybar --set space.$WORKSPACE background.drawing=off
fi
