{pkgs, ...}: let
  arcAuroraCursors = pkgs.stdenv.mkDerivation {
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
  };
in {
  home.packages = [arcAuroraCursors];

  home.pointerCursor = {
    package = arcAuroraCursors;
    name = "ArcAurora-Cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
