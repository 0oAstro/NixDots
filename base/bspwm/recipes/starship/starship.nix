{ config, pkgs, ... }:
{
programs.starship = {
  enable = true;
  enableZshIntegration = true;
    settings = {
     add_newline = false; # Disable the vertical gap
     format = [
     "$directory" 
     "$git_branch" 
     "$node" 
     "$rust" 
     "$character"
     "[](bold green)"
     ];
     scan_timeout = 10;
     cmd_duration.disabled = true;
     directory.format = ["[$path]" "($style)"];
     time.disabled = true;
     character.symbol = "";
    };
  };
}
