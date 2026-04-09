{ inputs, ... }:

{
  networking.hostName = "myServer";
  system.stateVersion = "25.11";

  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix # main settings
    ../../modules/utility/shell_aliases.nix # shell aliases
    ../../modules/server/apps.nix # kitty, git

    ../../modules/server/ssh.nix # ssh config
    ../../modules/server/cloudflare.nix # cloudflared config, cloudflare-dyndns config
    ../../modules/server/docker-networks.nix # docker, docker networks config

    ../../modules/server/wireguard.nix # wireGuard config
    ../../modules/server/syncthing.nix # syncthing config
    ../../modules/server/traefik.nix # traefik config

    ../../modules/users/server/server.nix
  ];
}
