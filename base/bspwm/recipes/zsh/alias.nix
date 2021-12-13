{
cl = "eval $(ssh-agent -s) && ssh-add ~/.ssh/github && git clone";
push = "eval $(ssh-agent -s) && ssh-add ~/.ssh/github && git push";
switch = "home-manager switch";
rebuid = "sudo nixos-rebuild switch";
tmp = "nix-shell -p";
ls = "exa -laHG --icons";
top = "htop";
nano = "nvim";
emacs = "nvim";
v = "nvim";
tree = "broot";
ssf = "setsid -f";
}
