{ config, pkgs, ... }:
let	

	mozilla-overlays = import (builtins.fetchTarball {
		url = https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz;
	});
	  
	neovim-overlays = import (builtins.fetchTarball {
	  url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
	});
	  
in 

{
	nixpkgs = {
#		st.conf = builtins.readFile ./recipes/st/st-conf.h;
		overlays = [ mozilla-overlays neovim-overlays ];
	};
}
