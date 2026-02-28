{ config, pkgs, ... }:

{
  programs.ssh.extraConfig = ''
    Host ssh.czubinski.dev
        ProxyCommand ${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h
    '';

  environment.systemPackages = with pkgs; [ cloudflared ];
}
