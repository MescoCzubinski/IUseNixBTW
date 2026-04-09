{ config, pkgs, ... }:

{
  xdg.desktopEntries = {
    "brave-browser" = {
      name = "Brave";
      exec = "brave";
      terminal = false;
    };
    "onlyoffice-desktopeditors" = {
      name = "Only Office";
      exec = "onlyoffice-desktopeditors";
      terminal = false;
    };
    "nixos-manual" = {
      name = "NixOS Manual";
      exec = "nixos-help";
      noDisplay = true;
    };
  };
}
