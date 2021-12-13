{ config, pkgs, lib, ... }:

{

  programs.zoxide = { 
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = { 
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    enableCompletion = true;
    shellAliases = import ./alias.nix;
    autocd = true;
	history = {
	  ignoreSpace = true;
	  expireDuplicatesFirst = true;
	  share = true;
	  ignoreDups = true;
	};
	# initExtraBeforeCompInit = ''
# source ~/.zinit/bin/zinit.zsh
# 
# zinit for \
#     light-mode	zsh-users/zsh-autosuggestions \
#     light-mode	zdharma/history-search-multi-word \
# 
# zinit for \
#     light-mode	zdharma/fast-syntax-highlighting	\
#     light-mode	zsh-users/zsh-completions
# 	'';
    dotDir = ".config/zsh";
  };
}
