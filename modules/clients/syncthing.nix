{ pkgs, private, ... }:

{
  services.syncthing = {
    enable = true;
    user = "mieszko";
    group = "users";
    dataDir = "/home/mieszko/";
    configDir = "/home/mieszko/.config/syncthing";

    settings = {
      options = {
        globalAnnounceEnabled = false;
        relaysEnabled = false;
      };
      devices = {
        "myServer" = {
          id = private.syncthingServerId;
          addresses = [ "tcp://192.168.0.1:22000" ];
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
        };
      };
    };
  };
}
