{
  config,
  inputs,
  lib,
  pkgs,
  ...
}@args:{
  home.packages = (with pkgs; [
    wf-recorder
    xorg.xprop
  ]) ++ [ inputs.hyprpicker.packages.${pkgs.system}.hyprpicker 
  #inputs.hyprland.packages.${pkgs.system}.waybar-hyprland 
  ];

  home.sessionVariables.XCURSOR_SIZE = builtins.toString config.home.pointerCursor.size;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = import ./config.nix args;
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
      }
      {
        timeout = 310;
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
    ];
  };
  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];
  }