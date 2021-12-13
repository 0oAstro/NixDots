{ config, pkgs, lib, ... }:
{
	xsession = {
		enable = true;
		scriptPath = ".local/share/xorg-scripts/.xsession";
		profilePath = ".local/share/xorg-scripts/.xprofile";
		windowManager.bspwm = {
			enable = true;
			startupPrograms = [ "pgrep -x sxhkd >/dev/null || sxhkd" "~/.fehbg" "xsetroot -cursor_name left_ptr""dunst --config $HOME/.config/dunst/dunstrc" "$HOME/.local/bin/eww daemon" "picom --config $HOME/.config/picom/picom.conf" "sh $HOME/.config/polybar/launch.sh" "xset mouse 2.5 0" ]; # Do not kill me please for these many startup Programs :pleading_face:
			monitors = {
			"VGA1" = [ "1" "2" "3" "4" "5" ];
			};
			settings = {
				border_width = 2;
				window_gap = 12;
				split_ratio = 0.52;
			};
			extraConfig = ''
# Credits to 6gk/polka
rule() { bspc rule -a "$@" & }
config() { bspc config "$@" & }

rule Vivaldi-stable                 desktop=^2
rule firefox                        desktop=^2
rule discord                        desktop=^3
rule Code                           desktop=^4
rule Viewnior                       state=floating

config pointer_modifier             Mod4

config border_width                 20
config window_gap                   25

config top_padding                  35
config bottom_padding               0

config split_ratio                  0.62
config borderless_monocle           true
config gapless_monocle              true

# Yes, this is stolen from gk.
outer='0x101415'   # outer
inner1='0x151a1c'  # focused
inner2='0x131718'  # normal

targets() {
 	case $1 in
		focused) bspc query -N -n .local.focused.\!fullscreen;;
		normal)  bspc query -N -n .local.\!focused.\!fullscreen
	esac | grep -iv "$v"
}

draw() { chwb2 -I "$inner" -O "$outer" -i "4" -o "9" $* |:; }

initial draw, and then subscribe to events
{ echo; bspc subscribe node_geometry node_focus; } |
 	while read -r _; do
		[ "$v" ] || v='abcdefg'
		inner=$inner1 draw "$(targets focused)"
		inner=$inner2 draw "$(targets normal)"
    done
			'';
		};
	};
}
