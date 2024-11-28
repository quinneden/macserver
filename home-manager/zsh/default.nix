{
  pkgs,
  config,
  ...
}:
{
  # imports = [ ./starship.nix ];

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    shellAliases = {
      cddf = "cd $dotdir";
      cddl = "cd ~/Downloads";
      code = "codium";
      gst = "git status";
      gsur = "git submodule update --init --recursive";
      l = "eza -la --group-directories-first";
      ll = "eza -glAh --octal-permissions --group-directories-first";
      ls = "eza -A";
      push = "git push";
      tree = "eza -ATL3 --git-ignore";
      bs = "stat -c%s";
      db = "distrobox";
      wd = "cd ~/workdir";
    };
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "fzf"
        "eza"
        "zoxide"
        "direnv"
      ];
      custom = "${config.xdg.configHome}/zsh";
    };
    initExtraBeforeCompInit = ''fpath+=("${pkgs.nix}/share/zsh/site-functions")'';
    initExtra = ''
      HISTFILE="$ZDOTDIR/.zsh_history"; export HISTFILE

      if type zoxide &>/dev/null; then eval "$(zoxide init zsh)"; fi
      if type z &>/dev/null; then alias cd='z'; fi

      for f ($HOME/.config/zsh/functions/*(N.)); do source $f; done

      autoload -U promptinit; promptinit
      prompt pure
    '';
    sessionVariables = {
      compdir = "$HOME/.config/zsh/completions";
      dotdir = "$HOME/.dotfiles";
      EDITOR = "mi";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      MICRO_TRUECOLOR = "1";
      PAGER = "bat --style=grid,numbers --wrap=never";
      NIXOS_CONFIG = "$HOME/.dotfiles";
    };
  };
}
