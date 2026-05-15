#bv 💫 https://github.com/JaKooLit 💫 #
# Main default config
{
  config,
  pkgs,
  lib,
  host,
  username,
  options,
  ...
}: let
  inherit (import ./variables.nix) keyboardLayout;
in {
  imports = [
    ./hardware.nix
    ./users.nix
    ./packages-fonts.nix
    ../../modules/amd-drivers.nix
    ../../modules/nvidia-drivers.nix
    ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    ../../modules/pipewire.nix
    #../../modules/virt-manager.nix
    #.../.../modules/overlays/python-svg-fix.nix
    #../../modules/virt-manager.nix
  ];

  # BOOT related stuffV
  boot = {
    #kernelPackages = pkgs.linuxPackages_zen; # zen Kernel
    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" # this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco" # watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" # watchdog for Intel
      "androidboot.hardware=waydroid"
    ];
    kernelModules = ["btintel" "bluetooth" "ip_tables" "ip6_tables" "iptable_nat" "iptable_filter" "ipt_MASQUERADE" "ip6t_MASQUERADE"];
    # This is for OBS Virtual Cam Support
    #kernelModules = [ "v4l2loopback" ];
    #  extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    # Acelera o boot
    systemd.services.NetworkManager-wait-online.enable = false;
    systemd.services.docker.wantedBy = lib.mkForce ["multi-user.target"];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [];
    };

    # Needed For Some Steam Games
    #kernel.sysctl = {
    #  "vm.max_map_count" = 2147483642;
    #};

    ## BOOT LOADERS: NOTE USE ONLY 1. either systemd or grub
    # Bootloader SystemD
    loader.systemd-boot.enable = true;

    loader.efi = {
      #efiSysMountPoint = "/efi"; #this is if you have separate /efi partition
      canTouchEfiVariables = true;
    };

    loader.timeout = 5;

    # Bootloader GRUB
    #loader.grub = {
    #enable = true;
    #  devices = [ "nodev" ];
    #  efiSupport = true;
    #  gfxmodeBios = "auto";
    #  memtest86.enable = true;
    #  extraGrubInstallArgs = [ "--bootloader-id=${host}" ];
    #  configurationName = "${host}";
    #	 };

    # Bootloader GRUB theme, configure below

    ## -end of BOOTLOADERS----- ##

    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };

    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };

    plymouth.enable = true;
  };

  # GRUB Bootloader theme. Of course you need to enable GRUB above.. duh! and also, enable it on flake.nix
  #distro-grub-themes = {
  #  enable = true;
  #  theme = "nixos";
  #};

  # Extra Module Options
  drivers = {
    amdgpu.enable = true;
    intel.enable = true;
    nvidia.enable = false;
    nvidia-prime = {
      enable = false;
      intelBusID = "";
      nvidiaBusID = "";
    };
  };

  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  # networking
  networking = {
    networkmanager.enable = true;
    hostName = "Nix";
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
  };

  networking.nftables.enable = true;

  # Set your time zone.
  services.automatic-timezoned.enable = true; # based on IP location

  #https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "intl";
      };
    };

    smartd = {
      enable = false;
      autodetect = true;
    };

    gvfs.enable = true;
    tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    #pulseaudio.enable = false; #unstable
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    libinput.enable = true;

    rpcbind.enable = true;
    nfs.server.enable = true;

    openssh.enable = true;
    flatpak.enable = true;

    blueman.enable = true;

    #hardware.openrgb.enable = true;
    #hardware.openrgb.motherboard = "amd";

    fwupd.enable = true;

    upower.enable = true;

    gnome.gnome-keyring.enable = true;

    #printing = {
    #  enable = false;
    #  drivers = [
    # pkgs.hplipWithPlugin
    #  ];
    #};

    #avahi = {
    #  enable = true;
    #  nssmdns4 = true;
    #  openFirewall = true;
    #};

    #ipp-usb.enable = true;

    #syncthing = {
    #  enable = false;
    #  user = "${username}";
    #  dataDir = "/home/${username}";
    #  configDir = "/home/${username}/.config/syncthing";
    #};
  };

  systemd.services.flatpak-repo = {
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # zram
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };

  #hardware.sane = {
  #  enable = true;
  #  extraBackends = [ pkgs.sane-airscan ];
  #  disabledDefaultBackends = [ "escl" ];
  #};

  # Extra Logitech Support
  hardware = {
    logitech.wireless.enable = false;
    logitech.wireless.enableGraphical = false;
  };

  services.pulseaudio.enable = false; # stable branch

  # Bluetooth
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
  };

  # Security / Polkit
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    polkit.extraConfig = ''
       polkit.addRule(function(action, subject) {
         if (
           subject.isInGroup("users")
             && (
               action.id == "org.freedesktop.login1.reboot" ||
               action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
               action.id == "org.freedesktop.login1.power-off" ||
               action.id == "org.freedesktop.login1.power-off-multiple-sessions"
             )
           )
         {
           return polkit.Result.YES;
         }
      })
    '';
  };
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      substituters = [
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
        "https://quickshell.cachix.org"
        "https://niri.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "quickshell.cachix.org-1:SjE9pEXsGkyABdEkHkBBSExNbm8RgOzH1tDHJG1BZlw="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5d";
    };
  };

  programs.kdeconnect.enable = true;

  services.tailscale.enable = true;

  # Virtualization / Containers
  # Virtualization / Containers
  virtualisation.libvirtd = {
    enable = true;
    qemu.runAsRoot = true;
    extraConfig = ''
      secret_encryption_key_file = ""
    '';
  };
  programs.virt-manager.enable = true;
  virtualisation.waydroid.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  systemd.services.libvirtd.serviceConfig.LoadCredentialEncrypted = lib.mkForce "";
  virtualisation.podman = {
    enable = false;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = false;
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/libvirt/secrets 0700 root root -"
  ];

  systemd.services.libvirtd-credentials = {
    description = "Generate libvirtd encryption credentials";
    before = ["libvirtd.service"];
    wantedBy = ["libvirtd.service"];
    serviceConfig.Type = "oneshot";
    script = ''
      if [ ! -f /var/lib/libvirt/secrets/secrets-encryption-key ]; then
        ${pkgs.openssl}/bin/openssl rand 32 > /tmp/libvirt-rawkey
        systemd-creds encrypt --name=secrets-encryption-key /tmp/libvirt-rawkey /var/lib/libvirt/secrets/secrets-encryption-key
        rm /tmp/libvirt-rawkey
      fi
    '';
  };

  # OpenGL
  hardware.firmware = with pkgs; [linux-firmware];
  hardware.graphics = {
    enable = true;
  };

  console.keyMap = "us";

  virtualisation = {
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };

  #virtualisation.docker = {
  # enable = true;
  #};

  # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # For Hyprland QT Support
  environment.sessionVariables.QML_IMPORT_PATH = "${pkgs.hyprland-qt-support}/lib/qt-6/qml";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443];
    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
    trustedInterfaces = ["virbr0" "waydroid0"];
    checkReversePath = false;
  };
  programs.dconf.enable = true;

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  fileSystems."/dev/binderfs" = {
    device = "binderfs";
    fsType = "binder";
    options = ["defaults"];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Data de Intalação= 16-02-2026
}
# mount binderfs para waydroid - adicionar antes do fechamento

