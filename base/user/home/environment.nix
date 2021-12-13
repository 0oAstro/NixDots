{ pkgs, lib, config, ... }:

{
    nixpkgs.config = { 
      allowUnfree = true; 
    };

    home.sessionVariables = {
		EDITOR = "nvim";
    	VISUAL = "nvim";
    	TERMINAL = "alacritty";
    	SHELL = "zsh";
    	XDG_DESKTOP_DIR="$HOME/.desktop";
    	XDG_DOWNLOAD_DIR="$HOME/downloads";
    	XDG_TEMPLATES_DIR="$HOME/templates";
    	XDG_PUBLICSHARE_DIR="$HOME/projects";
    	XDG_DOCUMENTS_DIR="$HOME/documents";
    	XDG_MUSIC_DIR="$HOME/music";
    	XDG_PICTURES_DIR="$HOME/pics";
    	XDG_VIDEOS_DIR="$HOME/vids";
    	XDG_USB_DIR="$HOME/usb";
    };

}
