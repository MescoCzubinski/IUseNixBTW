{ inputs, ... }:

{
  networking.hostName = "myDesktop";
  system.stateVersion = "26.05";

  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/desktop/nvidia.nix
    ../../modules/desktop/logitech.nix

    ../../modules/utility/services.nix
    ../../modules/utility/desktop.nix
    ../../modules/utility/session_manager.nix
    ../../modules/utility/shell.nix
    ../../modules/utility/shell_aliases.nix
    ../../modules/utility/apps.nix
    ../../modules/utility/dev.nix

    ../../modules/server/samba.nix
    ../../modules/server/syncthing.nix
    ../../modules/server/network.nix
    ../../modules/desktop/wireguard.nix

    ../../modules/games/steam.nix
    ../../modules/games/heroic.nix

    ../../modules/users/mieszko.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };

    users.mieszko = {
      imports = [ ../../home/home.nix ];
    };
  };
}
