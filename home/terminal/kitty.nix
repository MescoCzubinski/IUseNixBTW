{ ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "FiraCode Nerd Font";
      size = 10.0;
    };

    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      background_opacity = "0.8";
      window_padding_width = "6 14";
      hide_window_decorations = "yes";
      confirm_os_window_close = "0";

      cursor_shape = "beam";
      cursor_beam_thickness = "1.6";
      cursor_blink_interval = "0.5";

      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_min_tabs = "2";
      tab_bar_background = "none";
      tab_bar_margin_height = "0.0 5.0";
      tab_title_template = ''"{'Terminal' if tab.active_exe in ('fish', 'bash', 'sh', 'zsh') else tab.active_exe.capitalize()}"'';
      active_tab_foreground = "#000000";
      active_tab_background = "#ffffff";
      inactive_tab_foreground = "#c8c8cc";
      inactive_tab_background = "#3c3c3c";

      foreground = "#ffffff";
      background = "#101010";
      selection_foreground = "#000000";
      selection_background = "#ffffff";

      cursor = "#ffffff";
      cursor_text_color = "#000000";

      # Black
      color0 = "#1c1c1e";
      color8 = "#3c3c3c";

      # Red
      color1 = "#ff5a5f";
      color9 = "#ff5a5f";

      # Green
      color2 = "#83c1a6";
      color10 = "#83c1a6";

      # Yellow
      color3 = "#d4a57c";
      color11 = "#e8b98c";

      # Blue
      color4 = "#087e8b";
      color12 = "#087e8b";

      # Magenta
      color5 = "#b47db0";
      color13 = "#c48fc0";

      # Cyan
      color6 = "#5ab4c8";
      color14 = "#6bbcce";

      # White
      color7 = "#c8c8cc";
      color15 = "#ffffff";
    };

    # font_features needs the same key repeated per font variant, which an
    # attrset can't express — kept as raw lines instead.
    extraConfig = ''
      font_features FiraCode-Regular +cv02 +ss08 +ss02 +ss03 +ss04 +ss05
      font_features FiraCode-Bold    +cv02 +ss08 +ss02 +ss03 +ss04 +ss05
      font_features FiraCode-Retina  +cv02 +ss08 +ss02 +ss03 +ss04 +ss05
    '';

    keybindings = {
      "ctrl+backspace" = "send_text all \\x17";
      "ctrl+delete" = "send_text all \\x1bd";

      "ctrl+t" = "new_tab_with_cwd";
      "ctrl+w" = "close_tab";
      "ctrl+1" = "goto_tab 1";
      "ctrl+2" = "goto_tab 2";
      "ctrl+3" = "goto_tab 3";
      "ctrl+4" = "goto_tab 4";
      "ctrl+5" = "goto_tab 5";
      "ctrl+6" = "goto_tab 6";
      "ctrl+7" = "goto_tab 7";
      "ctrl+8" = "goto_tab 8";
      "ctrl+9" = "goto_tab 9";

      "ctrl+alt+p" = "scroll_to_prompt -1";
      "ctrl+alt+n" = "scroll_to_prompt 1";
    };
  };
}
