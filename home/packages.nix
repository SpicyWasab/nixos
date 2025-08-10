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
      # git # use a module later
      nodejs # my favourite scripting language ngl

      # terminal browsers
      offpunk

      # hyprland-related
      hypridle
      hyprpaper
      waybar
      hyprshot

      # gui apps (gnome core)
      nautilus
      sushi
      baobab
      gnome-disk-utility
      mission-center
      decibels
      showtime
      loupe
      evince
      warp

      # music and homeworks mood
      amberol
      parabolic
      gnome-solanum # pomodoro timer
      
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
      kdePackages.kdenlive

      # zen browser (use a home-manager module later) (edit : module is broken)
      inputs.zen-browser.packages."${system}".twilight

      # tor browser (just in case)
      tor-browser-bundle-bin

      thunderbird

      # obsidian (vive la prépa)
      obsidian

      # selfhosted !
      appflowy
      owncloud-client
      pika-backup # yay !

      # ocaml !
      ocamlPackages.utop # vive la mp2i

      # for scientific calculation (vive la prépa)
      octave

      # latex (vive la prépa, le TIPE, et peut-être un jour la recherche)
      (texlive.combine { inherit (texlive) scheme-medium minted upquote standalone preview; }) # minted was not included in medium

      # messing with AI
      ollama

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
