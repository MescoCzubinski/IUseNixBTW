{ inputs, ... }:

{
  networking.hostName = "myDesktop";
  system.stateVersion = "25.11";

  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/utility/desktop.nix
    ../../modules/utility/nvidia.nix
    ../../modules/utility/apps.nix
    ../../modules/utility/battery.nix
    ../../modules/utility/logitech.nix
    ../../modules/server/cloudflare.nix
    ../../modules/server/samba.nix
    ../../modules/server/desktop_wireguard.nix
    ../../modules/dev/dev.nix
    ../../modules/games/heroic.nix
    ../../modules/games/steam.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };

    users.mieszko = {
      imports = [
        ../../home/home.nix
        ../../modules/dev/home_vscode.nix
        ../../modules/server/home_wireguard.nix
        ../../modules/server/home_cloudflare.nix
        ../../modules/utility/home_apps.nix
      ];
    };
  };
}
