{ package, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
      # survival kit
      fastfetch # can't live without it
      eza
      zip
      unzip
      xz
      bat
      htop
      nodejs # my favourite scripting language ngl
      yazi

      # jdk # required for libreoffice base to work

      # ocaml !
      ocamlPackages.utop # vive la m2i

      # for scientific calculation (vive la prépa)
      octave

      # latex (vive la prépa, le TIPE, et peut-être un jour la recherche)
      (texlive.combine { inherit (texlive) scheme-medium minted upquote standalone preview; }) # minted was not included in medium

      # icons
      adwaita-icon-theme
      morewaita-icon-theme

      # fonts
      font-awesome

      # cursors
      bibata-cursors

      # color schemes for stylix
      base16-schemes  
    ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
