{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeScriptBin "batch-rename" (builtins.readFile ./rename.sh))
  ];

  home.file = {
    ".config/yazi".source = ../dotfiles/yazi;
    ".config/xdg-desktop-portal-termfilechooser/config".text = ''
      [filechooser]
      cmd=${pkgs.writeShellScript "yazi-picker" ''
        # portal args: $1 multiple, $2 directory, $3 save, $4 suggested path, $5 out file
        if [ "$2" = "1" ]; then
          # folder picker: take an explicitly chosen dir, else the dir yazi exits in
          ${pkgs.kitty}/bin/kitty --title termfilechooser ${pkgs.yazi}/bin/yazi --chooser-file="$5" --cwd-file="$5.cwd" "$4"
          [ -s "$5" ] || cat "$5.cwd" > "$5" 2>/dev/null
          rm -f "$5.cwd"
        else
          ${pkgs.kitty}/bin/kitty --title termfilechooser ${pkgs.yazi}/bin/yazi --chooser-file="$5" "$4"
        fi
      ''}
    '';
  };
}
