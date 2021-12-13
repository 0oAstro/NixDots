{
    kitty = import ./recipes/kitty/kitty.nix;
    xres = import ./recipes/xres/xres.nix;
    alacritty = import ./recipes/alacritty/alacritty.nix;
    compton = import ./recipes/compton/compton.nix;
    git = import ./recipes/git/git.nix;
    rofi = import ./recipes/rofi/rofi.nix;
    nur = import ./recipes/nur/nur-progs.nix;
    nushell = import ./recipes/nushell/nushell.nix;
    polybar = import ./recipes/polybar/polybar.nix;
    qutebrowser = import ./recipes/qutebrowser/qutebrowser.nix;
    starship = import ./recipes/starship/starship.nix;
    zsh = import ./recipes/zsh/zsh.nix;
  # xdg = import ./recipes/xdg/xdg.nix;
    gtk = import ./recipes/gtk/gtk.nix;
    core = import ./app.nix;
    sxhkd = import ./recipes/sxhkd/sxhkd.nix;
    bspwm = import ./bspwm.nix;
}
