{ pkgs, ... }:

{
  home.packages = [ pkgs.antigravity ];

  home.file.".antigravity/settings.json".text = builtins.toJSON {
    "workbench.colorTheme" = "Theme Darker";
    "workbench.iconTheme" = "material-icon-theme";
    "material-icon-theme.activeIconPack" = "react";
    "workbench.startupEditor" = "none";
    "workbench.welcomePage.walkthroughs.openOnInstall" = false;
    "editor.minimap.enabled" = false;
    "explorer.compactFolders" = false;
    "chat.viewSessions.orientation" = "stacked";

    "workbench.sideBar.location" = "right";
    "workbench.editor.position" = "left";

    "editor.fontFamily" = "'Fira Code', 'FiraCode Nerd Font', monospace";
    "editor.fontLigatures" = "'cv02', 'ss08', 'liga' off, 'ss02', 'ss03', 'ss04', 'ss05'";
    "editor.tabSize" = 4;
    "editor.detectIndentation" = false;
    "editor.formatOnSave" = true;
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
    "editor.bracketPairColorization.enabled" = true;

    "files.autoSave" = "onFocusChange";
    "files.trimTrailingWhitespace" = true;
    "files.insertFinalNewline" = true;
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;

    "git.autofetch" = true;
    "git.enableSmartCommit" = true;
    "git.openRepositoryInParentFolders" = "never";

    "terminal.integrated.enableMultiLinePasteWarning" = "never";
    "terminal.integrated.fontFamily" = "'FiraCode Nerd Font'";
    "terminal.integrated.fontSize" = 13;
  };
}
