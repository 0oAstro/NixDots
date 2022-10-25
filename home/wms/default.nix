{
  config,
  pkgs,
  lib,
  colors,
  ...
}:
# Wayland config
let
  inherit (colors) xcolors;

  _ = lib.getExe;

  ocrScript = pkgs.writeShellScriptBin "wl-ocr" ''
    ${_ pkgs.grim} -g "$(${_ pkgs.slurp})" -t ppm - | ${_ pkgs.tesseract5} - - | ${pkgs.wl-clipboard}/bin/wl-copy
  '';
in {
  imports = [
    # TODO: eww
    # ../eww
    ./hyprland
    ./sway
    ./river
  ];

  home.packages = with pkgs; [
    # screenrec
    peek

    # wm
    wayfire

    # utils
    wl-clipboard
    wlr-randr
    wlogout
      
    # scripts
    ocrScript
    
    # launchers
    wofi
    jq # for makoctl and hyprctl
    
    # utils
    swaybg
    swaylock-effects
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
  };

  programs = {
    mako = {
      enable = true;
      sort = "-priority";
      layer = "overlay";
      width = 300;
      height = 250;
      borderRadius = 7;
      borderSize = 3;
      borderColor = xcolors.base08;
      defaultTimeout = 5000;
      font = "JetBrainsMono Nerd Font 12";
      margin = "20,20,0";
      padding = "15,15,15";
      groupBy = "summary";
      backgroundColor = xcolors.base01;
      textColor = xcolors.base05;
      format = "<span font='JetBrainsMono Nerd Font weight=500' size='12288'>%s</span>\\n<span font='JetBrainsMono Nerd Font weight=425' size='11188'>%b</span>";

      extraConfig = ''
        icon-location=right
        icon-path=${config.gtk.iconTheme.package}/share/icons/${config.gtk.iconTheme.name}
        on-button-middle=exec ${pkgs.mako}/bin/makoctl menu -n "$id" ${pkgs.wofi}/bin/wofi --dmenu

        [grouped]
        format=<span font="JetBrainsMono Nerd Font weight=500" size="12288">%s</span>\n<span font="JetBrainsMono Nerd Font weight=425" size="12288">%b</span>

        [mode=do-not-disturb]
        invisible=1

        [urgency="low"]
        border-color=${xcolors.base02}

        [urgency="critical"]
        text-color=${xcolors.base08}
        default-timeout=10000
      '';
    };
  };

  services.wlsunset = {
      enable = true;
      latitude = "26.84";
      longitude = "80.94";
    };
    programs.swaylock.settings = let
      inherit (colors) xcolors;
      in {
      clock = true;
      font = "JetBrainsMono Nerd Font";
      ignore-empty-password = true;
      image = "${config.xdg.configHome}/wallpaper.png";
      effect-blur = "30x3";
      indicator = true;
      bs-hl-color = xcolors.base08;
      key-hl-color = xcolors.base0B;
      inside-clear-color = xcolors.base09;
      inside-color = xcolors.base00;
      inside-ver-color = xcolors.base0B;
      inside-wrong-color = xcolors.base08;
      line-color = xcolors.base02;
      line-ver-color = xcolors.base02;
      line-wrong-color = xcolors.base02;
      line-clear-color = xcolors.base02;
      ring-color = xcolors.base02;
      ring-ver-color = xcolors.base02;
      ring-wrong-color = xcolors.base02;
      ring-clear-color = xcolors.base02;
      separator-color = xcolors.base02;
      text-color = xcolors.base05;
      text-ver-color = xcolors.base00;
      text-wrong-color = xcolors.base00;
      text-clear-color = xcolors.base00;
    };

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
}
