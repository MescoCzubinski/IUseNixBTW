{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    spotify
    obsidian
    logseq
    brave
    signal-desktop
    onlyoffice-desktopeditors
  ];
}
