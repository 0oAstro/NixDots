{ config, ... }:

{
	services.sxhkd = {
		enable = true;
		keybindings = {
            # Focus next/prev window
			"super + {_, shift + } f" = "bspc node -f {next,prev}.local.!hidden.window";
			# Fullscreen with gaps
            "alt + f" = "sh $HOME/.local/bin/tglbar";
			# Move window
            "super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
			# Terminal
            "super + {_, shift +} Return" = "{alacritty, kitty}";
			# Kill current window
            "super + {_,shift + }q" = "bspc node -{c,k}";
            # Move workspaces
	        "super + {_,shift + }{1-8}" = "bspc {desktop -f,node -d} '^{1-8}'";
            # Resize
            "super + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
            "super + alt + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
            # Set state
            "super + {alt + t,shift + t,space,alt + f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
            # Set window orientation
            "super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
            # Cancel window orientation
            "super + ctrl + space" = "bspc node -p cancel";
            # Lock Screen
            "super + l" = "sh $HOME/.local/bin/lck";
            # Browser
            "super + {_, shift +, alt +} b" = "firefox, vivaldi, qutebrowser ";
            # Menu
            "super + a" = "sh $HOME/.local/bin/appmnu";
            "Menu" = "sh $HOME/.local/bin/appmnu";
            # Dashboard
            "super + d" = "sh $HOME/.local/bin/dshbrd";
            # Power Menu
            "super + p" = "sh $HOME/.local/bin/powermenu";
            # Network Menu
            "super + n" = "sh $HOME/.local/bin/powermenu";
            # Screenshot
            "{_, shift, alt} + Print" = "flameshot {full -p,gui -p,full -d 5000 -p} /home/naruto/pics/ss";
            # Media Keys
            "XF86Audio{Raise,Lower}Volume" = "amixer -q set Master 5%{+,-}";
            "XF86AudioMute" = "amixer set Master toggle";
            "XF86Search" = "qutebrowser"; # Quick Searching
        };
	};
}
