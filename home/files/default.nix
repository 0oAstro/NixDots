{
  colors,
  pkgs,
  inputs,
  ...
}:
# manage files in ~
{
  home.file = {
    ".config" = {
      source = ./config;
      recursive = true;
    };
    # ".face.icon".source = ../../assets/user_icon.png;
  };
  xdg.configFile = {
    "wayfire.ini".text = import ../wms/wayfire colors;
    "wallpaper.png".source = inputs.wall;
    "wofi/style.css".text = import ./wofi.nix colors;
  };
}
