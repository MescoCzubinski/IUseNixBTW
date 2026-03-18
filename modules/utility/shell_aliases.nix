{ config, pkgs, ... }:

{
  environment.shellAliases = {
    "sl" = "ls";
    "la" = "ls -a";
    "dc" = "cd";
    "c" = "cd";
    "cd.." = "cd ..";
    "cl" = "clear";

    "git-pull" = "git fetch && git pull";
    "git-commit" = "git add . && git commit -m";
    "git-count" = "git ls-files | grep -vE \"\\.(png|jpg|jpeg|gif|pdf)$\" | xargs wc -l";

    "wg-status" = "sudo wg show && systemctl status wireguard-wg0.service && ping 10.0.0.1";

    "nix-use" = "export NIXPKGS_ALLOW_UNFREE=1 && nix-shell -p";
    "nix-clean" = "sudo nix-collect-garbage -d";

    "nix-laptop" = "(cd ~/.nixos && git add . && sudo nixos-rebuild switch --flake .#laptop)";
    "nix-desktop" = "(cd ~/.nixos && git add . && sudo nixos-rebuild switch --flake .#desktop)";
    "nix-update-laptop" = "cd ~/.nixos && sudo nix flake update && sudo nixos-rebuild switch --flake .#laptop";
    "nix-update-desktop" = "cd ~/.nixos && sudo nix flake update && sudo nixos-rebuild switch --flake .#desktop";

    "nix-server" = "tmux new-session -d 'cd ~/.nixos && git pull && sudo nixos-rebuild boot --flake .#server && sudo reboot' && tmux attach";
    "nix-update-server" = "tmux new-session -d 'cd ~/.nixos && git pull && sudo nix flake update && sudo nixos-rebuild boot --flake .#server && sudo reboot' && tmux attach";
  };
}
