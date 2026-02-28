{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    batsignal
  ];
}
