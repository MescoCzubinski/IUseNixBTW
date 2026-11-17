{ ... }:

let
  monitors = import ./monitors.nix;
in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      background = map (m: {
        monitor = m.output;
        path = "${m.wallpaper}";
        color = "rgba(16, 16, 16, 1.0)";
        blur_passes = 2;
        blur_size = 4;
      }) monitors ++ [
        {
          monitor = "";
          path = "${../wallpapers/wallpaper_laptop.png}";
          color = "rgba(16, 16, 16, 1.0)";
          blur_passes = 2;
          blur_size = 4;
          zindex = -2;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "rgba(255, 255, 255, 1.0)";
          font_size = 80;
          font_family = "Inter Bold";
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "eDP-1";
          text = "cmd[30000] bash -c 'echo \"$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)%\"'";
          color = "rgba(255, 255, 255, 0.7)";
          font_size = 14;
          font_family = "Inter";
          position = "-20, -20";
          halign = "right";
          valign = "top";
        }
      ];

      "input-field" = [
        {
          monitor = "";
          size = "240, 40";
          outline_thickness = 0;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0)";
          dots_size = 0.3;
          dots_spacing = 0.3;
          dots_center = true;
          font_color = "rgba(255, 255, 255, 1.0)";
          check_color = "rgba(255, 255, 255, 1.0)";
          fail_color = "rgb(ff5a5f)";
          placeholder_text = "";
          fail_text = "";
          swap_font_color = true;
          hide_input = false;
          position = "0, -60";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
