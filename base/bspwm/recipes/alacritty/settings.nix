let
  clr = import /home/naruto/.config/nixpkgs/themes/rose-pine/rose-pine-moon.nix;
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
    size = 9;
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
      background = clr.background;
      foreground = clr.foreground;
    };

  normal = {
    black =   clr.black;
    red =     clr.red;
    green =   clr.green;
    yellow =  clr.yellow;
    blue =    clr.blue;
    magenta = clr.magenta;
    cyan =    clr.cyan;
    white =   clr.white;
};
  bright = {
    black =   clr.black-br;
    red =     clr.red-br;
    green =   clr.green-br;
    yellow =  clr.yellow-br;
    blue =    clr.blue-br;
    magenta = clr.magenta-br;
    cyan =    clr.cyan-br;
    white =   clr.white-br;
};
  };
}
