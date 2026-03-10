{ pkgs, ... }:

{
  services.tlp.enable = true;

  environment.systemPackages = with pkgs; [
    batsignal
  ];
}
