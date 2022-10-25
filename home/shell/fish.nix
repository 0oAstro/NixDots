{
  pkgs,
  config,
  inputs,
  colors,
  ...
}: let
  inherit (colors) xcolors;
in {
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "exa -laHG --icons --git";
      rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixpkgs";
      top = "btop";
      tmp = "cd (mktemp -d)";
      ".." = "cd ..";
      bat = "bat";
    };

    shellAbbrs = {
      e = "$EDITOR";
      ga = "git add";
      gb = "git branch";
      gc = "git commit";
      gca = "git commit --amend";
      gcm = "git commit -m";
      gco = "git checkout";
      gd = "git diff";
      gds = "git diff --staged";
      gp = "git push";
      gpl = "git pull";
      gl = "git log";
      gr = "git rebase";
      gs = "git status --short";
      gss = "git status";

      us = "systemctl --user";

      grep = "grep --color";
      ip = "ip --color";
      md = "mkdir -p";
      rm = "rip"; # I am used to rm but rip is :noice:
    };
    plugins = [
      {
        name = "autopair";
        src = inputs.fish-autopair;
      }
      #       {
      # name = "tide";
      # src = inputs.fish-tide;
      #       }
      # {
      #  name = "pure";
      #  src = inputs.fish-pure;
      # }
      # {
      #  name = "async";
      #  src = inputs.fish-async;
      # }
    ];
    interactiveShellInit = ''
      # colorscript
      function fish_greeting
        $HOME/.local/bin/pokemon-colorscripts.py -r
      end

      # ssh agent
      eval (ssh-agent -c) >/dev/null
      ssh-add -q ~/.ssh/id_github

      # GPG TTY
      export GPG_TTY=(tty)
      
        set fish_color_normal '${xcolors.base05}'
        set fish_color_command '${xcolors.base0D}' --bold
        set fish_color_quote '${xcolors.base0B}'
        set fish_color_redirection '${xcolors.base0D}'
        set fish_color_end '${xcolors.base05}'
        set fish_color_error '${xcolors.base08}'
        set fish_color_param '${xcolors.base0A}'
        set fish_color_comment '${xcolors.base03}'
        set fish_color_match '${xcolors.base05}'
        set fish_color_selection '${xcolors.base03}'
        set fish_color_search_match '${xcolors.base0A}' --bold
        set fish_color_operator '${xcolors.base0B}'
        set fish_color_escape '${xcolors.base0C}'
        set fish_color_cwd '${xcolors.base0D}' --bold
        set fish_color_autosuggestion '${xcolors.base03}'
        set fish_color_user '${xcolors.base0E}'
        set fish_color_host '${xcolors.base0D}'
        set fish_color_host_remote '${xcolors.base0A}'
        set fish_color_cancel '${xcolors.base08}'
        
        # Pager colors
        set fish_pager_color_background '${xcolors.base01}'
        set fish_pager_color_prefix '${xcolors.base0C}'
        set fish_pager_color_completion '${xcolors.base0D}'
        set fish_pager_color_description '${xcolors.base0E}'
        set fish_pager_color_selected_completion '${xcolors.base0A}' --bold
        set fish_pager_color_selected_background '${xcolors.base0A}' --bold
        set fish_pager_color_selected_description '${xcolors.base0A}' --bold
        set fish_pager_color_selected_prefix '${xcolors.base0A}' --bold
        set fish_color_valid_path      '';
    functions = {
      lwhich = {
        description = "Show the full path of a command, resolving links along the way";
        body = "readlink -f (which $argv[1])";
      };

      mkcd = {
        description = "Make and enter a directory";
        body = ''
          if test (count $argv) -ne 1
              echo "mkcd: Expected exactly one argument."
              return 127
          else
              mkdir $argv[1] && cd $argv[1]
          end
        '';
      };
    };
  };
}
