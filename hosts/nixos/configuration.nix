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
  boot.initrd.luks.devices."root".device = "/dev/disk/by-label/CRYPTONIX";

  zramSwap = {
    enable = true;
    memoryPercent = 80;
    algorithm = "zstd";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/hyprland";
        user = "degarti";
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
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  networking.networkmanager.enable = true;

  security.sudo-rs.enable = true;
  environment.systemPackages = with pkgs; [
    helix
    wget
    git
    git-lfs
    home-manager
    uutils-coreutils-noprefix
    bluetui
  ];

  environment.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };
  virtualisation.docker.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.dconf.enable = true;

  users.users.degarti = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "power"
      "video"
      "audio"
    ];
    shell = pkgs.nushell;
  };

  users.defaultUserShell = pkgs.nushell;

  system.stateVersion = "25.05";
}
