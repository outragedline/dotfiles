{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./devenv.nix
  ];

  home.username = "degarti";
  home.homeDirectory = "/home/degarti";

  home.file.".config/wallpapers" = {
    source = ../home/wallpapers;
    recursive = true;
  };

  home.sessionPath = [
    "~/.local/bin"
    "~/.cargo/bin"
  ];

  home.packages = with pkgs; [
    obs-studio
    qbittorrent
    ueberzugpp
    telegram-desktop
    brave
    zathura
  ];

  services.syncthing.enable = true;

  home.stateVersion = "25.05";
}
