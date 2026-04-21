#!/bin/sh
CURRENT=$(hyprctl activewindow -j | jq '.size[0]')
MONITOR=$(hyprctl monitors -j | jq '.[0].width')
THRESHOLD=$(echo "$MONITOR * 0.9" | bc | cut -d. -f1)
if [ "$CURRENT" -ge "$THRESHOLD" ]; then
  hyprctl dispatch layoutmsg "colresize -0.5"
else
  hyprctl dispatch layoutmsg "colresize +0.5"
fi
