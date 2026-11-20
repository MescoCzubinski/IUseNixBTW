{ config, pkgs, ... }:

{
  programs.fish.enable = true;
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 50000;
    clock24 = true;
    terminal = "tmux-256color";
    extraConfig = ''
      set -g mouse on
      set -g focus-events on
      set -g renumber-windows on
      set -g allow-passthrough on
      set -g extended-keys on
      set -g extended-keys-format csi-u
      set -as terminal-features 'xterm-kitty:RGB:extkeys'
      set -g status-style 'bg=#101010 fg=#c8c8cc'
    '';
  };

  programs.bash.interactiveShellInit = ''
    function yazi() {
      local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
      command yazi "$@" --cwd-file="$tmp"
      if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
      fi
      rm -f -- "$tmp"
    }
  '';
}
