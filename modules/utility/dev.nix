{ config, pkgs, unstablePkgs, ... }:

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

  # claude-code
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
    ];
  };

  environment.systemPackages = with pkgs; [
    docker
    skills
    yaak
    miktex
    kubectl
    kubernetes-helm

    unstablePkgs.claude-code
    unstablePkgs.code-cursor
  ];

  environment.variables.GOPATH = "$HOME/.local/share/go";
}
