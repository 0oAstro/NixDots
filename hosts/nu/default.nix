{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  # kernel
  boot.kernelModules = [];
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  boot.kernelParams = [
    "libata.noacpi=1"
    "fsck.mode=skip"
    "random.trust_cpu=on"
    "quiet"
    "udev.log_level=3"
    "loglevel=3"
    "systemd.show_status=auto"
    "rd.udev.log_level=3"
    "vt.global_cursor_default=0"
  ];

  # bootloader
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
      };
    };
    consoleLogLevel = 0;
    initrd.verbose = false;
  };
  
  # hibernate
  powerManagement.resumeCommands = "${pkgs.systemd}/bin/systemctl restart systemd-networkd.service";

  hardware.opengl = {
    driSupport = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  networking = {
    hostName = "nu";
    # Ethernet supremacy
    wireless.enable = false;
    useDHCP = false;
    dhcpcd.enable = false;
    useNetworkd = true;
  };

  programs = {
    adb.enable = true;
    steam.enable = true;
  };

  services = {
    btrfs.autoScrub.enable = true;

    printing.enable = false;

    xserver.videoDrivers = ["modesetting"];
  };

  virtualisation.podman = {
    enable = true;
  };

  systemd = {
    network.enable = true;
    network.networks = let
      networkConfig = {
        DHCP = "yes";
        DNSSEC = "yes";
        DNSOverTLS = "yes";
        DNS = ["1.1.1.1" "1.0.0.1"];
      };
    in {
      # Config for all useful interfaces
      "40-wired" = {
        enable = true;
        name = "en*";
        inherit networkConfig;
        dhcpV4Config.RouteMetric = 1024; # Better be explicit
      };
      "40-wireless" = {
        enable = true;
        name = "wl*";
        inherit networkConfig;
        dhcpV4Config.RouteMetric = 2048; # Prefer wired
      };
    };
    services = {
      "systemd-networkd-wait-online".enable = false;
      NetworkManager-wait-online.enable = false;
      systemd-user-sessions.enable = false;
      systemd-journal-flush.enable = false;
    };
  };
}
