{pkgs, colors, ...}: let
# minimal config, suitable for servers
  inherit (colors) xcolors;
in {
  imports = [./shell/zsh.nix];

  home = {
    username = "astro";
    homeDirectory = "/home/astro";
    stateVersion = "21.11";
  };

  home.packages = with pkgs; [
    # modern coreutils
    bat
    bottom
    du-dust
    duf
    exa
    fd
    ripgrep
    tealdeer
    rm-improved
    btop

    glow

    tree

    joshuto
    ranger

    lazygit

    # fun
    pfetch
    cava

    # zips
    unzip
    
    python3
  ];
  home.extraOutputsToInstall = ["doc" "info" "devdoc"];

  programs.home-manager.enable = true;

  programs.zoxide.enable = true;

  programs.gh = {
    enable = true;
    settings = {git_protocol = "ssh";};
  };
  
  programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      defaultCommand =
        "${pkgs.fd}/bin/fd --hidden --type f --exclude '.git' --exclude '.pnpm-store' --exclude 'node_modules'";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
      defaultOptions = [
        "--prompt='~ '"
        "--layout=reverse"
        "--multi"
        "--sort"
        "--color=fg:-1,bg:-1,hl:${xcolors.base0D}"
        "--color=fg+:${xcolors.base06},bg+:${xcolors.base01},hl+:${xcolors.base0C}"
        "--color=info:${xcolors.base09},prompt:${xcolors.base08},pointer:${xcolors.base08}"
        "--color=marker:${xcolors.base0B},spinner:${xcolors.base0D},header:${xcolors.base0C}"
        "--bind '?:toggle-preview'"
        "--bind 'ctrl-a:select-all'"
        "--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'"
        "--height=80%"
        "--preview-window=:hidden"
        "--info=inline"
        "--preview 'bash -c \'([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200\''"
      ];
      changeDirWidgetCommand =
        "${pkgs.fd}/bin/fd --type d --hidden --exclude '.git' --exclude '.pnpm-store' --exclude 'node_modules'";
      historyWidgetOptions = [ "--sort" ];
    };

  programs.ssh.enable = true;
}
