{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  boot = {
    loader.timeout = 1;
  };
  fonts = {
    fonts = with pkgs; [
      # icon fonts
      material-icons
      material-design-icons
      font-awesome

      # Emoji fonts
      twemoji-color-font

      # normal fonts
      noto-fonts
      noto-fonts-cjk
      
      # sans and serif font
      inter
      zilla-slab

      # nerdfonts
      (nerdfonts.override {fonts = ["RobotoMono" "FiraCode" "JetBrainsMono" "VictorMono" "CascadiaCode"];})
    ];

    # use fonts specified by user rather than default ones
    enableDefaultFonts = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Zilla Slab" "Twitter Color Emoji"];
        sansSerif = ["Inter" "Noto Sans" "Twitter Color Emoji"];
        monospace = [ "JetBrainsMono Nerd Font" "Twitter Color Emoji"];
        emoji = ["Font Awesome 6 Free" "Font Awesome 6 Brands" "Twitter Color Emoji"];
      };
      localConf = ''
      <?xml version='1.0'?>
      <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
      <fontconfig>
       <match target="font">
          <test name="family"><string>scientifica</string></test>
          <edit name="antialias" mode="assign"><bool>false</bool></edit>
          <edit name="autohint" mode="assign"><bool>false</bool></edit>
          <edit name="hinting" mode="assign"><bool>false</bool></edit>
          <edit name="hintstyle" mode="assign"><const>hintnone</const></edit>
          <edit name="rgba" mode="assign"><const>none</const></edit>
        </match>
      </fontconfig>
      '';    };
  };

  environment.systemPackages = with pkgs; [
    glib
    gsettings-desktop-schemas
  ];
  
  environment.variables.NIXOS_OZONE_WL = "1";
  location.provider = "geoclue2";  
  
  programs.hyprland = {enable = true; package = null;};

  networking = {
    firewall = {
      # for Rocket League
      allowedTCPPortRanges = [
        {
          from = 27015;
          to = 27030;
        }
        {
          from = 27036;
          to = 27037;
        }
      ];
      allowedUDPPorts = [4380 27036 34197];
      allowedUDPPortRanges = [
        {
          from = 7000;
          to = 9000;
        }
        {
          from = 27000;
          to = 27031;
        }
      ];

      # Spotify downloaded track sync with other devices
      allowedTCPPorts = [57621];
    };
  };

  # add gaming cache
  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org" "https://hyprland.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs.dconf.enable = true;

  sound.enable = true;

  services = {
    dbus.packages = [pkgs.gcr];

    # provide location
    geoclue2 = {
      enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    xserver = {
      enable = true;
      libinput = {
        enable = true;
        # disable mouse acceleration
        mouse.accelProfile = "flat";
        mouse.accelSpeed = "0";
        mouse.middleEmulation = false;
      };
    };

    udev.packages = with pkgs; [gnome.gnome-settings-daemon];
  };

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  xdg.portal = {
    enable = true;
    wlr = {
      enable = true;
      settings.screencast = {
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
      };
    };
  };
}
