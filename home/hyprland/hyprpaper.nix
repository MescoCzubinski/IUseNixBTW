{ ... }:

{
  services.hyprpaper = {
    enable = true;

    settings = {
      wallpaper = [
        {
          monitor = "DP-1";
          path = "${../wallpapers/wallpaper_main.png}";
          fit_mode = "cover";
        }
        {
          monitor = "HDMI-A-1";
          path = "${../wallpapers/wallpaper_left.png}";
          fit_mode = "cover";
        }
        {
          monitor = "eDP-1";
          path = "${../wallpapers/wallpaper_laptop.png}";
          fit_mode = "cover";
        }
      ];

      splash = false;
    };
  };
}
