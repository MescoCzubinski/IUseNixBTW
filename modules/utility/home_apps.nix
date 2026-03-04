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
    "code" = {
      name = "VS Code";
      exec = "code";
      terminal = false;
    };
    "kitty" = {
      name = "Kitty";
      exec = "kitty";
      terminal = false;
    };
    "yaak" = {
      name = "Yaak";
      exec = "yaak";
      terminal = false;
    };
    "nixos-manual" = {
      name = "NixOS Manual";
      exec = "nixos-help";
      noDisplay = true;
    };
  };
}
