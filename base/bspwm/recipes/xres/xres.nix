{ config, lib, pkgs, ... }: 
{
  xresources = {
	properties = {
	  "Xft.antialias" 	=   	"true";
	  "Xft.rgba" 		=       "rgb";
	  "Xft.hinting" 	=     	"true";
	  "Xft.hintstyle" 	=   	"hintfull";
	  "st.borderpx" 	=       "5";
	  "st.font" 		=  		"JetBrains Mono Nerd Font Mono:pixelsize=14";
	  "st.fontalt0" 	=  		"JetBrains Mono Nerd Font Mono:style=Regular:pixelsize=20";
	  "st.opacity" 		=  		"255"; 
	  "*.foreground" 	=   	"#c5c8c9";
	  "*.background" 	=   	"#101415";
	  "*.cursorColor" 	=  		"#c5c8c9";
	  "*fading" 		= 		"35";
	  "*fadeColor" 		= 		"#c5c8c9";
	  "*.color0" 		= 		"#101415";
	  "*.color8" 		= 		"#131718";
	  "*.color1" 		= 		"#c26f6f";
	  "*.color9" 		= 		"#f65b5b";
	  "*.color2" 		= 		"#6bb05d";
	  "*.color10" 		= 		"#8dc776";
	  "*.color3" 		= 		"#e59e67";
	  "*.color11" 		= 		"#e7ac7e";
	  "*.color4" 		= 		"#667b99";
	  "*.color12" 		= 		"#84a0c6";
	  "*.color5" 		= 		"#b185db";
	  "*.color13" 		= 		"#bb8fe5";
	  "*.color6" 		= 		"#779fa8";
	  "*.color14" 		= 		"#89b8c2";
	  "*.color7" 		= 		"#c4c4c4";
	  "*.color15" 		= 		"#cccccc";
        "Xcursor.theme" = "volantes_light_cursors";
        "Xcursor.size"  = 12;
    };
 };
}
