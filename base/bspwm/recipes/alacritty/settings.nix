let
  clr = import /home/naruto/.config/nixpkgs/themes/rose-pine/rose-pine.nix;
in
  {
    env = {
     "TERM" = "xterm-256color";
	};

  background_opacity = 0.8;

#### PADDING

  window = {
    padding.x = 24;
    padding.y = 24;
    decorations = "Full";
  };

#### FONTS ----------------

  font = {
    size = 13;
    use_thin_strokes = true;

    normal = {
      family = "Iosevka Nerd Font";
      style = "Regular";
    };

    bold = {
      family = "Iosevka Nerd Font";
      style = "Bold";
    };

    italic = {
      family = "Iosevka Nerd Font";
      style = "Italic";
    };
    offset.y = -1;
    glyph_offset.y = -1;
  };

#### STYLING --------------

  cursor.style = "Beam";

  shell = {
    program = "zsh";
  };

#### COLOR SCHEME --------------
colors = {
  # Default colors
  primary = {
    background =  "#101415";
    foreground =  "#c5c8c9";
};
  # Normal colors
  normal = {
    black =    "#101415";
    red =      "#c26f6f";
    green =    "#6bb05d";
    yellow =   "#e59e67";
    blue =     "#667b99";
    magenta =  "#b185db";
    cyan =     "#779fa8";
    white =    "#c4c4c4";
  };                      
  # Bright colors       
  bright = {            
    black =    "#131718";
    red =      "#f65b5b";
    green =    "#8dc776";
    yellow =   "#e7ac7e";
    blue =     "#84a0c6";
    magenta =  "#bb8fe5";
    cyan =     "#89b8c2";
    white =    "#cccccc";
    };
};
}
