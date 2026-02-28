{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    signal-desktop
    spotify
    obsidian
    brave
    onlyoffice-desktopeditors
  ];
}
