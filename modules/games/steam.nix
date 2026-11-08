{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = false;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    extraPackages = with pkgs; [ mangohud gamescope pulseaudio ];
  };

  programs.gamemode = {
    enable = true;
    settings.general.renice = 10;
  };
  users.users.mieszko.extraGroups = [ "gamemode" ];

  programs.gamescope.enable = true;
  environment.systemPackages = [ pkgs.mangohud ];

  environment.sessionVariables = {
    STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
    SDL_VIDEODRIVER = "wayland,x11";

    __GL_SHADER_DISK_CACHE_SIZE = "12000000000";
    __GL_SHADER_DISK_CACHE_SKIP_CLEANUP = "1";
  };
}
