{ lib, ... }: {
  home.file = {
    ".config/quickshell/overview/shell.qml".source = ./overview/shell.qml;
    ".config/quickshell/overview/common".source = ./overview/common;
    ".config/quickshell/overview/modules".source = ./overview/modules;
    ".config/quickshell/overview/services".source = ./overview/services;
    ".config/quickshell/overview/assets".source = ./overview/assets;
  };
}
