{
  inputs,
  lib,
  ...
}:
let
  username = "quinn";
in
{
  imports = [
    ./hardware.nix
    ./system.nix
    ./locale.nix
    ./nautilus.nix
    ./hyprland.nix
    ./gnome.nix
  ];

  hyprland.enable = false;
  gnome.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    initialPassword = username;
    extraGroups = [
      "nixosvmtest"
      "networkmanager"
      "wheel"
    ];
  };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };
    users.${username} = {
      home.username = username;
      home.homeDirectory = "/home/${username}";
      imports = [
        ../home-manager/ags.nix
        ../home-manager/blackbox.nix
        ../home-manager/browser.nix
        ../home-manager/dconf.nix
        ../home-manager/git.nix
        ../home-manager/hyprland.nix
        # ../home-manager/lf.nix
        ../home-manager/packages.nix
        ../home-manager/zsh
        ../home-manager/theme.nix
        ../home-manager/tmux.nix
        ../home-manager/wezterm.nix
        ./home.nix
      ];
    };
  };

  # specialisation = {
  #   gnome.configuration = {
  #     system.nixos.tags = [ "Gnome" ];
  #     hyprland.enable = lib.mkForce false;
  #     gnome.enable = true;
  #   };
  # };
}
