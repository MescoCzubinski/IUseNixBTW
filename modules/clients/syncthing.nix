{ pkgs, private, ... }:

{
  services.syncthing = {
    enable = true;
    user = "mieszko";
    group = "users";
    dataDir = "/home/mieszko/";
    configDir = "/home/mieszko/.config/syncthing";

    settings = {
      devices = {
        "myServer" = {
          id = private.syncthingServerId;
          addresses = [ "tcp://${private.serverVpnIp}:22000" ];
        };
      };
      folders = {
        "Notes" = {
          path = "/home/mieszko/Notes";
          devices = [ "myServer" ];
        };
        "Pictures" = {
          path = "/home/mieszko/Pictures";
          devices = [ "myServer" ];
          ignorePatterns = [ "/Phone" ];
        };
        "Phone" = {
          path = "/home/mieszko/Pictures/Phone";
          devices = [ "myServer" ];
        };
      };
    };
  };
}
