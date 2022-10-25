{
  config,
  pkgs,
  ...
}: let
in {
  imports = [
    # ./emacs
    ./kakoune
    ./neovim
    ./helix
  ];
}
