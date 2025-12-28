{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    antigravity-nix.url = "github:jacopone/antigravity-nix";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, antigravity-nix,... }@inputs: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.overlays = [ antigravity-nix.overlays.default ]; }

          ./common.nix
          ./hosts/laptop/conf.nix
          ./hosts/laptop/hardware-configuration.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.mieszko = import ./hosts/laptop/home.nix;
          }
        ];
      };
    };
  };
}