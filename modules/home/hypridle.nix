{ ... }: {
  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      after_sleep_cmd = hyprctl dispatch dpms on && sleep 2 && pidof noctalia-shell || noctalia-shell &
      ignore_dbus_inhibit = false
      lock_cmd = pidof hyprlock || hyprlock
    }

    listener {
      timeout = 115
      on-timeout = brightnessctl -s set 20%
      on-resume = brightnessctl -r
    }

    listener {
      timeout = 120
      on-timeout = hyprctl dispatch dpms off
      on-resume = hyprctl dispatch dpms on
    }

    listener {
      timeout = 180
      on-timeout = pidof hyprlock || hyprlock
    }

    listener {
      timeout = 300
      on-timeout = systemctl suspend
    }
  '';
}
