{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ cloudflared ];

#   services.cloudflared = {
#     enable = true;
#     tunnels = {
#       "ebf2e2d0-910a-435c-b687-a8c1feadda2f" = {
#         credentialsFile = "/var/lib/cloudflare/tunnel-key.json";
#         default = "http_status:404";
#         ingress = {
#           "www.czubinski.dev" = "https://127.0.0.80";
#           "czubinski.dev" = "https://127.0.0.80";
#         };
#       };
#     };
#   };

  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = "/var/lib/cloudflare-dyndns/token";
    domains = [ "vpn.czubinski.dev" ];
  };
}
