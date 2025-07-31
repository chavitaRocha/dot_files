#!/usr/bin/env bash

# Get the currently focused workspace from Aerospace
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

# Update the SketchyBar item with the focused workspace
sketchybar --set focused_workspace label="$FOCUSED_WORKSPACE"