{
  description = "Astro Dots";

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    lib = import ./lib inputs;
    inherit (lib) genSystems;

    overlays.default = import ./pkgs inputs;

    pkgs = genSystems (system:
      import nixpkgs {
        inherit system;
        overlays = [
          inputs.devshell.overlay
          inputs.emacs-overlay.overlay
          overlays.default
          inputs.neovim-nightly-overlay.overlay
        ];
        config.allowUnfree = true;
      });
  in {
    inherit lib overlays pkgs;

    # standalone home-manager config
    inherit (import ./home/profiles inputs) homeConfigurations;

    # nixos-configs with home-manager
    nixosConfigurations = import ./hosts inputs;

    devShells = genSystems (system: {
      default = pkgs.${system}.devshell.mkShell {
        packages = with pkgs.${system}; [
          alejandra
          nixfmt
          git
          rnix-lsp
          nix-output-monitor
          repl
        ];
        name = "dots";
      };
    });
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    # flakes
    devshell.url = "github:numtide/devshell";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    fu.url = "github:numtide/flake-utils";

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming/testing";

    nix-colors.url = "github:misterio77/nix-colors";

    # powercord = {
    #   url = "github:LavaDesu/powercord-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # discord-tweaks = {
    #   url = "github:NurMarvin/discord-tweaks";
    #   flake = false;
    # };

    # powercord-image-tools = {
    #   url = "github:powerfart-plugins/image-tools";
    #   flake = false;
    # };
  
    # Hypr
    hyprland = {
      url = "github:Hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpicker = {
      url = "github:Hyprwm/Hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    

    fish-autopair = {
      flake = false;
      url = "github:jorgebucaran/autopair.fish";
    };

    fish-async = {
      flake = false;
      url = "github:acomagu/fish-async-prompt";
    };
    fish-pure = {
      flake = false;
      url = "github:pure-fish/pure";
    };
    
    firefox = {
      flake = true;
      url = "github:colemickens/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    wall = {
      flake = false;
      # url = "https://i.imgur.com/vU1M7C1.jpeg"; # rose pine
      # url = "https://9to5mac.com/wp-content/uploads/sites/6/2014/08/yosemite-4.jpg?quality100&strip=all"; # orange mountains
      url = "https://unsplash.com/photos/FaFZCtl1yug/download?force=true"; # candy mountains
    };
  };
}
