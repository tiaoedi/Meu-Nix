{
  config,
  lib,
  pkgs,
  ...
}: {
  services.greetd.enable = lib.mkDefault false;

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      bigclock = true;
      bg = "0x00000000";
      fg = "0x0000FFFF";
      border_fg = "0x00FF0000";
      error_fg = "0x00FF0000";
      clock_color = "#800080";

      # ✅ adiciona /etc/wayland-sessions
      waylandsessions = "/etc/wayland-sessions:/nix/store/02db5zr49c5y65py90jf35xqardc6hyx-desktops/share/wayland-sessions";
    };
  };
}
