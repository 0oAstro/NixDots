inputs: let
  inherit (inputs) self;
  inherit (self.lib) mkHome extraSpecialArgs;

  sharedModules = [
    ../.
    ../files
    ../shell
    ../games.nix
    ../media.nix
    ../editors
    
    inputs.hyprland.homeManagerModules.default
  ];

  homeImports = {
    "astro@nu" = sharedModules ++ [../wms ./astro-nu];
  };
in {
  inherit homeImports extraSpecialArgs;

  homeConfigurations = {
    "astro@nu" = mkHome {
      username = "astro";
      extraModules = homeImports."astro@nu";
    };
  };
}
