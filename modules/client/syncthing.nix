{ pkgs, ... }:

{
  users.users.syncthing = {
    isSystemUser = true;
    group = "syncthing";
  };
  users.groups.syncthing = {};

  services.syncthing = {
    enable = true;
    user = "mieszko";
    group = "users";
    dataDir = "/home/mieszko/";
    configDir = "/home/mieszko/.config/syncthing";

    settings = {
      devices = {
        "myServer" = {
          id = "OEQXKTH-VLTECOA-L2CM74C-UVXQMKN-M35O2MN-XMQZ6NG-HHK5OE6-KPATYQ3";
          addresses = [ "tcp://10.0.0.1:22000" ];
        };
      };
      folders = {
        "SecondBrain" = {
          path = "/home/mieszko/SecondBrain";
          devices = [ "myServer" ];
        };
        "Pictures" = {
          path = "/home/mieszko/Pictures";
          devices = [ "myServer" ];
        };
        "Shared" = {
          path = "/home/mieszko/Shared";
          devices = [ "myServer" ];
        };
      };
    };
  };
}
