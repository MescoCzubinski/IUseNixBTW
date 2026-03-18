{ config, pkgs, ... }:

{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    download = "${config.home.homeDirectory}/Downloads";
    pictures = "${config.home.homeDirectory}/Pictures";
    music = "${config.home.homeDirectory}/Downloads";
    videos = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Downloads";
    templates = null;
    publicShare = null;
    desktop = null;
  };

  home.activation.createCustomDirs = {
    after = [ "writeBoundary" ];
    before = [ ];
    data = ''
      mkdir -p $HOME/Projects $HOME/SecondBrain $HOME/Pictures $HOME/Downloads $HOME/Shared
    '';
  };
}
