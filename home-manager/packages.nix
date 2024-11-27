{ pkgs, inputs, ... }:
{
  imports = [
    ./modules/packages.nix
    ./scripts/blocks.nix
    ./scripts/vault.nix
  ];

  packages = with pkgs; {
    linux = [
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
      fragments
      inputs.nix-shell-scripts.packages.aarch64-linux.default
      nh
      nodejs
      nil
      # (vagrant.override { withLibvirt = false; })
    ];
    cli = [
      bat
      eza
      fd
      fzf
      gptfdisk
      gh
      git-crypt
      git-lfs
      glow
      gnumake
      gnupg
      jq
      lazydocker
      lazygit
      nixfmt-rfc-style
      pure-prompt
      python3
      rclone
      ripgrep
      udiskie
      zoxide
    ];
  };
}
