{ ... }:

{
  home.file.".config/atuin/themes/mono.toml".text = ''
    Base = "gainsboro"
    Important = "white"
    Annotation = "grey"
    Guidance = "dimgrey"
    AlertInfo = "grey"
    AlertWarn = "silver"
    AlertError = "lightgrey"
  '';

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      style = "compact";
      inline_height = 8;
      show_preview = false;
      show_help = false;
      show_tabs = false;
      show_numeric_shortcuts = false;
      ui.columns = [ "datetime" "command" ];
      theme.name = "mono";
    };
  };
}
