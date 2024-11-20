{
  description = "Configurations of Aylur";

  outputs =
    inputs@{
      self,
      home-manager,
      nixpkgs,
      nixos-apple-silicon,
      lix-module,
      ...
    }:
    {
      packages.aarch64-linux.default = nixpkgs.legacyPackages.aarch64-linux.callPackage ./ags {
        inherit inputs;
      };

      # nixos config
      nixosConfigurations = {
        macserver = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = {
            inherit inputs;
            asztal = self.packages.aarch64-linux.default;
            secrets = builtins.fromJSON (builtins.readFile .secrets/common.json);
          };
          modules = [
            ./nixos
            home-manager.nixosModules.home-manager
            nixos-apple-silicon.nixosModules.default
            lix-module.nixosModules.default
            { networking.hostName = "nixos"; }
          ];
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland-hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    ags.url = "github:Aylur/ags";
    astal.url = "github:Aylur/astal";

    lf-icons = {
      url = "github:gokcehan/lf";
      flake = false;
    };

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };
  };
}
