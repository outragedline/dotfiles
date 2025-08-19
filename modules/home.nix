{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./devenv.nix
  ];

  home.username = "outragedline";
  home.homeDirectory = "/home/outragedline";

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
  ];

  home.stateVersion = "25.05";
}
