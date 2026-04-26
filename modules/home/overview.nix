{
  lib,
  pkgs,
  ...
}: {
  home.activation.seedOverviewCode = lib.hm.dag.entryAfter ["writeBoundary"] ''
    rm -rf "$HOME/.config/quickshell/overview"
    mkdir -p "$HOME/.config/quickshell"
    cp -RL ${./overview} "$HOME/.config/quickshell/overview"
    chmod -R u+rwX "$HOME/.config/quickshell/overview"
  '';
}
