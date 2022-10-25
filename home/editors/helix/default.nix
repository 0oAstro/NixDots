{
  inputs,
  lib,
  pkgs,
  ...
}: {
  programs.helix = {
    enable = true;

    languages = import ./languages.nix pkgs;

    settings = {
      theme = "catppuccin_mocha";
      editor = {
        true-color = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
      keys.normal.space.u = {
        f = ":format"; # format using LSP formatter
        a = ["select_all" ":pipe alejandra"]; # format Nix with Alejandra
      };
    };
  };
}
