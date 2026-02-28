{ inputs, ... }:

{
  networking.hostName = "myDesktop";
  system.stateVersion = "25.11";

  imports = [
    ./hardware-configuration.nix
    ../../modules/default.nix
    ../../modules/desktop.nix
    ../../modules/utilities.nix
    ../../modules/dev.nix
    ../../modules/nvidia.nix
    ../../modules/steam.nix
    ../../modules/heroic.nix
    ../../modules/logitech.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.mieszko = {
      imports = [
        ../../home
      ];
    };
  };
}
