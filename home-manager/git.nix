{ pkgs, secrets, ... }:
let
  username = "quinneden";
in
{
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "micro";
      credential.helper = "store";
      github.user = username;
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      url."https://oauth2:${secrets.github.token}@github.com".insteadOf = "https://github.com";
    };
    userEmail = "quinnyxboy@gmail.com";
    userName = username;
  };
}
