{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = false;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.gamemode.enable = true;

  environment.sessionVariables = {
    STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
    SDL_VIDEODRIVER = "wayland,x11";
  };
}
