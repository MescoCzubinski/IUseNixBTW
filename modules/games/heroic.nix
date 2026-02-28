{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    heroic
    legendary-gl
  ];

  hardware.graphics.enable32Bit = true;
}
