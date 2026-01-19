{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    signal-desktop
    onlyoffice-desktopeditors
	  brave
    spotify
  ];
}
