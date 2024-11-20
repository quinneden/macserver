{ pkgs, ... }:
{
  documentation.nixos.enable = false;
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  # dconf
  programs.dconf.enable = true;

  # packages
  environment.systemPackages = with pkgs; [
    home-manager
    asahi-bless
    git
    wget
    micro
  ];

  security.sudo.wheelNeedsPassword = false;

  networking = {
    wireless.iwd = {
      enable = true;
      settings = {
        IPv6.Enabled = true;
        Settings.AutoConnect = true;
        General.EnableNetworkConfiguration = true;
      };
    };
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  services = {
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
    };
    printing.enable = true;
    flatpak.enable = true;
    openssh.enable = true;
  };

  # logind
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=ignore
  '';

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings.General.Experimental = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  # bootloader
  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      timeout = 2;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
  };

  hardware.asahi = {
    enable = true;
    setupAsahiSound = true;
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
    extractPeripheralFirmware = true;
    peripheralFirmwareDirectory = builtins.fetchTarball {
      url = "https://qeden.me/fw/asahi-firmware-20241024.tar.gz";
      sha256 = "sha256-KOBXP/nA3R1+/8ELTwsmmZ2MkX3lyfp4UTWeEpajWD8=";
    };
  };

  system.stateVersion = "23.05";
}
