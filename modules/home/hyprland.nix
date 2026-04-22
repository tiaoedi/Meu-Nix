{ pkgs
, inputs
, username
, ...
}:
let
  colresizeToggle = pkgs.writeShellScriptBin "colresize-toggle" ''
    CURRENT=$(hyprctl activewindow -j | jq '.size[0]')
    MONITOR=$(hyprctl monitors -j | jq '.[0].width')
    THRESHOLD=$(echo "$MONITOR * 0.9" | bc | cut -d. -f1)
    if [ "$CURRENT" -ge "$THRESHOLD" ]; then
      hyprctl dispatch layoutmsg "colresize -0.5"
    else
      hyprctl dispatch layoutmsg "colresize +0.5"
    fi
  '';
in
{
  home.packages = [ colresizeToggle ];
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # ── Monitor ──────────────────────────────────────────────────────────
      monitor = "HDMI-A-1,1920x1080@60,0x0,1";
      # ── Variáveis ────────────────────────────────────────────────────────
      "$mainMod" = "SUPER";
      "$files" = "nautilus";
      "$browser" = "google-chrome-stable";
      "$term" = "kitty";
      # ── Ambiente ─────────────────────────────────────────────────────────
      env = [
        "TZ,America/Sao_Paulo"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,24"
      ];
      # ── Input ────────────────────────────────────────────────────────────
      input = {
        kb_layout = "us";
        kb_variant = "alt-intl";
        repeat_delay = 250;
        repeat_rate = 50;
        follow_mouse = 1;
        numlock_by_default = 1;
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
          drag_lock = true;
          disable_while_typing = true;
        };
      };
      # ── Geral ────────────────────────────────────────────────────────────
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(7aa2f7aa) rgba(c4a7e7aa) 45deg";
        "col.inactive_border" = "rgba(414868aa)";
        layout = "scrolling";
        resize_on_border = true;
        extend_border_grab_area = 5;
      };
      scrolling = {
        column_width = 0.5;
        follow_focus = true;
        fullscreen_on_one_column = false;
      };
      # ── Decoração ────────────────────────────────────────────────────────
      decoration = {
        rounding = 10;
        active_opacity = 0.85;
        inactive_opacity = 0.70;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 10;
          passes = 4;
          new_optimizations = true;
          xray = true;
          ignore_opacity = true;
          special = true;
          popups = true;
        };
      };
      # ── Animações ────────────────────────────────────────────────────────
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      # ── Layout ───────────────────────────────────────────────────────────
      master = {
        new_status = "master";
        mfact = 0.5;
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
      };
      binds = {
        workspace_back_and_forth = true;
      };
      # ── Autostart ────────────────────────────────────────────────────────
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "noctalia-shell"
        "xwayland-satellite"
        "kdeconnect-indicator"
        "nm-applet --indicator"
        "wl-paste --watch cliphist store"
        "sleep 3 && systemctl --user start hypridle"
      ];
      # ── Keybinds ─────────────────────────────────────────────────────────
      bind =
        [
          # Sistema
          "$mainMod SHIFT, R, exec, hyprctl reload"
          "$mainMod SHIFT, Q, killactive"
          "$mainMod, Q, killactive"
          "$mainMod SHIFT, E, exit"
          # "$mainMod, F, exec, ~/Meu-Nix/modules/home/scripts/colresize-toggle.sh"
          "$mainMod, F, exec, colresize-toggle"
          "$mainMod SHIFT, F, fullscreen"
          "$mainMod, V, togglefloating"
          # Apps
          "$mainMod, Return, exec, $term"
          "$mainMod, T, exec, $term"
          "$mainMod SHIFT, Return, exec, $files"
          "$mainMod, F1, exec, brave"
          "$mainMod, F2, exec, $browser"
          "$mainMod, F3, exec, firefox"
          "$mainMod, F4, exec, gimp"
          "$mainMod, F5, exec, noctalia-shell ipc call launcher clipboard"
          "$mainMod, F6, exec, vlc"
          "$mainMod, F8, exec, $files"
          "$mainMod, F11, exec, rofi -show drun -show-icons"
          "$mainMod, P, exec, grimblast copy area"
          "$mainMod, A, exec, rofi -show window"
          "$mainMod, F12, exec, noctalia-shell ipc call launcher toggle"
          "$mainMod, X, exec, noctalia-shell ipc call sessionMenu toggle"
          "$mainMod, D, exec, fuzzel"
          "$mainMod, E, exec, code"
          "SUPER ALT, L, exec, swaylock"
          "$mainMod, O, exec, overview-toggle"
          # Screenshot
          ", Print, exec, flameshot"
          "CTRL, Print, exec, flameshot screen"
          "ALT, Print, exec, flameshot gui"
          # Foco
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"
          # Mover janelas
          "$mainMod CTRL, H, movewindow, l"
          "$mainMod CTRL, L, movewindow, r"
          "$mainMod CTRL, K, movewindow, u"
          "$mainMod CTRL, J, movewindow, d"
          "$mainMod SHIFT, Left, exec, hyprctl dispatch movewindow l"
          "$mainMod SHIFT, Right, exec, hyprctl dispatch movewindow r"
          "$mainMod SHIFT, Up, exec, hyprctl dispatch movewindow u"
          "$mainMod SHIFT, Down, exec, hyprctl dispatch movewindow d"
          # Workspaces
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          "$mainMod, period, workspace, e+1"
          "$mainMod, comma, workspace, e-1"
          "$mainMod, tab, workspace, m+1"
          "$mainMod SHIFT, tab, workspace, m-1"
          "ALT, tab, workspace, m+1"
          "ALT SHIFT, tab, workspace, m-1"
          "$mainMod SHIFT, U, movetoworkspace, special"
          "$mainMod, U, togglespecialworkspace,"
          # Layout master
          "$mainMod, I, layoutmsg, addmaster"
          "$mainMod CTRL, Return, layoutmsg, swapwithmaster"
          # Mídia
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioStop, exec, playerctl stop"
          # Brilho
          ", XF86MonBrightnessUp, exec, brightnessctl --class=backlight set +10%"
          ", XF86MonBrightnessDown, exec, brightnessctl --class=backlight set 10%-"
          # Grupos
          "$mainMod, G, togglegroup"
        ]
        ++ (builtins.concatLists (builtins.genList
          (
            i:
            let
              ws = toString (i + 1);
            in
            [
              "$mainMod, ${ws}, workspace, ${ws}"
              "$mainMod SHIFT, ${ws}, movetoworkspace, ${ws}"
            ]
          )
          9));
      # Redimensionar
      binde = [
        "$mainMod SHIFT, H, resizeactive,-50 0"
        "$mainMod SHIFT, L, resizeactive,50 0"
        "$mainMod SHIFT, K, resizeactive,0 -50"
        "$mainMod SHIFT, J, resizeactive,0 50"
      ];
      # Mouse
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
