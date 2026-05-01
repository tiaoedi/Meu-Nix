{pkgs, ...}: {
  imports = [
    #./terminals/alacritty.nix
    ./terminals/tmux.nix
    ./terminals/ghostty.nix
    ./editors/nixvim.nix
    ./cli/bat.nix
    ./cli/btop.nix
    ./cli/bottom.nix
    ./cli/eza.nix
    ./cli/fzf.nix
    ./cli/git.nix
    ./cli/htop.nix
    ./cli/tealdeer.nix
    ./yazi
    ./overview.nix
    ./niri.nix
    ./hyprland.nix
    ./hypridle.nix
    ./noctalia.nix
    ./overview-toggle.nix
  ];
  home.packages = [
    (pkgs.stdenv.mkDerivation {
      name = "arc-aurora-cursors";
      src = pkgs.fetchFromGitHub {
        owner = "yeyushengfan258";
        repo = "ArcAurora-Cursors";
        rev = "main";
        sha256 = "sha256-u/x8aEeOskv6R8uCB4ojn9tXxTxflejWACxgp03o9PI=";
      };
      installPhase = ''
        mkdir -p $out/share/icons/ArcAurora-Cursors
        cp -r dist/cursors $out/share/icons/ArcAurora-Cursors/
        cp dist/index.theme $out/share/icons/ArcAurora-Cursors/
      '';
    })
  ];
}
