{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    spotify
    obsidian
    affine
    onlyoffice-desktopeditors
    inputs.claude-desktop.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop-fhs
    winboat
    miktex

    # graphic
    krita
    rnote

    # communicator
    discord
    signal-desktop

    # browsers
    brave
    google-chrome
    firefox
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
