# 💫 https://github.com/JaKooLit 💫 #
# Users - NOTE: Packages defined on this will be on current user only
{ pkgs
, username
, ...
}:
let
  inherit (import ./variables.nix) gitUsername;
in
{
  users = {
    mutableUsers = true;
    groups.pc120 = { };
    users."pc120" = {
      homeMode = "755";
      isNormalUser = true;
      group = "pc120";
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "kvm"
        "audio"
        "waydroid"
      ];

      # define user packages here
      packages = with pkgs; [
      ];
    };

    defaultUserShell = pkgs.zsh;
  };

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ lsd fzf git ];
  programs = {
    zsh = {
      ohMyZsh = {
        enable = true;
        theme = "ys";
        plugins = [ "git" ];
      };
      # Enable zsh plugins via NixOS module options
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}
