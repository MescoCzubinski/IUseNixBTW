{ pkgs, unstablePkgs, ... }:

{
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  environment.systemPackages = with pkgs; [
    unstablePkgs.openlogi
  ];

}
