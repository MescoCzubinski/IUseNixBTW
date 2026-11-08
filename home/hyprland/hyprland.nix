{ ... }:

let
  monitors = import ./monitors.nix;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    configType = "hyprlang";

    settings = {
      monitor = map (m: "${m.output}, ${m.mode}, ${m.position}, ${m.scale}") monitors;

      workspace = map (m: "${toString m.workspace}, monitor:${m.output}, default:true")
        (builtins.filter (m: m ? workspace) monitors);

      "$terminal" = "kitty";
      "$fileManager" = "kitty yazicd";
      "$editor" = "codium";
      "$browser" = "zen-beta";
      "$menu" = "vicinae toggle";
      "$mainMod" = "SUPER";

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 0;
        resize_on_border = false;
        allow_tearing = true;
        layout = "dwindle";
      };

      decoration = {
        rounding = 8;

        active_opacity = 0.97;
        inactive_opacity = 0.87;

        shadow = {
          enabled = false;
          range = 8;
          render_power = 4;
          color = "rgba(00000033)";
        };

        blur = {
          enabled = true;
          size = 8;
          passes = 2;
          new_optimizations = true;
          ignore_opacity = false;
          vibrancy = 0.25;
        };
      };

      animations = {
        enabled = "yes";

        bezier = [
          "snappy, 0.05, 0.9, 0.1, 1.05"
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "easeInOut, 0.42, 0, 0.58, 1"
        ];

        animation = [
          "windows, 1, 4, snappy"
          "windowsMove, 1, 4, snappy"
          "windowsOut, 1, 4, smoothOut, popin 80%"
          "fade, 1, 4, default"
          "workspaces, 1, 4, easeInOut, slide"
        ];
      };

      dwindle = {
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        vrr = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        allow_session_lock_restore = true;
        middle_click_paste = false;
      };

      render = {
        direct_scanout = 2;
      };

      windowrule = [
        "match:class (?i)^(steam_app_.*|.*\\.exe|gamescope)$, content game, immediate on"
      ];

      binds = {
        allow_workspace_cycles = "yes";
        scroll_event_delay = 300;
      };

      ecosystem = {
        no_update_news = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      input = {
        kb_layout = "pl";
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";

        touchpad = {
          natural_scroll = true;
          drag_3fg = true;
          "tap-to-click" = true;
        };
      };

      gestures = {
        gesture = "3, horizontal, workspace";
      };

      bindr = [
        "$mainMod, Super_L, exec, $menu"
      ];

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, grave, exec, $terminal"
        "$mainMod, Q, killactive"
        "$mainMod shift, Escape, exec, hyprctl dispatch exit"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, D, exec, hyprctl clients -j | jq -e 'any(.[]; .class | ascii_downcase == \"discord\")' >/dev/null && hyprctl dispatch focuswindow 'class:(?i)discord' || discord"
        "$mainMod, N, exec, hyprctl clients -j | jq -e 'any(.[]; .class | ascii_downcase == \"obsidian\")' >/dev/null && hyprctl dispatch focuswindow 'class:(?i)obsidian' || obsidian"
        "$mainMod, S, exec, hyprctl clients -j | jq -e 'any(.[]; .class | ascii_downcase == \"spotify\")' >/dev/null && hyprctl dispatch focuswindow 'class:(?i)spotify' || spotify"
        "$mainMod, C, exec, $editor"
        "$mainMod, B, exec, $browser"
        "$mainMod shift, B, exec, $browser --private-window"
        "$mainMod ctrl, B, exec, $browser --private-window"

        "alt, tab, cyclenext,"
        "alt shift, tab, cyclenext, prev"
        "$mainMod, tab, cyclenext,"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, F, fullscreen, 0"
        "$mainMod shift, F, fullscreen, 1"
        "$mainMod, T, togglefloating"

        "$mainMod, alt, togglespecialworkspace, magic"
        "$mainMod, 1, focusworkspaceoncurrentmonitor, 1"
        "$mainMod, 2, focusworkspaceoncurrentmonitor, 2"
        "$mainMod, 3, focusworkspaceoncurrentmonitor, 3"
        "$mainMod, 4, focusworkspaceoncurrentmonitor, 4"
        "$mainMod, 5, focusworkspaceoncurrentmonitor, 5"
        "$mainMod, 6, focusworkspaceoncurrentmonitor, 6"
        "$mainMod, 7, focusworkspaceoncurrentmonitor, 7"
        "$mainMod, 8, focusworkspaceoncurrentmonitor, 8"
        "$mainMod, 9, focusworkspaceoncurrentmonitor, 9"
        "$mainMod, 0, focusworkspaceoncurrentmonitor, 10"

        "$mainMod shift, 1, movetoworkspace, 1"
        "$mainMod shift, 2, movetoworkspace, 2"
        "$mainMod shift, 3, movetoworkspace, 3"
        "$mainMod shift, 4, movetoworkspace, 4"
        "$mainMod shift, 5, movetoworkspace, 5"
        "$mainMod shift, 6, movetoworkspace, 6"
        "$mainMod shift, 7, movetoworkspace, 7"
        "$mainMod shift, 8, movetoworkspace, 8"
        "$mainMod shift, 9, movetoworkspace, 9"
        "$mainMod shift, 0, movetoworkspace, 10"

        "$mainMod, space, exec, playerctl play-pause"
        "$mainMod, M, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        "$mainMod ctrl, right, workspace, e+1"
        "$mainMod ctrl, left, workspace, e-1"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        ", Print, exec, hyprshot -m region --clipboard-only"
        "$mainMod shift, s, exec, hyprshot -m region --clipboard-only"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod ctrl, mouse:272, resizewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindl = [
        ", switch:on:Lid Switch, exec, [ $(hyprctl monitors -j | jq length) -eq 1 ] && loginctl lock-session"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && [ -e /sys/class/leds/platform::micmute/brightness ] && echo $(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -c MUTED) > /sys/class/leds/platform::micmute/brightness"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      env = [
        "GTK_THEME,Adwaita-dark"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "GDK_BACKEND,wayland,x11"
        "QT_QPA_PLATFORM,wayland;xcb"
      ];

      "exec-once" = [
        "dbus-update-activation-environment --systemd --all"
        "waybar"
        "systemctl --user start vicinae.service"
        "udiskie &"
        "mako &"
        "kdeconnect-indicator &"
        "hyprctl dispatch workspace 1" # focus + cursor on the main monitor
      ];
    };
  };
}
