{ inputs, ... }:

{
  networking.hostName = "myLaptop";
  system.stateVersion = "25.11";

  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix # common file with main settings
    ../../modules/utility/battery.nix # batsignal - only for laptop
    ../../modules/utility/desktop.nix # desktop enviroment (Hyperland)
    ../../modules/utility/apps.nix # discord, spotify, browser, only office, etc.
    ../../modules/dev/dev.nix # cursor, tools, languages
    ../../modules/client/wireguard.nix # wireguard client
    ../../modules/client/syncthing.nix # mount NAS
    ../../modules/utility/logitech.nix # in case of plugin to dock station
    ../../modules/games/heroic.nix # Epic Games Launcher
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };

    users.mieszko = {
      imports = [
        ../../home/home.nix # dotfiles, cursor, etc.
        ../../modules/dev/home_vscode.nix # vscode settings
        ../../modules/dev/home_antigravity.nix # antigravity settings
        ../../modules/client/home_wireguard.nix # wireguard switch logic
        ../../modules/client/home_cloudflare.nix # cloudflare config file
        ../../modules/utility/home_apps.nix # rename apps
        ../../modules/utility/home_folders.nix # home folders
      ];
    };
  };
}
