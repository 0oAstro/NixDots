inputs: let
  inherit (inputs) self;

  sharedModules = [
    {_module.args = {inherit inputs;};}
    ../modules/minimal.nix
    ../modules/security.nix
    inputs.hm.nixosModule
    {
      home-manager = {
        inherit (inputs.self.lib) extraSpecialArgs;
        useGlobalPkgs = true;
      };
    }
  ];

  desktopModules = [
    inputs.nix-gaming.nixosModules.default
    inputs.hyprland.nixosModules.default
  ];
  inherit (self.lib) nixosSystem makeOverridable;
  inherit (import "${self}/home/profiles" inputs) homeImports;
in {
  nu = nixosSystem {
    modules =
      [
        ./nu
        ../modules/desktop.nix
        ../modules/gamemode.nix
        ../modules/greetd.nix
        {home-manager.users.astro = inputs.self.lib.mkMerge [inputs.nix-doom-emacs.hmModule {imports = homeImports."astro@nu";}];}
      ]
      ++ sharedModules
      ++ desktopModules;

    system = "x86_64-linux";
  };
}
