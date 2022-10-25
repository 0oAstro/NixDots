{
  pkgs,
  inputs,
  ...
}: let
  wall = inputs.wall;
  theme = "catppuccin";
  colors = inputs.nix-colors.colorschemes.${theme}.colors;
in {
  environment.systemPackages = with pkgs; [
    greetd.gtkgreet
  ];
    
  services.xserver.displayManager.startx.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = let
        gtkgreetStyle = pkgs.writeText "greetd-gtkgreet.css" ''
          window {
            background-image: url("${wall}");
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            background-color: black;
          }
          box#body {
            background-color: #${colors.base00};
            border-radius: 10px;
            padding: 50px;
            border-style: solid;
            border-color: #${colors.base08};
            border-width: 3px;
          }
          * { color: #${colors.base05}; border-style: none; font-family: "JetBrainsMono Nerd Font"; }
          #clock { color: #${colors.base00}; }
          entry { background: #${colors.base00}; border-style: none; }
          entry:hover, entry:focus { background: #${colors.base00}; box-shadow: none; }
          button { background: #${colors.base00}; border-style: none; }
          button:hover { background: #${colors.base08}; }
          button * { color: #${colors.base08}; }
          button:hover * { color: #${colors.base00}; }
          menu { background: #${colors.base01}; border-radius: 0px; }
          menu *:hover { background: #${colors.base02}; }
          button { box-shadow: none; text-shadow: none; }
          button.combo:hover { border-bottom-left-radius: 5px; border-top-left-radius: 5px; }
        ''; in 
        "${pkgs.cage}/bin/cage -s  -- ${pkgs.greetd.gtkgreet}/bin/gtkgreet -l -s ${gtkgreetStyle}";
        initial_session = {
          command = "Hyprland >/dev/null";
          user = "astro";
        };
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland >/dev/null
    sway >/dev/null
    river >/dev/null
    wayfire >/dev/null
    fish
  '';
}
