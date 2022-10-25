{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.pure-prompt];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    autocd = true;
    dotDir = ".config/zsh";
    history = {
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh_history";
    };
    initExtra = ''
      # autoloads
      autoload -U history-search-end

      # search history based on what's typed in the prompt

      # group functions
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end

      # bind functions to up and down arrow keys
      bindkey "^[OA" history-beginning-search-backward-end
      bindkey "^[OB" history-beginning-search-forward-end

      # case insensitive tab completion
      zstyle ':completion:*' completer _complete _ignored _approximate
      zstyle ':completion:*' list-colors '\'
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion:*' verbose true
      _comp_options+=(globdots)

      # pure prompt
      autoload -U promptinit; promptinit

      zstyle :prompt:pure:git:stash show yes

      prompt pure

      gnupg_path=$(ls /run/user/1000/gnupg)
      export SSH_AUTH_SOCK="/run/user/1000/gnupg/$gnupg_path/S.gpg-agent.ssh"

      ${builtins.readFile ./nix-completions.sh}
    '';
    shellAliases = {
      grep = "grep --color";
      ip = "ip --color";
      l = "exa -l";
      la = "exa -la";
      md = "mkdir -p";

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
      rs = "sudo systemctl";
    };
    shellGlobalAliases = {exa = "exa --icons --git";};
  };
}
