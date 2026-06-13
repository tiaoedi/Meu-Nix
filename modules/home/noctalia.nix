{ inputs
, pkgs
, ...
}: {
  imports = [ inputs.noctalia.homeModules.default ];
  programs.noctalia = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      shell = {
        font = "Anonymous Pro for Powerline";
      };
    };
  };
}


