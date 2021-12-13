{ config, pkgs, hostName, lib, ...}:
{
  imports = [   ./bspwm/options.nix
                ./user/home/environment.nix
            ];
}
