{ ... }:

let
  monitors = import ./monitors.nix;
in
{
  services.hyprpaper = {
    enable = true;

    settings = {
      wallpaper = map (m: {
        monitor = m.output;
        path = "${m.wallpaper}";
        fit_mode = "cover";
      }) monitors ++ [
        {
          monitor = "*";
          path = "${../wallpapers/wallpaper_laptop.png}";
          fit_mode = "cover";
        }
      ];

      splash = false;
    };
  };
}
