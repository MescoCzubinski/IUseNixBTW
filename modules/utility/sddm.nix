{ outputName }: { pkgs, ... }:

let
  wallpaperSrc = ../../home/dotfiles/hypr/wallpaper.png;

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

      # Colors — matched to waybar/swaync palette
      FormBackgroundColor = "#101010";
      BackgroundColor = "#101010";
      HeaderTextColor = "#e2e2e2";
      DateTextColor = "#737994";
      TimeTextColor = "#e2e2e2";

      LoginFieldBackgroundColor = "#101010";
      PasswordFieldBackgroundColor = "#101010";
      LoginFieldTextColor = "#e2e2e2";
      PasswordFieldTextColor = "#e2e2e2";
      UserIconColor = "#737994";
      PasswordIconColor = "#737994";
      PlaceholderTextColor = "#737994";
      WarningColor = "#e78284";

      LoginButtonBackgroundColor = "#6b9ed8";
      LoginButtonTextColor = "#101010";

      SystemButtonsIconsColor = "#737994";
      HoverSystemButtonsIconsColor = "#e2e2e2";
      SessionButtonTextColor = "#737994";
      HoverSessionButtonTextColor = "#e2e2e2";
      VirtualKeyboardButtonTextColor = "#737994";
      HoverVirtualKeyboardButtonTextColor = "#e2e2e2";

      HighlightBackgroundColor = "#6b9ed8";
      HighlightTextColor = "#101010";
      HighlightBorderColor = "transparent";

      DropdownBackgroundColor = "#101010";
      DropdownTextColor = "#e2e2e2";
      DropdownSelectedBackgroundColor = "#6b9ed8";

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
    settings.Wayland.OutputName = outputName;
  };

  environment.systemPackages = [ sddmTheme ];
}
