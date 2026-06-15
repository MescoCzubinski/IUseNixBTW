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
      user.email = "181373867+MescoCzubinski@users.noreply.github.com";
      init.defaultBranch = "main";
    };
  };

  environment.systemPackages = with pkgs; [
    # code editors
    jetbrains.idea

    # dev tools
    docker
    yaak
    miktex
  ];

  environment.variables.GOPATH = "$HOME/.local/share/go";
}
