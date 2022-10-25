{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
# configuration shared by all hosts
{
  console.font = "Lat2-Terminus16";

  # enable zsh autocompletion for system packages (systemd, etc)
  environment = {
    etc = {
      "nix/flake-channels/system".source = inputs.self;
      "nix/flake-channels/nixpkgs".source = inputs.nixpkgs;
      "nix/flake-channels/home-manager".source = inputs.hm;
    };

    systemPackages = [pkgs.git pkgs.gcc pkgs.clang];

    pathsToLink = ["/share/zsh"];
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    # saves space
    supportedLocales = ["en_US.UTF-8/UTF-8"];
  };

  # OpenGL
  hardware.opengl.enable = true;

  networking = {
    firewall.checkReversePath = "loose";
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      builders-use-substitutes = true
      experimental-features = nix-command flakes

      # for direnv GC roots
      keep-outputs = true
      keep-derivations = true
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    registry = lib.mapAttrs (n: v: {flake = v;}) inputs;

    nixPath = [
      "nixpkgs=/etc/nix/flake-channels/nixpkgs"
      "home-manager=/etc/nix/flake-channels/home-manager"
    ];

    settings = {
      auto-optimise-store = true;

      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  nixpkgs = {
    pkgs = inputs.self.pkgs.${config.nixpkgs.system};
    config.allowUnfree = true;
  };

  # enable programs
  programs.less.enable = true;
  programs.command-not-found.enable = false;

  # enable realtime capabilities to user processes
  security.rtkit.enable = true;

  security.sudo.wheelNeedsPassword = false;

  # services
  services = {
    openssh = {
      enable = true;
      useDns = true;
    };

    resolved.enable = true;
  };

  system.stateVersion = "21.11";

  time.timeZone = "Asia/Kolkata";
  users.users.astro = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ["adbusers" "networkmanager" "docker" "libvirtd" "transmission" "video" "wheel"];
    description = "Astro";
  };

  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";

  # Speeed
  environment.binsh = "${pkgs.dash}/bin/dash";
}
