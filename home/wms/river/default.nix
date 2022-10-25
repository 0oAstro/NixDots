{
  pkgs,
  config,
  ...
} @ args: {
  xdg.configFile."river/init" = {
    text = import ./config.nix args;
    executable = true;
  };
  home.packages = with pkgs; [river];
}
