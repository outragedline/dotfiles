{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  zramSwap = {
    enable = true;
    memoryPercent = 80;
    algorithm = "zstd";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r --remember-user-session";
        user = "greeter";
      };
    };
  };

  time.timeZone = "America/Sao_Paulo";

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    helix
    wget
    git
    git-lfs
  ];

  virtualisation.docker.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.dconf.enable = true;

  users.users.outragedline = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "power"
    ];
  };

  users.defaultUserShell = pkgs.nushell;
  home-manager.users.outragedline =
    { ... }:
    {
      imports = [
        ./hyprland.nix
        ./devenv.nix
      ];

      home.username = "outragedline";
      home.homeDirectory = "/home/outragedline";
    };

  system.stateVersion = "25.05";
}
