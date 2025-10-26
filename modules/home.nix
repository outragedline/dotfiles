{ pkgs, ... }:

{
  imports = [
    ./devenv.nix
    ./alacrittty.nix
  ];

  home.packages = with pkgs; [
    xdg-xdg-desktop-portal-gnome
    pavucontrol
    rofi
    alacritty
    wl-clipboard
    swww
    git-lfs
    networkmanagerapplet
    nerd-fonts.jetbrains-mono
    fastfetch
    waypaper
    grimblast
    catppuccin-cursors.mochaSapphire
    playerctl

    obs-studio
    ueberzugpp
    telegram-desktop
    brave
    zathura

    # eww
    brightnessctl
    socat
    jq
    inotify-tools
    pamixer

    niri
    xwayland-satellite
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

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  xdg.configFile."niri".source = ../home/niri;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  programs.swaylock.enable = true;
  services.mako.enable = true;
  services.swayidle.enable = true;
  services.polkit-gnome.enable = true;

  programs.eww = {
    enable = true;
    configDir = ../home/eww;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  services.syncthing.enable = true;

  home.stateVersion = "25.05";
}
