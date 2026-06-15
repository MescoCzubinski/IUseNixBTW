{ config, pkgs, ... }:

{
  users.users.mieszko = {
    isNormalUser = true;
    description = "mieszko";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" "syncthing" "users"];
  };
}
