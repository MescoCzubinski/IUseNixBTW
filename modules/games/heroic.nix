{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    heroic
    legendary-gl
  ];
}
