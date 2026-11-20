{ config, pkgs, unstablePkgs, inputs, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune.enable = true;
  };

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
    yaak
    docker
    skills
    nodejs
    python3
    typescript
    typescript-language-server
    gh
    opencode

    openssl
    kubectl
    k0sctl
    kubeseal
    kubernetes-helm
    opentofu

    unstablePkgs.antigravity-ide
    unstablePkgs.antigravity-cli
    unstablePkgs.code-cursor
    unstablePkgs.vscode
  ];

  home-manager.users.mieszko = {
    imports = [ inputs.hermes-agent.homeManagerModules.default ];

    programs.hermes-agent = {
      enable = true;
      desktop.enable = true;
    };
  };

  environment.variables.GOPATH = "$HOME/.local/share/go";
}
