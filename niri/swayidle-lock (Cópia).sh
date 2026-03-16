#!/usr/bin/env bash

# tenta extrair a imagem usada pelo swaybg
WALLPAPER=$(pgrep -a swaybg | sed -n 's/.*-i \([^ ]*\).*/\1/p' | head -n1)

# fallback se não encontrar
[ -z "$WALLPAPER" ] && WALLPAPER="$HOME/.config/niri/1.jpg"

exec swayidle -w \
  timeout 120 "swaylock -f --image \"$WALLPAPER\" --clock --indicator --indicator-radius 100 --indicator-thickness 7" \
  timeout 180 "niri msg action power-off-monitors" \
  timeout 300 "systemctl suspend" \
  before-sleep "pidof swaylock || swaylock -f --image \"$WALLPAPER\" --clock --indicator --indicator-radius 100 --indicator-thickness 7"
