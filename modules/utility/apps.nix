{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.claude-desktop.packages.${pkgs.system}.claude-desktop-fhs

    discord
    spotify
    obsidian
    brave
    signal-desktop
    onlyoffice-desktopeditors
    krita
    rnote

    # productivity
    blanket
    gnome-solanum
  ];
}
