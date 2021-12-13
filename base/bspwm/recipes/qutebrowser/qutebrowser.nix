{ pkgs, config, ... }:

let
	clr = import "/home/naruto/.config/nixpkgs/themes/rose-pine/rose-pine.nix";
in
{
programs.qutebrowser = {
      enable = true;
      extraConfig = ''
        c.statusbar.padding = {'top': 5, 'bottom': 5, 'left': 3, 'right': 3}
        c.tabs.padding = {'top': 8, 'bottom': 6, 'left': 3, 'right': 3}
      '';
      keyBindings = {
        normal = {
		"O"	=  "open -t";
		"c"	=  "tab-close";
        "N" =  "tab-next";
        "E" =  "tab-prev";
        "K" =  "search-prev";
        "l" =  "mode-enter insert";
        "n" =  "scroll down";
        "e" =  "scroll up";
        "i" =  "scroll right";
        "j" =  "search-next";
        "b" =  "set-cmd-text -s :tab-select ";
        "t" =  "set-cmd-text -s :open -t";
        "Y" =  "yank selection";
        "pO" =  "set-cmd-text :open {url:pretty}";
        "<Alt-Left>" =  "back";
        "<Alt-Right>" =  "forward";
        };
      };
      searchEngines = {
        "DEFAULT" =  "https://duckduckgo.com/?q={}";
        "w" =  "https://en.wikipedia.org/w/index.php?search={}";
        "gs" =  "https://scholar.google.com/scholar?q={}";
        "aw" =  "https://wiki.archlinux.org/?search={}";
        "o" =  "https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&query={}";
        "p" =  "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&query={}";
        "d" =  "https://en.wiktionary.org/wiki/{}";
        "s" =  "http://stackoverflow.com/search?q={}";
        "gh" =  "https://github.com/search?q={}&type=Repositories";
        "ia" =  "https://archive.org/details/texts?and%5B%5D={}&sin=";
        };
      settings = {
        colors = {
          tabs = {
            even.bg = clr.base01;
            odd.bg = clr.base01;
            selected.even.bg = clr.base02;
            selected.odd.bg = clr.base02;
          };
        };
        fonts = {
          completion.category = "12pt Iosevka";
          default_family = "Iosevka, Terminus, Monospace, monospace, Fixed";
          prompts = "12pt Iosevka";
        };
        hints.chars = "arstdhneio";
        # url.default_page = "${scripts}/homepage/homepage.html";
      };
    };
  }
