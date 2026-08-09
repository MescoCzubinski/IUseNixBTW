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
          id = "YCDC7E4-UYIV5RI-OH22JFP-Z5S67WL-NT3RCRA-QHLNZ6N-O6WLMQA-72D36AF";
          addresses = [ "tcp://10.0.0.1:30022" ];
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
        "Phone" = {
          path = "/home/mieszko/Pictures/Phone";
          devices = [ "myServer" ];
        };
      };
    };
  };
}
