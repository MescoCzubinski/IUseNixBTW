{ inputs, pkgs, ... }: {
  nixpkgs.overlays = [
    inputs.antigravity-nix.overlays.default
  ];
}

