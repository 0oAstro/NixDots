{ pkgs, config, lib, ... }:
let
 gnu = import ./variables.nix;
 nixpkgs_config = import ./nixpkgs_config.nix;  
in
{
imports = [
		gnu.alacritty
		gnu.kitty
		gnu.xres
		gnu.nushell
		gnu.starship
		gnu.qutebrowser
		gnu.core
		gnu.git
		gnu.zsh
        gnu.sxhkd
        gnu.bspwm
        nixpkgs_config
        gnu.gtk
    ];
}
