{ ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
    '';
    functions = {
      fish_user_key_bindings = ''
        bind \t __accept_or_complete
      '';
      __accept_or_complete = ''
        set -l before (commandline)
        commandline -f accept-autosuggestion
        if test (commandline) = "$before"
          commandline -f complete
        end
      '';

      yazi = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and test -n "$cwd"; and test "$cwd" != "$PWD"
          builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';

      fish_prompt = ''
        echo
        set -l abg e2e2e2
        set -l afg 101010
        set -l ibg 3a3a3c
        set -l ifg c8c8cc

        set -l path (prompt_pwd -d 0)
        set -l parent (string replace -r '/[^/]+$' "" -- $path)
        set -l leaf (string replace -r '.*/' "" -- $path)
        test "$parent" = "$path"; and set parent ""

        if test -n "$parent"
            set_color -b $ibg $ifg
            echo -n "$parent/"
        end

        set_color -b $abg $afg
        echo -n "$leaf"
        set_color normal
        set_color $abg
        set_color normal
        echo

        set_color $abg
        echo -n '> '
        set_color normal
      '';
    };
  };
}
