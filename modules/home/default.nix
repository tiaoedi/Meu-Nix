{...}: {
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
    ./noctalia.nix
  ];
}
