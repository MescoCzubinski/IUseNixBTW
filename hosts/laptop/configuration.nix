{ inputs, ... }:

{
  networking.hostName = "myLaptop";
  system.stateVersion = "25.11";

  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix # main settings
    ../../modules/laptop/battery.nix # battery services

    ../../modules/utility/services.nix # services: audio, network, bluetooth
    ../../modules/utility/desktop.nix # desktop enviroment (Hyperland)
    ../../modules/utility/shell_aliases.nix # shell aliases
    ../../modules/utility/apps.nix # discord, spotify, browser, only office, etc.

    ../../modules/dev/dev.nix # cursor, nvim, tools, languages

    ../../modules/laptop/wireguard.nix # wireguard client
    ../../modules/client/syncthing.nix # sync with server

    ../../modules/users/mieszko/mieszko.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };

    users.mieszko = {
      imports = [
        ../../home/home.nix # dotfiles, cursor, etc.
        ../../modules/users/mieszko/antigravity.nix # antigravity settings
        ../../modules/users/mieszko/apps.nix # rename apps
        ../../modules/users/mieszko/cloudflare.nix # cloudflare config file
        ../../modules/users/mieszko/folders.nix # home folders
        ../../modules/users/mieszko/vscode.nix # vscode settings
        ../../modules/users/mieszko/wireguard.nix # wireguard switch logic
      ];
    };
  };
}
