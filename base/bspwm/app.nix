
# ~/.config/nixpkgs/user/app.nix 
{ config, pkgs, lib, ... }:

{

home.packages = with pkgs; [
##### SYSTEM ADMIN TOOLS ##### -----
killall
coreutils
pinentry
htop
gnupg
xdg-user-dirs

##### NETWORK TOOLS ##### -----------
wget
curl
axel
qutebrowser
firefox-beta-bin
vivaldi
vivaldi-widevine
vivaldi-ffmpeg-codecs

##### PASSWORD MANAGERS ##### -------

##### FILE MANIPULATION TOOLS ##### -
trash-cli
xfceUnstable.thunar
unzip

##### SHELLS ##### ------------------
nushell
zsh
fish

##### SHELL ENHANCERS ##### ---------
starship
tmux

##### TERMINAL EMULATORS ##### ------
siduck76-st
contour
alacritty
kitty

##### THEME ##### -------------------
lxappearance
glib

##### BSPWM ##### --------------------
i3lock-color
bsp-layout
sxhkd
xclip
xorg.xbacklight

##### SCREEN CAPTURING ##### --------
flameshot

##### RICE ENHANCERS ##### ----------
polybar
rofi
eww
dunst

##### LOVELY DISCORD ##### ----------
discord

##### SYSTEM FETCH ##### ------------
onefetch # GIT FETCH UTILITY

##### MULTIMEDIA ##### --------------
pulsemixer
mpv
feh
viewnior

##### PRODUCTIVIIIITY ##### ---------


##### LIBS ##### --------------------
libnotify
libsForQt5.qtstyleplugins

##### CHEATSHEET ##### --------------
tealdeer

##### RUST UTILS ##### --------------
exa
broot
ripgrep
bat
hyperfine
dua
rm-improved

##### MISC UTILS ##### --------------
fzf
glow

##### DEVELOP ##### -----------------
# ANDROID
android-tools
# MAKE
gnumake
# VERSION CONTROL
git
github-cli
# THE ULTIMATE CODE EDITORS
neovim
vscode
# GO
go
# LUA
stylua
luajit
luarocks
luajitPackages.luacheck
sumneko-lua-language-server
# C
gcc
# RUST
cargo
# WEB DEV
nodejs
nodePackages.pnpm
deno
jq
# PYTHON
python3
python39Packages.pip
pipenv
# RUBY
ruby
gem
#JULIA
julia-stable-bin
#SHELL
shellcheck

##### FONTS ##### -------------------
cascadia-code
victor-mono
fira-code
(nerdfonts.override { fonts = [ "FiraCode" "Iosevka" "JetBrainsMono" "Inconsolata" ]; })
roboto
fira-code-symbols

##### APPLIST END ##### -------------

];
}
