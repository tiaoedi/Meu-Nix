{
  description = "Meu-Nix'NixOS-Hyprland";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    alejandra.url = "github:kamadorueda/alejandra/4.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim/main";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.55.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell?rev=e162429b6fa4443a0b45e19a867277dcc25d506b";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs @ { self
    , nixpkgs
    , niri
    , ...
    }:
    let
      system = "x86_64-linux";
      host = "Nix";
      username = "pc120";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      waybarWeatherPkg = pkgs.callPackage ./pkgs/waybar-weather.nix { };
    in
    {
      packages.${system} = {
        waybar-weather = waybarWeatherPkg;
      };
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem rec {
          specialArgs = {
            inherit system;
            inherit inputs;
            inherit username;
            inherit host;
          };
          modules = [
            ./hosts/${host}/config.nix
            ./modules/overlays.nix
            ./modules/quickshell.nix
            ./modules/packages.nix
            { nixpkgs.config.allowBroken = true; }
            ./modules/fonts.nix
            ./modules/portals.nix
            ./modules/theme.nix
            ./modules/ly.nix
            ./modules/nh.nix
            ./modules/polkit.nix
            ./modules/overlays/python-svg-fix.nix
            # ✅ cache permanente
            {
              nix.settings = {
                extra-substituters = [
                  "https://niri.cachix.org"
                  "https://noctalia.cachix.org"
                  "https://hyprland.cachix.org"
                ];
                extra-trusted-public-keys = [
                  "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
                  "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
                  "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                ];
              };
            }
            # ✅ sessões para o ly
            {
              environment.etc = {
                "wayland-sessions/niri.desktop".text = ''
                  [Desktop Entry]
                  Name=niri
                  Comment=A scrollable-tiling Wayland compositor
                  Exec=niri-session
                  Type=Application
                '';
                "wayland-sessions/hyprland.desktop".text = ''
                  [Desktop Entry]
                  Name=Hyprland
                  Comment=A dynamic tiling Wayland compositor
                  Exec=start-hyprland
                  Type=Application
                '';
              };
            }
            inputs.catppuccin.nixosModules.catppuccin
            inputs.hyprland.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                inherit inputs system username host;
              };
              home-manager.users.${username} = {
                home.username = username;
                home.homeDirectory = "/home/${username}";
                home.stateVersion = "24.05";
                imports = [
                  ./modules/home/default.nix
                  inputs.niri.homeModules.niri
                  inputs.hyprland.homeManagerModules.default
                ];
              };
            }
          ];
        };
      };
      formatter.x86_64-linux = inputs.alejandra.defaultPackage.x86_64-linux;
    };
}
