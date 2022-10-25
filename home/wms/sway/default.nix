{
  config,
  pkgs,
  lib,
  ...
}: {
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "swaylock -fF";
      }
      {
        event = "lock";
        command = "swaylock -fF";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "swaymsg output * dpms off";
        resumeCommand = "swaymsg output * dpms on";
      }
      {
        timeout = 300;
        command = "swaylock -fF";
      }
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    # package = pkgs.sway-borders;
    extraConfig = ''
           # Remove text on decorations
           for_window [title="."] title_format " "
           default_border normal 0
           default_floating_border normal 0
           for_window [title="."] title_format " "
           default_border normal 0
           default_floating_border normal 0
    '';
    config = {
      assigns = {
        "1: web" = [{class = "^Firefox$";}];
        "2: chat" = [{class = "^Discord$";}];
        "0: media" = [
          {class = "^Spotify$";}
          {class = "^mpv$";}
        ];
      };

      gaps = {
        inner = 12;
        outer = 12;
      };

      keybindings = let
        sway = config.wayland.windowManager.sway.config;
        m = sway.modifier;

        # toggle output scaling
        output = "VGA-1";
        # toggle-scaling = pkgs.writeShellScript "sway-scale-toggle" ''
        #   S=$(${pkgs.sway}/bin/swaymsg -t get_outputs | ${pkgs.jq}/bin/jq '.[] | select(any(. == "${output}")).scale')
        #   [ $S = 2 ] && S=1 || S=2
        #   swaymsg output "${output}" scale $S
        # '';
      in
        lib.mkOptionDefault {
          "${m}+Return" = "exec ${sway.terminal}";
          "${m}+q" = "kill";
          "${m}+space" = "exec ${sway.menu}";
          # Fn + F7
          # "${m}+semicolon" = "exec ${toggle-scaling}";
          # screenshots
          "Ctrl+Print" = "exec grim -c - ~/Pictures/ss/$(date '+%F_%T').png";
          "Print" = "exec slurp | grim -g - ~/Pictures/ss/$(date '+%F_%T').png";
          "${m}+Ctrl+Shift+r" = ''exec grim -c - | wl-copy'';
          "${m}+Shift+r" = ''exec slurp | grim -g - | wl-copy'';
        };

      keycodebindings = {
        "--locked --no-repeat 121" = "exec pulsemixer --toggle-mute"; # mute
        "--locked 122" = "exec pulsemixer --change-volume -6"; # vol-
        "--locked 123" = "exec pulsemixer --change-volume +6"; # vol+
        "--locked 171" = "exec playerctl next"; # next song
        "--locked --no-repeat 172" = "exec playerctl play-pause"; # play/pause
        "--locked 173" = "exec playerctl previous"; # prev song
        "--locked --no-repeat 198" = "exec amixer set Capture toggle"; # mic mute
        "--locked 232" = "exec light -U 5"; # brightness-
        "--locked 233" = "exec light -A 5"; # brightness+
      };

      menu = "wofi";
      terminal = "foot";
      modifier = "Mod4";
      bars = [];

      input = {
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
        "type:touchpad" = {
          click_method = "clickfinger";
          middle_emulation = "enabled";
          natural_scroll = "enabled";
          tap = "enabled";
        };
      };

      output = {
        "*" = {
          bg = "~/.config/wallpaper.png fill";
          max_render_time = "7";
        };
      };
    };

    wrapperFeatures = {gtk = true;};
  };
}
