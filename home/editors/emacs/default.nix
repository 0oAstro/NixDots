{pkgs, ...}: {
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d; # TODO: Make my own config.el and package.el
  };
}
