{ pkgs, inputs, username, ... }: let
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
in {
  home.packages = [ colresizeToggle ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "HDMI-A-1,1920x1080@60,0x0,1";
      "$mainMod" = "SUPER";
      exec-once = [
        "noctalia-shell"
        "qs -c overview"
        "nm-applet --indicator"
        "wl-paste --watch cliphist store"
      ];
      bind = [
        "$mainMod, Q, killactive"
        "$mainMod SHIFT, E, exit"
        "$mainMod, Return, exec, ghostty"
      ];
    };
  };
}
