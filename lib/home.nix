inputs: let
  inherit (inputs) self;
  inherit (inputs.hm.lib) homeManagerConfiguration;
  
  theme_name = "catppuccin";

  colors = with self.lib; let
    theme = inputs.nix-colors.colorSchemes.${theme_name};
    baseColors = theme.colors;
  in {
    inherit theme baseColors;
    xcolors = mapAttrs (n: x) baseColors;
    # rgba hex values
    xrgbaColors = mapAttrs (n: xrgba) baseColors;
    # argb hex values
    xargbColors = mapAttrs (n: xargb) baseColors;
    # 0xABCDEF colors (alacritty)
    x0Colors = mapAttrs (n: x0) baseColors;
    # rgba(,,,) colors (css)
    rgbaColors = mapAttrs (n: rgba) baseColors;
  };

  extraSpecialArgs = {inherit colors inputs;};

  defArgs = {
    configuration = {};
    system = "x86_64-linux";
    inherit extraSpecialArgs;
  };

  mkHome = args:
    homeManagerConfiguration (defArgs
      // args
      // {
        homeDirectory = "/home/${args.username}";
        pkgs = inputs.self.pkgs.${args.system or defArgs.system};
      });
in {inherit mkHome extraSpecialArgs;}
