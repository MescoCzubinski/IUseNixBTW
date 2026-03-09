{ config, pkgs, ... }:

{
  environment.shellAliases = {
    "sl" = "ls";
    "la" = "ls -a";
    "dc" = "cd";
    "c" = "cd";
    "cd.." = "cd ..";

    "git-pull" = "git fetch && git pull";
    "git-commit" = "git add . && git commit -m";
    "git-count" = "git ls-files | grep -vE \"\\.(png|jpg|jpeg|gif|pdf)$\" | xargs wc -l";

    "nix-use" = "export NIXPKGS_ALLOW_UNFREE=1 && nix-shell -p";
    "nix-clean" = "sudo nix-collect-garbage -d";
    "nix-laptop" = "(cd ~/.nixos && git add . && sudo nixos-rebuild switch --flake .#laptop)";
    "nix-desktop" = "(cd ~/.nixos && git add . && sudo nixos-rebuild switch --flake .#desktop)";
    "nix-server" = "(cd ~/.nixos && git add . && sudo nixos-rebuild switch --flake .#server)";
    "nix-update-laptop" = "cd ~/.nixos && sudo nix flake update && sudo nixos-rebuild switch --flake .#laptop";
    "nix-update-desktop" = "cd ~/.nixos && sudo nix flake update && sudo nixos-rebuild switch --flake .#desktop";
    "nix-update-server" = "cd ~/.nixos && sudo nix flake update && sudo nixos-rebuild switch --flake .#server";
  };
}
