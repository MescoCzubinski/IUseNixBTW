{ config, pkgs, unstablePkgs, ... }:

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

  # claude-code
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
      icu
      krb5
    ];
  };

  environment.systemPackages = with pkgs; [
    yaak
    docker
    skills
    ollama-vulkan
    gh
    (vscode.overrideAttrs (old: {
      postPatch = builtins.replaceStrings
        [ "resources/app/node_modules/@vscode/ripgrep/bin/rg" ]
        [ "resources/app/node_modules.asar.unpacked/@vscode/ripgrep-universal/bin/linux-x64/rg" ]
        old.postPatch;
    }))

    openssl
    kubectl
    k0sctl
    kubeseal
    kubernetes-helm
    opentofu

    unstablePkgs.antigravity-ide
    unstablePkgs.antigravity-cli
    unstablePkgs.claude-code
    unstablePkgs.code-cursor
  ];

  environment.variables.GOPATH = "$HOME/.local/share/go";
}
