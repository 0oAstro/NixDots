{ config, pkgs, hostName, lib, ...}:

{
imports = [
  ./base
  ];

  programs.home-manager.enable = true;
  programs.home-manager.path = "$HOME/.config/nixpkgs/home-manager";
}

