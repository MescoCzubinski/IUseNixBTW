{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    config = {
      user.name = "MescoCzubinski";
      user.email = "mieszkoczubinski@gmail.com";
      init.defaultBranch = "main";
    };
  };

  environment.systemPackages = with pkgs; [
    # code editors
    vscode
    code-cursor

    # antigravity
    google-antigravity
    google-chrome

    # dev tools
    docker
    yaak
    cloudflared

    # languages
    nodejs
    python3
    go
  ];

  environment.variables.GOPATH = "$HOME/.local/share/go";
}
