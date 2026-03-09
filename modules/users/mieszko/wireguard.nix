{ pkgs, ... }:

{
  home.file = {
    ".config/scripts/vpn.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        SYSTEMCTL="/run/current-system/sw/bin/systemctl"
        SERVICE="wireguard-wg0.service"

        if [ "$1" == "toggle" ]; then
            if $SYSTEMCTL is-active --quiet "$SERVICE"; then
                sudo $SYSTEMCTL stop "$SERVICE"
            else
                sudo $SYSTEMCTL start "$SERVICE"
            fi
            pkill -RTMIN+8 waybar
        else
            if $SYSTEMCTL is-active --quiet "$SERVICE"; then
                echo '{"text": "󰔡", "class": "connected"}'
            else
                echo '{"text": "󰨙", "class": "disconnected"}'
            fi
        fi
      '';
    };
  };
}
