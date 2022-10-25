{
  pkgs,
  stdenv,
  ...
}:
stdenv.mkDerivation {
  name = "sway-borders";
  version = "1.7";

  src = pkgs.fetchFromGitHub {
    owner = "fluix-dev";
    repo = "sway-borders";
    rev = "3890d2a2fb255276993891e2da5f6cb33670efcd";
    sha256 = "esMruivwq6XPPYJWaW825+d8rD8NOxbJQqVfAeBtXe0=";
  };

  nativeBuildInputs = with pkgs; [
    meson
    ninja
    pkg-config
    wayland
    scdoc
  ];

  buildInputs = with pkgs; [
    wayland
    libxkbcommon
    pcre
    json_c
    dbus
    libevdev
    pango
    cairo
    libinput
    libcap
    pam
    gdk-pixbuf
    librsvg
    wlroots
    wayland-protocols
  ];

  mesonFlags = [
    "-Ddefault-wallpaper=false"
  ];

  meta = with pkgs.lib; {
    description = "An i3-compatible tiling Wayland compositor";
    longDescription = ''
      Sway is a tiling Wayland compositor and a drop-in replacement for the i3
      window manager for X11. It works with your existing i3 configuration and
      supports most of i3's features, plus a few extras.
      Sway allows you to arrange your application windows logically, rather
      than spatially. Windows are arranged into a grid by default which
      maximizes the efficiency of your screen and can be quickly manipulated
      using only the keyboard.
    '';
    homepage = "https://swaywm.org";
    changelog = "https://github.com/swaywm/sway/releases/tag/${version}";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [primeos synthetica ma27];
  };
}
