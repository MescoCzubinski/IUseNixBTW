{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;

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
    code-cursor
    neovim
    jetbrains.idea

    claude-code

    # dev tools
    docker
    yaak

    # languages
    nodejs
    python3
    go
  ];

  environment.variables.GOPATH = "$HOME/.local/share/go";
}
