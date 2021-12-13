{ pkgs, config, lib, ...}:
let
  clr = import ../../../../themes/rose-pine/rose-pine.nix;
in
{
  programs.kitty = { 
    enable = true;
    font = { 
    	name = "Fira Code";
    	size = 13;
    };
   
    settings = {
		bold_font = "FiraCode Nerd Font";
		italic_font = "DankMono Nerd Font";
		bold_italic_font = "DankMono Nerd Font";
		font_size = 13;
        shell = "zsh";
        foreground = clr.foreground;
        background = clr.background;
        selection_foreground = clr.base00;
        selection_background = clr.base04;
        url_color = clr.blue-br;
        background_opacity = "0.7";
        cursor = clr.white;
        window_padding_width = "8";
        enable_audio_bell = "no";
		update_check_interval = 0;
        
		color0 = clr.black;  # black
        color1 = clr.red;  # red
        color2 = clr.green;  # green
        color3 = clr.yellow;  # yellow
        color4 = clr.blue;  # blue
        color5 = clr.magenta;  # magenta
        color6 = clr.cyan;  # cyan
        color7 = clr.white;  # white
        
        color8 = clr.black-br;   # bright black
        color9 = clr.red-br;   # bright red
        color10 = clr.green-br;   # bright green
        color11 = clr.yellow-br;   # bright yellow
        color12 = clr.blue-br;   # bright blue
        color13 = clr.magenta-br;   # bright magenta
        color14 = clr.cyan-br;   # bright cyan
        color15 = clr.white-br;   # bright white
    };
  };
} 
