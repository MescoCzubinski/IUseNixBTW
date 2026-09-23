{ config, pkgs, ... }:

{
  users.users.mieszko = {
    isNormalUser = true;
    description = "mieszko";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "video" "docker" "users" ];
  };
}
