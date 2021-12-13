{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "NarutoXY";
    userEmail = "79555780+NarutoXY@users.noreply.github.com";
    aliases = {
      co = "checkout";
      ci = "commit";
      s = "status";
      st = "status";
      cl = "clone";
    };
    extraConfig = {
      core.editor = "nvim";
      protocol.keybase.allow = "always";
     # credential.helper = "store --file ~/.config/git/git-credentials";
      pull.rebase = "false";
    };
  };
}
