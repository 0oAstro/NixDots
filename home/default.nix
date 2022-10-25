{
  pkgs,
  config,
  colors,
  inputs,
  ...
}:
# graphical session configuration
# includes programs and services that work on both Wayland and X
let
  inherit (colors) xcolors theme;
  nix-colors-lib = inputs.nix-colors.lib-contrib {inherit pkgs;};
  nur = import inputs.nur {
    inherit pkgs;
    nurpkgs = pkgs;
  };
in {
  imports = [
    ./cli.nix # base config
    ./terminals.nix
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    gtk.enable = true;
    name = "Bibata-Modern-Ice";
    size = 16;
    x11.enable = true;
  };

  home.activation."batCacheBuild" = {
    before = [];
    after = ["linkGeneration"];
    data = "${pkgs.bat}/bin/bat cache --build";
  };
  home.packages = with pkgs; let
    discord-chromium = makeDesktopItem {
      name = "discord-canary";
      desktopName = "Discord Canary";
      genericName = "Discord Canary";
      exec = "${config.programs.chromium.package}/bin/chromium --app=\"https://canary.discord.com/app\"";
      icon = "discord";
      categories = ["Network" "InstantMessaging"];
      mimeTypes = ["x-scheme-handler/discord"];
    };
    tg-chromium = makeDesktopItem {
      name = "telegram";
      desktopName = "Telegram";
      genericName = "Telegram";
      exec = "${config.programs.chromium.package}/bin/chromium --app=\"https://web.telegram.org\"";
      icon = "telegram";
      categories = ["Network" "InstantMessaging"];
      mimeTypes = ["x-scheme-handler/telegram"];
    };
    element-chromium = makeDesktopItem {
      name = "element";
      desktopName = "Element";
      genericName = "Element";
      exec = "${config.programs.chromium.package}/bin/chromium --app=\"https://app.element.io\"";
      icon = "element";
      categories = ["Network" "InstantMessaging"];
      mimeTypes = [ "x-scheme-handler/element" ];
    };
    spotify-chromium = makeDesktopItem {
      name = "spotify";
      desktopName = "Spotify";
      genericName = "Spotify";
      exec = "${config.programs.chromium.package}/bin/chromium --app=\"https://open.spotify.com\"";
      icon = "spotify";
      categories = ["Network" "Audio"];
      mimeTypes = ["x-scheme-handler/spotify"];
    };
  in [
    # archives
    p7zip
    unrar
    # file downloaders
    yt-dlp
    # file managers
    cinnamon.nemo
    # misc
    libnotify
    libsForQt5.qtstyleplugins
    
    manix
    
    # im
    discord-chromium
    tg-chromium
    element-chromium
    
    # music
    spotify-chromium
  ];

  gtk = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override { color = "grey"; };
    };

    theme = {
      name = "${theme.slug}";
      package = nix-colors-lib.gtkThemeFromScheme {scheme = theme;};
      # name = "Catppuccin-Mocha-Lavender";
      # package = pkgs.catppuccin-gtk;
    };
  };

  programs = {
    chromium = {
      enable = true;
      commandLineArgs = ["--ozone-platform-hint=auto"];
      extensions = [{id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";}];
    };
    firefox = {
      enable = true;
      package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin;
      profiles.astro = {
        name = "astro";
        id = 0;
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "checkDefaultBrowser" = false;
          "browser.startup.page" = 3;
          "browser.newtabpage.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" =
            false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" =
            false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.default.sites" = "";
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.discovery.enabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false; # see [NOTE]
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false; # [FF55+]
          "toolkit.telemetry.shutdownPingSender.enabled" = false; # [FF55+]
          "toolkit.telemetry.updatePing.enabled" = false; # [FF56+]
          "toolkit.telemetry.bhrPing.enabled" =
            false; # [FF57+] Background Hang Reporter
          "toolkit.telemetry.firstShutdownPing.enabled" = false; # [FF57+]
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "browser.ping-centre.telemetry" = false;
          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
            
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        isDefault = true;
      };
      extensions = with nur.repos.bandithedoge.firefoxAddons; [
        ublock-origin
        auto-tab-discard
        dont-fuck-with-paste
        gitako
        github-repo-size
        github-code-folding
        github-isometric-contributions
        imagus
        material-icons-for-github
        sidebery
        reddit-enhancement-suite
        sourcegraph
      ] ++ [ nur.repos.rycee.firefox-addons.bitwarden ];    
    };
    qutebrowser = {
      enable = true;
      aliases = {
        "wq" = "quit --save";
        "w" = "session-save";
        "q" = "quit";
        "tc" = "tab-close";
      };
      settings = {
        colors = {
          # SOURCE: https://github.com/theova/base16-qutebrowser/
          completion.fg = "${xcolors.base05}";
          completion.odd.bg = "${xcolors.base01}";
          completion.even.bg = "${xcolors.base00}";
          completion.category.fg = "${xcolors.base0A}";
          completion.category.bg = "${xcolors.base00}";
          completion.category.border.top = "${xcolors.base00}";
          completion.category.border.bottom = "${xcolors.base00}";
          completion.item.selected.fg = "${xcolors.base05}";
          completion.item.selected.bg = "${xcolors.base02}";
          completion.item.selected.border.top = "${xcolors.base02}";
          completion.item.selected.border.bottom = "${xcolors.base02}";
          completion.item.selected.match.fg = "${xcolors.base0B}";
          completion.match.fg = "${xcolors.base0B}";
          completion.scrollbar.fg = "${xcolors.base05}";
          completion.scrollbar.bg = "${xcolors.base00}";
          contextmenu.disabled.bg = "${xcolors.base01}";
          contextmenu.disabled.fg = "${xcolors.base04}";
          contextmenu.menu.bg = "${xcolors.base00}";
          contextmenu.menu.fg = "${xcolors.base05}";
          contextmenu.selected.bg = "${xcolors.base02}";
          contextmenu.selected.fg = "${xcolors.base05}";
          downloads.bar.bg = "${xcolors.base00}";
          downloads.start.fg = "${xcolors.base00}";
          downloads.start.bg = "${xcolors.base0D}";
          downloads.stop.fg = "${xcolors.base00}";
          downloads.stop.bg = "${xcolors.base0C}";
          downloads.error.fg = "${xcolors.base08}";
          hints.fg = "${xcolors.base00}";
          hints.bg = "${xcolors.base0A}";
          hints.match.fg = "${xcolors.base05}";
          keyhint.fg = "${xcolors.base05}";
          keyhint.suffix.fg = "${xcolors.base05}";
          keyhint.bg = "${xcolors.base00}";
          messages.error.fg = "${xcolors.base00}";
          messages.error.bg = "${xcolors.base08}";
          messages.error.border = "${xcolors.base08}";
          messages.warning.fg = "${xcolors.base00}";
          messages.warning.bg = "${xcolors.base0E}";
          messages.warning.border = "${xcolors.base0E}";
          messages.info.fg = "${xcolors.base05}";
          messages.info.bg = "${xcolors.base00}";
          messages.info.border = "${xcolors.base00}";
          prompts.fg = "${xcolors.base05}";
          prompts.border = "${xcolors.base00}";
          prompts.bg = "${xcolors.base00}";
          prompts.selected.bg = "${xcolors.base02}";
          prompts.selected.fg = "${xcolors.base05}";
          statusbar.normal.fg = "${xcolors.base05}";
          statusbar.normal.bg = "${xcolors.base00}";
          statusbar.insert.bg = "${xcolors.base00}";
          statusbar.insert.fg = "${xcolors.base0D}";
          statusbar.passthrough.bg = "${xcolors.base00}";
          statusbar.passthrough.fg = "${xcolors.base0C}";
          statusbar.private.fg = "${xcolors.base00}";
          statusbar.private.bg = "${xcolors.base01}";
          statusbar.command.fg = "${xcolors.base05}";
          statusbar.command.bg = "${xcolors.base00}";
          statusbar.command.private.fg = "${xcolors.base05}";
          statusbar.command.private.bg = "${xcolors.base00}";
          statusbar.caret.fg = "${xcolors.base00}";
          statusbar.caret.bg = "${xcolors.base0E}";
          statusbar.caret.selection.fg = "${xcolors.base00}";
          statusbar.caret.selection.bg = "${xcolors.base0D}";
          statusbar.progress.bg = "${xcolors.base0D}";
          statusbar.url.fg = "${xcolors.base05}";
          statusbar.url.error.fg = "${xcolors.base08}";
          statusbar.url.hover.fg = "${xcolors.base05}";
          statusbar.url.success.http.fg = "${xcolors.base0C}";
          statusbar.url.success.https.fg = "${xcolors.base0B}";
          statusbar.url.warn.fg = "${xcolors.base0E}";
          tabs.bar.bg = "${xcolors.base00}";
          tabs.indicator.start = "${xcolors.base0D}";
          tabs.indicator.stop = "${xcolors.base0C}";
          tabs.indicator.error = "${xcolors.base08}";
          tabs.odd.fg = "${xcolors.base05}";
          tabs.odd.bg = "${xcolors.base01}";
          tabs.even.fg = "${xcolors.base05}";
          tabs.even.bg = "${xcolors.base00}";
          tabs.pinned.even.bg = "${xcolors.base0C}";
          tabs.pinned.even.fg = "${xcolors.base07}";
          tabs.pinned.odd.bg = "${xcolors.base0B}";
          tabs.pinned.odd.fg = "${xcolors.base07}";
          tabs.pinned.selected.even.bg = "${xcolors.base02}";
          tabs.pinned.selected.even.fg = "${xcolors.base05}";
          tabs.pinned.selected.odd.bg = "${xcolors.base02}";
          tabs.pinned.selected.odd.fg = "${xcolors.base05}";
          tabs.selected.odd.fg = "${xcolors.base05}";
          tabs.selected.odd.bg = "${xcolors.base02}";
          tabs.selected.even.fg = "${xcolors.base05}";
          tabs.selected.even.bg = "${xcolors.base02}";
        };
        fonts = {
          default_family = "JetBrainsMono Nerd Font";
          default_size = "14px";
          web.family.fantasy = "JetBrainsMono Nerd Font";
        };
        tabs.background = true;
        content.blocking.adblock.lists = [
          "https://easylist.to/easylist/easylist.txt"
          "https://easylist.to/easylist/easyprivacy.txt"
          "https://easylist-downloads.adblockplus.org/easylistdutch.txt"
          "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt"
          "https://www.i-dont-care-about-cookies.eu/abp/"
          "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt"
        ];

        scrolling.smooth = true;

        # DARK MODE
        # colors.webpage.preferred_color_schemes = "dark";

        # CHROMIUM FLAGS
        content.canvas_reading = false;
        content.prefers_reduced_motion = true;
        qt.args = [
          # "enable-gpu-rasterization"
          # "ignore-gpu-blocklist"
          "enable-accelerated-video-decode"
        ];
      };
      keyMappings = {
        "<Shift-Left>" = "back";
        "<Shift-Down>" = "tab-next";
        "<Shift-Up>" = "tab-prev";
        "<Shift-Right>" = "forward";
        "M" = "hint links spawn mpv {hint-url}";
        "Z" = "hint links spawn st -e youtube-dl {hint-url}";
        "xb" = "config-cycle statusbar.show always never";
        "xt" = "config-cycle tabs.show always never";
        "xx" =
          "config-cycle statusbar.show always never;; config-cycle tabs.show always never";
        "<Alt-C>" = "tab-close";
        "t" = "set-cmd-text -s :open -t";
        ";" = "set-cmd-text -s :";
      };
    };  };

  programs = {
    git = {
      enable = true;
      delta.enable = true;
      ignores = ["*~" "*.swp" "*result*" ".direnv" "node_modules"];
      signing = {
        key = "842F9AAB3C7B99DF";
        signByDefault = true;
      };
      userEmail = "github@sandy007.anonaddy.com";
      userName = "Astro";
    };

    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };

    zathura = {
      enable = true;
      options = {
        recolor = true;
        recolor-darkcolor = "#${xcolors.base00}";
        recolor-lightcolor = "rgba(0,0,0,0)";
        default-bg = "rgba(0,0,0,0.7)";
        default-fg = "#${xcolors.base05}";
      };
    };
      
    nix-index = { enable = true; };
  };

  services.gpg-agent = {
    enable = true;
    extraConfig = ''
      pinentry-program ${pkgs.pinentry}/bin/pinentry
    '';
  };

  xdg.configFile = let
    gtkconf = ''
      decoration, decoration:backdrop, window {
        box-shadow: none;
        border: none;
        margin: 0;
      }
    '';
  in {
    "gtk-3.0/gtk.css".text = gtkconf;
    "gtk-4.0/gtk.css".text = gtkconf;
  }; 
}
