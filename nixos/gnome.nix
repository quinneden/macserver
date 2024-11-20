{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gnome = {
    enable = lib.mkEnableOption "Gnome";
  };

  config = lib.mkIf config.gnome.enable {
    environment = {
      systemPackages = with pkgs; [
        morewaita-icon-theme
        qogir-icon-theme
        gnome-extension-manager
        wl-clipboard
      ];

      gnome.excludePackages = with pkgs; [
        atomix # puzzle game
        cheese # webcam tool
        epiphany # web browser
        evince # document viewer
        geary # email reader
        gedit
        gnome-characters
        gnome-connections
        gnome-console
        gnome-contacts
        gnome-font-viewer
        gnome-initial-setup
        gnome-maps
        gnome-music
        gnome-photos
        gnome-shell-extensions
        # gnome-text-editor
        gnome-tour
        hitori # sudoku game
        iagno # go game
        snapshot
        tali # poker game
        totem # video player
        yelp # Help view
      ];
    };

    services.xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    programs.dconf.profiles.gdm.databases = [
      {
        settings = {
          "org/gnome/desktop/peripherals/touchpad" = {
            tap-to-click = true;
          };
          "org/gnome/desktop/interface" = {
            cursor-theme = "Qogir";
          };
        };
      }
    ];
  };
}
