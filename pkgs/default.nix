inputs: final: prev: {
  plymouth-theme = prev.callPackage ./plymouth-themes {};

  gdb-frontend = prev.callPackage ./gdb-frontend {};
  # instant repl with automatic flake loading
  repl = prev.callPackage ./repl {};

  discord-openasar = prev.callPackage ./discord rec {
    inherit (prev.discord) pname;
    version = "0.0.21";
    src = prev.fetchurl {
      url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
      sha256 = "sha256-KDKUssPRrs/D10s5GhJ23hctatQmyqd27xS9nU7iNaM=";
    };

    openasar = prev.callPackage "${inputs.nixpkgs}/pkgs/applications/networking/instant-messengers/discord/openasar.nix" {};
    binaryName = "Discord";
    desktopName = "Discord";

    webRTC = true;
    enableVulkan = true;

    extraOptions = [
      "--disable-gpu-memory-buffer-video-frames"
      "--enable-accelerated-mjpeg-decode"
      "--enable-accelerated-video"
      "--enable-gpu-rasterization"
      "--enable-native-gpu-memory-buffers"
      "--enable-zero-copy"
      "--ignore-gpu-blocklist"
    ];
  };

  # sway-borders = prev.callPackage ./sway-borders {};
}
