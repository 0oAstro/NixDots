{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.neovim-nightly];
}
