{ pkgs, ... }:

let
  wallpaperSrc = ../../home/dotfiles/hypr/wallpaper_main.png;

  sddmTheme = (pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
    themeConfig = {
      Background = "Backgrounds/wallpaper.png";
      BackgroundPlaceholder = "";
      Font = "Inter";
      FontSize = "13";
      RoundCorners = "20";
      FormPosition = "left";

      # Background
      DimBackground = "0.3";
      DimBackgroundColor = "#101010";
      CropBackground = "true";

      # Blur
      PartialBlur = "true";
      BlurMax = "8";
      Blur = "2.0";
      HaveFormBackground = "true";

      # Colors — matched to waybar/mako palette
      FormBackgroundColor = "#101010";
      BackgroundColor = "#101010";
      HeaderTextColor = "#ffffff";
      DateTextColor = "#3c3c3c";
      TimeTextColor = "#ffffff";

      LoginFieldBackgroundColor = "#101010";
      PasswordFieldBackgroundColor = "#101010";
      LoginFieldTextColor = "#ffffff";
      PasswordFieldTextColor = "#ffffff";
      UserIconColor = "#3c3c3c";
      PasswordIconColor = "#3c3c3c";
      PlaceholderTextColor = "#3c3c3c";
      WarningColor = "#ff5a5f";

      LoginButtonBackgroundColor = "#087e8b";
      LoginButtonTextColor = "#000000";

      SystemButtonsIconsColor = "#3c3c3c";
      HoverSystemButtonsIconsColor = "#ffffff";
      SessionButtonTextColor = "#3c3c3c";
      HoverSessionButtonTextColor = "#ffffff";
      VirtualKeyboardButtonTextColor = "#3c3c3c";
      HoverVirtualKeyboardButtonTextColor = "#ffffff";

      HighlightBackgroundColor = "#087e8b";
      HighlightTextColor = "#000000";
      HighlightBorderColor = "transparent";

      DropdownBackgroundColor = "#101010";
      DropdownTextColor = "#ffffff";
      DropdownSelectedBackgroundColor = "#087e8b";

      # Behavior
      HideSystemButtons = "false";
      HideVirtualKeyboard = "true";
      ForceLastUser = "true";
      PasswordFocus = "true";
      HideCompletePassword = "true";
    };
  }).overrideAttrs (old: {
    installPhase = old.installPhase + ''
      chmod u+w $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds
      cp ${wallpaperSrc} $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/wallpaper.png
    '';
  });
in

{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs.qt6; [ sddmTheme qtmultimedia ];
  };

  environment.systemPackages = [ sddmTheme ];
}
