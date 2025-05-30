{ config, pkgs, inputs, system, lib, ... }:

{
  # imports = [inputs.walker.homeManagerModules.default];
  
  # imports = [
    # inputs.zen-browser.homeModules.twilight
    # or inputs.zen-browser.homeModules.twilight
    # or inputs.zen-browser.homeModules.twilight-official
  # ];

  home = {
    username = "wasab";
    homeDirectory = "/home/wasab";
    stateVersion = "25.05";

    packages = with pkgs; [
      # survival kit
      fastfetch # can't live without it
      eza
      zip
      unzip
      xz
      bat
      htop
      git # use a module later
      nodejs # my favourite scripting language ngl

      # gemini
      # av-98 (apparently broken)
      asuka
      offpunk

      # that's so cool
      # browsh
      # firefox # unfortunately it's a dependancy

      # hyprland-related
      hypridle
      hyprpaper
      waybar
      # xdg-desktop-portal-gtk # for some reason idk (https://discourse.nixos.org/t/xdg-portals-all-broken/48308/22)

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
      # geary
      
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

      # zen browser (use a home-manager module later) (edit : module is broken)
      inputs.zen-browser.packages."${system}".twilight

      thunderbird

      # obsidian (vive la prépa)
      obsidian

      # ocaml !
      ocamlPackages.utop # vive la MP2I

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
  };

  # enabling user fonts
  fonts.fontconfig.enable = true;

  # gtk cursor
  # gtk.enable = true;
  # x11.enable = true;
  
  stylix.enable = true;
  # stylix.image = "$HOME/Wallpapers/a_computer_room_with_a_desk_and_a_computer_monitor.jpg";
  # blueforest looked good as well
  # tried spaceduck
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.size = 24;
  stylix.opacity.applications = 0.6;
  stylix.opacity.terminal = 0.6;
  # home.pointerCursor = {
    # gtk.enable = true;
    # x11.enable = true;
    # hyprcursor.enable = true;
    # package=pkgs.bibata-cursors;
    # name="Bibata-Modern-Ice";
    # size=24;
  # };
  
  # usual XDG user dirs
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME/Bureau";
      download = "$HOME/Téléchargements";
      documents = "$HOME/Documents";
      templates = "$HOME/Modèles";
      music = "$HOME/Musiques";
      videos = "$HOME/Vidéos";
      pictures = "$HOME/Images";
      publicShare = "$HOME/Public";
    };
    # mimeApps = {
      # enable = true;
      # defaultApplications = {
      #   "document/pdf" = "zathura.pdf";
      # };
    # };
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
      common.default = [ "gtk" ];
        hyprland.default = [
          # "gtk"
          "hyprland"
        ];
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };
  
  # it's been a good starter terminal
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 1; # j'allais le désactiver mais ça vient de me sauver
      # background_opacity = "0.5";
      background_blur = "5";
    };
  };
  
  # my favorite shell
  # (because I'm too lazy and don't have time to get into zsh for now)
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set -g EDITOR nvim

      function y
	      set tmp (mktemp -t "yazi-cwd.XXXXXX")
	      yazi $argv --cwd-file="$tmp"
	      if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		      builtin cd -- "$cwd"
	      end
	      rm -f -- "$tmp"
      end
    '';
    plugins = [
    	# my favorite prompt
	{ name = "tide" ; src = pkgs.fishPlugins.tide.src; }
    ];
    
  };
  
  # neovim !
  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number relativenumber
      set autoindent expandtab tabstop=2 shiftwidth=2
    '';
  };

  # git (took me a while)
  programs.git = {
    enable = true;
    userName  = "Wasab'";
    userEmail = "le_wasabi_ca_pik@proton.me";
  };

  # everything hyprland related
  # programs.hyprland.enable = true;

  programs.hyprlock = {
    enable = true;
  };

  services.hypridle.enable = true;
  services.hyprpaper.enable = true;
  
  # bluetooth
  # services.blueman.enable = true;

  # programs.waybar.enable = true;
  programs.tofi = {
    enable = true;
    settings = {
      # background-color = "#000000";
      border-width = 0;
      # font = "monospace";
      height = "100%";
      num-results = 5;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
      width = "100%";
    };
  };

  home.activation = {
    # https://github.com/philj56/tofi/issues/115#issuecomment-1701748297
    regenerateTofiCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      tofi_cache=${config.xdg.cacheHome}/tofi-drun
      [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
    '';
  };
  
  # KDE connect
  services.kdeconnect.enable = true;
  
  # for nautilus
  # services.gvfs.enable = true;


  # programs.walker = {
  #   enable = true;
  #   runAsService = true;

  #   # All options from the config.json can be used here.
  #   config = {
  #     search.placeholder = "Example";
  #     ui.fullscreen = true;
  #     list = {
  #       height = 200;
  #     };
  #     websearch.prefix = "?";
  #     switcher.prefix = "/";
  #   };

  #   # If this is not set the default styling is used.
  #   # style = ''
  #   #   * {
  #   #     color: #dcd7ba;
  #   #    }
  #   #  '';
  # };

  # networking.firewall = rec {
  #   allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  #   allowedUDPPortRanges = allowedTCPPortRanges;
  # };
  
  # programs.zen-browser.enable = true;

  # programs.obsidian.enable = true;
  # programs.nautilus.enable = true;
  # programs.baobab.enable = true; # apparently does not exists
  # programs.gnome-disk-utility.enable = true;
  # programs.mission-center.enable = true;
  # programs.sushi.enable = true;
  # programs.decibels.enable = true; # same issue
  # programs.loupe.enable = true;
  # programs.evince.enable = true; # same


  # let home manager install and manage itself
  programs.home-manager.enable = true;
}
