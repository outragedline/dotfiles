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
  ];

  home.stateVersion = "25.05";
}
