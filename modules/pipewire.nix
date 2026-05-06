{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    pipewire
    pavucontrol
    alsa-utils
    alsa-plugins
    alsa-lib
    alsa-firmware
    ocamlPackages.gstreamer
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-ugly
    volumeicon
    playerctl
    easyeffects
  ];

  # PipeWire high quality audio config
  services.pipewire.extraConfig.pipewire = {
    "10-clock-rate" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [44100 48000 96000 192000];
        "default.clock.quantum" = 256;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 8192;
      };
    };
  };

  services.pipewire.extraConfig.pipewire-pulse = {
    "11-pulse-config" = {
      "pulse.properties" = {
        "pulse.min.req" = "32/48000";
        "pulse.default.req" = "256/48000";
        "pulse.max.req" = "512/48000";
        "pulse.min.frag" = "32/48000";
        "pulse.max.frag" = "512/48000";
        "pulse.min.quantum" = "32/48000";
        "pulse.max.quantum" = "512/48000";
      };
    };
  };
}
