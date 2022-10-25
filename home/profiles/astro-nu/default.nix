{lib, ...}: {
  home.keyboard = lib.mkForce null;

  services = let
    inherit (lib) mkForce;
  in {
    dunst.enable = mkForce false;
    flameshot.enable = mkForce false;
    picom.enable = mkForce false;
    polybar.enable = mkForce false;
    random-background.enable = mkForce false;
    redshift.enable = mkForce false;
  };
}
