{...}: {
  programs.niri = {
    enable = true;

    settings = {
      # ── Debug ────────────────────────────────────────────────────────────
      debug = {
        render-drm-device = "/dev/dri/renderD128";
      };

      # ── Geral ────────────────────────────────────────────────────────────
      prefer-no-csd = true;

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      # ── Cursor ───────────────────────────────────────────────────────────
      cursor = {
        theme = "ArcAurora-Cursors";
        # theme = "Capitaine-Cursors";
        # theme = "Bibata-Modern-Ice";
      };

      # ── Ambiente ─────────────────────────────────────────────────────────
      environment = {
        TZ = "America/Sao_Paulo";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
        OBS_USE_EGL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_QPA_PLATFORMTHEME = "qt6ct";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11,*";
        _JAVA_AWT_WM_NONREPARENTING = "1";
        ELECTRON_ENABLE_WAYLAND = "1";
        RADV_PERFTEST = "video_decode";
        DISPLAY = ":0";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_ENABLE_HIGHDPI_SCALING = "1";
        NIXOS_OZONE_WL = "1";
      };

      # ── Input ────────────────────────────────────────────────────────────
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            variant = "intl";
          };
          repeat-delay = 250;
          repeat-rate = 50;
          numlock = true;
        };

        touchpad = {
          tap = true;
          natural-scroll = true;
        };

        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "0%";
        };
      };

      # ── Outputs / Monitores ──────────────────────────────────────────────
      outputs = {
        "HDMI-A-1" = {
          enable = true;
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.0;
          };
          position = {
            x = 0;
            y = 0;
          };
          scale = 1.0;
        };
        "eDP-1".enable = false;
      };

      # ── Layout ───────────────────────────────────────────────────────────
      layout = {
        gaps = 5;
        center-focused-column = "never";
        always-center-single-column = true;

        preset-column-widths = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
        ];

        default-column-width.proportion = 0.5;

        focus-ring = {
          enable = true;
          width = 1.5;
          active.color = "#c9b8f5";
          inactive.color = "#505050";
        };

        border = {
          enable = false;
          width = 4;
          active.color = "#ffc87f";
          inactive.color = "#505050";
          urgent.color = "#9b0000";
        };

        shadow = {
          enable = true;
          softness = 30.0;
          spread = 5.0;
          offset = {
            x = 0.0;
            y = 5.0;
          };
          color = "#0007";
        };

        struts = {
          top = 0;
          bottom = 0;
          left = 0;
          right = 0;
        };
      };

      # ── Hotkey Overlay ───────────────────────────────────────────────────
      hotkey-overlay.hide-not-bound = false;

      # ── Autostart ────────────────────────────────────────────────────────
      spawn-at-startup = [
        {command = ["noctalia"];}
        {command = ["xwayland-satellite"];}
        {command = ["kdeconnect-indicator"];}
        {command = ["sh" "-c" "nm-applet --indicator"];}
        {command = ["swaylock-effects"];}
        {command = ["sh" "-c" "wl-paste --watch cliphist store"];}
        #{command = ["sh" "-c" "${./swayidle-lock.sh}"];}
      ];

      # ── Window Rules ─────────────────────────────────────────────────────
      window-rules = [
        {
          matches = [{app-id = "^org\\.wezfurlong\\.wezterm$";}];
          geometry-corner-radius = {
            top-left = 20.0;
            top-right = 20.0;
            bottom-left = 20.0;
            bottom-right = 20.0;
          };
          clip-to-geometry = true;
          default-column-width = {};
        }
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
        }
        {
          matches = [];
          geometry-corner-radius = {
            top-left = 13.0;
            top-right = 13.0;
            bottom-left = 13.0;
            bottom-right = 13.0;
          };
          clip-to-geometry = true;
        }
      ];

      # ── Layer Rules ──────────────────────────────────────────────────────
      layer-rules = [
        {
          matches = [{namespace = "^noctalia-overview*";}];
          place-within-backdrop = true;
        }
      ];

      # ── Keybinds ─────────────────────────────────────────────────────────
      binds = {
        # ── Hotkey overlay ──
        "Mod+Shift+Slash".action.show-hotkey-overlay = {};

        # ── Apps ──
        "Mod+Return" = {
          action.spawn = ["kitty"];
          hotkey-overlay.title = "Open a Terminal: kitty";
        };
        "Mod+D" = {
          action.spawn = ["fuzzel"];
          hotkey-overlay.title = "Run an Application: fuzzel";
        };
        "Super+Alt+L" = {
          action.spawn = ["swaylock"];
          hotkey-overlay.title = "Lock the Screen: swaylock";
        };
        "Mod+Print".action.spawn = ["flameshot"];
        "Mod+X".action.spawn = ["sh" "-c" "/etc/profiles/per-user/pc120/bin/noctalia-shell ipc call sessionMenu toggle"];
        "Mod+F4".action.spawn = ["gimp"];
        "Mod+F3" = {
          action.spawn = ["firefox"];
          hotkey-overlay.title = "Run an Application: firefox";
        };
        "Mod+F5".action.spawn = ["noctalia-shell" "ipc" "call" "launcher" "clipboard"];
        "Mod+F6".action.spawn = ["vlc"];
        "Mod+F1" = {
          action.spawn = ["brave"];
          hotkey-overlay.title = "Run an Application: brave";
        };
        "Mod+F2" = {
          action.spawn = ["google-chrome-stable"];
          hotkey-overlay.title = "Run an Application: google";
        };
        "Mod+F8" = {
          action.spawn = ["nautilus"];
          hotkey-overlay.title = "Run an Application: nautilus";
        };
        "Mod+F11" = {
          action.spawn = ["rofi" "-show" "drun"];
          hotkey-overlay.title = "Run an Application: rofi";
        };
        "Mod+F12".action.spawn = ["sh" "-c" "noctalia-shell ipc call launcher toggle"];

        # Orca
        "Super+Alt+S" = {
          action.spawn = ["sh" "-c" "pkill orca || exec orca"];
          allow-when-locked = true;
          hotkey-overlay.hidden = true;
        };

        # ── Áudio ──
        "XF86AudioRaiseVolume" = {
          action.spawn = ["sh" "-c" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"];
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action.spawn = ["sh" "-c" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"];
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action.spawn = ["sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"];
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action.spawn = ["sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"];
          allow-when-locked = true;
        };

        # ── Mídia ──
        "XF86AudioPlay" = {
          action.spawn = ["sh" "-c" "playerctl play-pause"];
          allow-when-locked = true;
        };
        "XF86AudioStop" = {
          action.spawn = ["sh" "-c" "playerctl stop"];
          allow-when-locked = true;
        };
        "XF86AudioPrev" = {
          action.spawn = ["sh" "-c" "playerctl previous"];
          allow-when-locked = true;
        };
        "XF86AudioNext" = {
          action.spawn = ["sh" "-c" "playerctl next"];
          allow-when-locked = true;
        };

        # ── Brilho ──
        "XF86MonBrightnessUp" = {
          action.spawn = ["brightnessctl" "--class=backlight" "set" "+10%"];
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action.spawn = ["brightnessctl" "--class=backlight" "set" "10%-"];
          allow-when-locked = true;
        };

        # ── Overview ──
        "Mod+O" = {
          action.toggle-overview = {};
          repeat = false;
        };

        # ── Fechar janela ──
        "Mod+Q" = {
          action.close-window = {};
          repeat = false;
        };

        # ── Foco ──
        "Mod+Left".action.focus-column-left = {};
        "Mod+Down".action.focus-window-down = {};
        "Mod+Up".action.focus-window-up = {};
        "Mod+Right".action.focus-column-right = {};
        "Mod+H".action.focus-column-left = {};
        "Mod+J".action.focus-window-down = {};
        "Mod+K".action.focus-window-up = {};
        "Mod+L".action.focus-column-right = {};

        # ── Mover janelas ──
        "Mod+Ctrl+Left".action.move-column-left = {};
        "Mod+Ctrl+Down".action.move-window-down = {};
        "Mod+Ctrl+Up".action.move-window-up = {};
        "Mod+Ctrl+Right".action.move-column-right = {};
        "Mod+Ctrl+H".action.move-column-left = {};
        "Mod+Ctrl+J".action.move-window-down = {};
        "Mod+Ctrl+K".action.move-window-up = {};
        "Mod+Ctrl+L".action.move-column-right = {};

        # ── Início / Fim ──
        "Mod+Home".action.focus-column-first = {};
        "Mod+End".action.focus-column-last = {};
        "Mod+Ctrl+Home".action.move-column-to-first = {};
        "Mod+Ctrl+End".action.move-column-to-last = {};

        # ── Monitores — foco ──
        "Mod+Shift+Left".action.focus-monitor-left = {};
        "Mod+Shift+Down".action.focus-monitor-down = {};
        "Mod+Shift+Up".action.focus-monitor-up = {};
        "Mod+Shift+Right".action.focus-monitor-right = {};
        "Mod+Shift+H".action.focus-monitor-left = {};
        "Mod+Shift+J".action.focus-monitor-down = {};
        "Mod+Shift+K".action.focus-monitor-up = {};
        "Mod+Shift+L".action.focus-monitor-right = {};

        # ── Monitores — mover coluna ──
        "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = {};
        "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = {};
        "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = {};
        "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = {};
        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = {};
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = {};
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = {};
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = {};

        # ── Workspaces — foco ──
        "Mod+Page_Down".action.focus-workspace-down = {};
        "Mod+Page_Up".action.focus-workspace-up = {};
        "Mod+U".action.focus-workspace-down = {};
        "Mod+I".action.focus-workspace-up = {};

        # ── Workspaces — mover coluna ──
        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = {};
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = {};
        "Mod+Ctrl+U".action.move-column-to-workspace-down = {};
        "Mod+Ctrl+I".action.move-column-to-workspace-up = {};

        # ── Workspaces — mover workspace ──
        "Mod+Shift+Page_Down".action.move-workspace-down = {};
        "Mod+Shift+Page_Up".action.move-workspace-up = {};
        "Mod+Shift+U".action.move-workspace-down = {};
        "Mod+Shift+I".action.move-workspace-up = {};

        # ── Scroll — workspaces ──
        "Mod+WheelScrollDown" = {
          action.focus-workspace-down = {};
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action.focus-workspace-up = {};
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          action.move-column-to-workspace-down = {};
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          action.move-column-to-workspace-up = {};
          cooldown-ms = 150;
        };

        # ── Scroll — colunas ──
        "Mod+WheelScrollRight".action.focus-column-right = {};
        "Mod+WheelScrollLeft".action.focus-column-left = {};
        "Mod+Ctrl+WheelScrollRight".action.move-column-right = {};
        "Mod+Ctrl+WheelScrollLeft".action.move-column-left = {};
        "Mod+Shift+WheelScrollDown".action.focus-column-right = {};
        "Mod+Shift+WheelScrollUp".action.focus-column-left = {};
        "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = {};
        "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = {};

        # ── Workspaces numerados ──
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;

        # ── Consume / expulsa janela ──
        "Mod+BracketLeft".action.consume-or-expel-window-left = {};
        "Mod+BracketRight".action.consume-or-expel-window-right = {};
        "Mod+Comma".action.consume-window-into-column = {};
        "Mod+Period".action.expel-window-from-column = {};

        # ── Redimensionar ──
        "Mod+R".action.switch-preset-column-width = {};
        "Mod+Ctrl+R".action.reset-window-height = {};
        "Mod+F".action.maximize-column = {};
        "Mod+Shift+F".action.fullscreen-window = {};
        "Mod+Ctrl+F".action.expand-column-to-available-width = {};
        "Mod+C".action.center-column = {};
        "Mod+Ctrl+C".action.center-visible-columns = {};
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        # ── Floating ──
        "Mod+V".action.toggle-window-floating = {};
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = {};

        # ── Tabs ──
        "Mod+W".action.toggle-column-tabbed-display = {};

        # ── Screenshot ──
        "Mod+P".action.screenshot = {};
        "Ctrl+Print".action.screenshot-screen = {};
        "Alt+Print".action.screenshot-window = {};

        # ── Inibidor de atalhos ──
        "Mod+Escape" = {
          action.toggle-keyboard-shortcuts-inhibit = {};
          allow-inhibiting = false;
        };

        # ── Sistema ──
        "Mod+Shift+R".action.spawn = ["sh" "-c" "niri msg action load-config-file"];
        "Mod+Shift+E".action.quit = {};
        "Ctrl+Alt+Delete".action.quit = {};
        "Mod+Shift+P".action.power-off-monitors = {};
      };
    };
  };
}
