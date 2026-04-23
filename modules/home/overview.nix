{ lib, pkgs, ... }: let
  overviewSource = pkgs.runCommand "overview-src" {} ''
    cp -R ${./overview} $out
    chmod -R u+rwX $out
  '';
in {
  home.activation.seedOverviewCode = lib.hm.dag.entryAfter ["writeBoundary"] ''
    rm -rf "$HOME/.config/quickshell/overview"
    mkdir -p "$HOME/.config/quickshell"
    cp -R ${overviewSource} "$HOME/.config/quickshell/overview"
    chmod -R u+rwX "$HOME/.config/quickshell/overview"
  '';
}
