{ pkgs, ... }:

{
  programs.vscodium = {
    enable = true;
    profiles.default.userSettings = {
      # interface
      "workbench.colorTheme" = "One Dark Pro";
      "workbench.startupEditor" = "none";
      "workbench.welcomePage.walkthroughs.openOnInstall" = false;
      "editor.minimap.enabled" = false;
      "explorer.compactFolders" = false;

      # layout
      "workbench.sideBar.location" = "right";
      "workbench.editor.position" = "left";

      # editor
      "editor.fontFamily" = "'Fira Code', 'FiraCode Nerd Font', monospace";
      "editor.fontLigatures" = "'cv02', 'ss08', 'liga' off, 'ss02', 'ss03', 'ss04', 'ss05'";
      "editor.tabSize" = 4;
      "editor.detectIndentation" = false;
      "editor.formatOnSave" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.bracketPairColorization.enabled" = true;
      "codeium.enableCodeLens" = false;

      # files and save
      "files.autoSave" = "onFocusChange";
      "files.trimTrailingWhitespace" = true;
      "files.insertFinalNewline" = true;
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;

      # Git
      "git.autofetch" = true;
      "git.enableSmartCommit" = true;
      "git.openRepositoryInParentFolders" = "never";

      # terminal
      "terminal.integrated.enableMultiLinePasteWarning" = "never";
      "terminal.integrated.fontFamily" = "'FiraCode Nerd Font'";
      "terminal.integrated.fontSize" = 12;
    };
  };
}
