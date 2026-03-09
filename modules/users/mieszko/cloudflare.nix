{ config, pkgs, ... }:

{
  home.packages = [ pkgs.cloudflared ];

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "ssh.czubinski.dev" = {
        hostname = "ssh.czubinski.dev";
        proxyCommand = "${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h";
        user = "server";
        extraOptions = {
          "CheckHostIP" = "no";
        };
      };
    };
  };
}
