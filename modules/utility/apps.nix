{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    spotify
    obsidian
    brave
    signal-desktop
    onlyoffice-desktopeditors
  ];
}
