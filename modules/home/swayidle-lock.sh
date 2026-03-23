#!/usr/bin/env bash

WALLPAPER_DIR="/home/pc120/Pictures/Wallpapers"

# escolhe um wallpaper aleatório (png/jpg/jpeg/webp)
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( \
  -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \
\) | shuf -n 1)

# fallback se der algum problema
[ -z "$WALLPAPER" ] && WALLPAPER="$HOME/.config/niri/1.jpg"

exec swayidle -w \
  timeout 120 "swaylock -f --image \"$WALLPAPER\" --clock --indicator --indicator-radius 100 --indicator-thickness 7" \
  timeout 180 "niri msg action power-off-monitors" \
  timeout 300 "systemctl suspend" \
  before-sleep "pidof swaylock || swaylock -f --image \"$WALLPAPER\" --clock --indicator --indicator-radius 100 --indicator-thickness 7"