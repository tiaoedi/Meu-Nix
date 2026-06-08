{ inputs
, pkgs
, ...
}: {
  imports = [ inputs.noctalia.homeModules.default ];
  programs.noctalia = {
    enable = true;
  };
}
