{ pkgs, inputs, ... }:

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
      # git # use a module later
      nodejs # my favourite scripting language ngl

      # terminal browsers
      offpunk
      w3m
      lynx

      # hyprland-related
      hypridle
      hyprpaper
      waybar

      # gui apps (gnome core)
      nautilus
      sushi
      baobab
      gnome-disk-utility
      mission-center
      decibels
      loupe
      evince
      warp
      
      # slowly replacing every gui app with an alternative
      zathura # instead of evince (which was great)
      imv
      feh
      qimgv
      yazi

      # file manipulations and editing
      libreoffice
      gimp
      audacity
      vscodium

      # zen browser (use a home-manager module later) (edit : module is broken)
      inputs.zen-browser.packages."${system}".twilight

      thunderbird

      # obsidian (vive la prépa)
      obsidian

      # ocaml !
      ocamlPackages.utop # vive la mp2i

      # for scientific calculation (vive la prépa)
      octave

      # icons
      adwaita-icon-theme
      morewaita-icon-theme

      # fonts
      font-awesome

      # cursors
      bibata-cursors
      base16-schemes
    ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}