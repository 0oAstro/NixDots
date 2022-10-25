{
  colors,
  pkgs,
  config,
  ...
}:
# terminals
let
  inherit (colors) xcolors x0Colors baseColors;
  font = "JetBrainsMono Nerd Font";
in {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "none";
        dynamic_padding = true;
        padding = {
          x = 15;
          y = 15;
        };
        startup_mode = "Maximized";
      };

      scrolling.history = 1000;

      font = {
        normal.family = font;
        bold.family = font;
        italic.family = font;
        size = 12;
      };

      cursor = {
        style = {
          shape = "Beam";
          blinking = "on";
        };
      };

      window = {opacity = 1.0;};

      draw_bold_text_with_bright_colors = true;
      colors = rec {
        primary = {
          background = x0Colors.base00;
          foreground = x0Colors.base05;
        };
        normal = {
          black = x0Colors.base02;
          red = x0Colors.base08;
          green = x0Colors.base0B;
          yellow = x0Colors.base0A;
          blue = x0Colors.base0D;
          magenta = x0Colors.base0E;
          cyan = x0Colors.base0C;
          white = x0Colors.base05;
        };
        bright =
          normal
          // {
            black = x0Colors.base03;
            white = x0Colors.base06;
          };
      };
    };
  };

  programs.kitty = {
    enable = true;
    font.name = font;
    font.size = 12;
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      visual_bell_duration = "0.1";
      visual_bell_color = xcolors.base05;

      copy_on_select = "clipboard";      
      placement_strategy = "center";
      
      scrollback_lines = 10000;
      window_padding_width = 5;
      # tab bar
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{sup.index} {title}";

      # tab colors
      active_tab_foreground = xcolors.base08;
      active_tab_background = xcolors.base02;
      inactive_tab_background = xcolors.base00;
      inactive_tab_foreground = xcolors.base04;
      tab_bar_background = xcolors.base00;

      #url
      url_color = xcolors.base0D;

      # colors
      foreground = xcolors.base05;
      background = xcolors.base00;
      # black
      color0 = xcolors.base02;
      color8 = xcolors.base03;
      # red
      color1 = xcolors.base08;
      color9 = xcolors.base08;
      # green
      color2 = xcolors.base0B;
      color10 = xcolors.base0B;
      # yellow
      color3 = xcolors.base0A;
      color11 = xcolors.base0A;
      # blue
      color4 = xcolors.base0D;
      color12 = xcolors.base0D;
      # magenta
      color5 = xcolors.base0E;
      color13 = xcolors.base0E;
      # cyan
      color6 = xcolors.base0C;
      color14 = xcolors.base0C;
      # white
      color7 = xcolors.base05;
      color15 = xcolors.base06;
    };
  };

  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        term = "xterm-256color";
        pad = "15x15";
        font = "${font}:size=13";
        dpi-aware = "yes";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors = {
        scrollback-indicator = "${baseColors.base00} ${baseColors.base00}";
        background = baseColors.base00;
        foreground = baseColors.base05;
        regular0 = baseColors.base01;
        regular1 = baseColors.base08;
        regular2 = baseColors.base0B;
        regular3 = baseColors.base0A;
        regular4 = baseColors.base0D;
        regular5 = baseColors.base0E;
        regular6 = baseColors.base0C;
        regular7 = baseColors.base05;
        bright0 = baseColors.base03;
        bright1 = baseColors.base08;
        bright2 = baseColors.base0B;
        bright3 = baseColors.base0A;
        bright4 = baseColors.base0D;
        bright5 = baseColors.base0E;
        bright6 = baseColors.base0C;
        bright7 = baseColors.base06;
        alpha = 1.0;
      };
      cursor = {
        style = "beam";
      };
    };
  };
}
