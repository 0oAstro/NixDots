{
  pkgs,
  inputs,
  ...
}:
# games
{
  home.packages =
    (with pkgs; [
      mangohud
      gamescope
      legendary-gl
    ])
    ++ (with inputs.nix-gaming.packages.${pkgs.system}; [
      (inputs.nix-gaming.lib.legendaryBuilder {
        games = {
          rocket-league = {
            desktopName = "Rocket League";
            tricks = ["dxvk" "win10"];
            icon = builtins.fetchurl {
              url = "https://img.favpng.com/21/12/21/rocket-league-video-game-psyonix-logo-decal-png-favpng-yYh6A3FRCJNh7JYgYZchHxAia.jpg";
              name = "rocket-league.png";
              sha256 = "0ymisjgcmw8mkarnkm95dsndii2aw9yn5i3vfximi2dchy4ng8ab";
            };
            discordIntegration = false;
          };
        };
        inherit (pkgs) system;
      })
      .rocket-league
    ]);
}
