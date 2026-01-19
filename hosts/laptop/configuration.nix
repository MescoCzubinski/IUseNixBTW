{ inputs, ... }: {
  networking.hostName = "laptop";
  system.stateVersion = "25.11";

  imports = [
    ./hardware-configuration.nix
    ../../modules/default.nix
    ../../modules/utilities.nix
    ../../modules/dev.nix
    ../../modules/antigravity.nix
    ../../modules/wireguard.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.mieszko = {
      imports = [ ../../home ];
    };
  };
}
