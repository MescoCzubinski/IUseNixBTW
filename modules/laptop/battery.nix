{ pkgs, ... }:

{
  services.upower.enable = true;
  services.tlp.enable = true;

  environment.systemPackages = with pkgs; [
    batsignal
  ];
}
