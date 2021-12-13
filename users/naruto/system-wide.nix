{ pkgs, ... }:
{
  users.users.naruto = {
    isNormalUser= true;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
  };
}
