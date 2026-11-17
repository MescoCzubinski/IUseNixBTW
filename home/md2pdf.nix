{ pkgs, ... }:

let
  res = ./dotfiles/md2pdf;
  md2pdf = pkgs.writeShellApplication {
    name = "md2pdf";
    runtimeInputs = [ pkgs.pandoc pkgs.python3Packages.weasyprint ];
    runtimeEnv = {
      KATEX_DIST = "${pkgs.katex}/lib/node_modules/katex/dist";
      FONTCONFIG_FILE = pkgs.makeFontsConf {
        fontDirectories = [ pkgs.inter pkgs.liberation_ttf pkgs.dejavu_fonts ];
      };
    };
    text = ''
      [ $# -ge 1 ] || { echo "Usage: md2pdf input.md [output.pdf]" >&2; exit 1; }
      in="$1"
      out="''${2:-''${in%.md}.pdf}"

      tmp="$(mktemp -d)"
      trap 'rm -rf "$tmp"' EXIT

      pandoc "$in" \
        --from markdown+wikilinks_title_after_pipe+mark-smart-implicit_figures \
        --to html5 \
        --highlight-style pygments \
        --wrap none \
        --template ${res}/template.html \
        --lua-filter ${res}/obsidian.lua \
        --output "$tmp/note.html"

      weasyprint --quiet \
        --stylesheet "$KATEX_DIST/katex.min.css" \
        --stylesheet ${res}/notion.css \
        --base-url "$(dirname "$(realpath "$in")")/" \
        "$tmp/note.html" "$out"

      echo "$out"
    '';
  };
in
{
  home.packages = [ md2pdf ];
}
