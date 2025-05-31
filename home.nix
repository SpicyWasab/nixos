{ config, pkgs, inputs, system, lib, ... }:

{
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
  };

  # enabling user fonts
  fonts.fontconfig.enable = true;

  stylix.enable = true;
  # stylix.image = "$home/wallpapers/a_computer_room_with_a_desk_and_a_computer_monitor.jpg";
  # blueforest looked good as well
  # tried spaceduck
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
    cursor = {
      package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
    };
    opacity = {
      applications = 0.6;
      terminal = 0.6;
    };
  };
  
  # usual xdg user dirs
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
  # (because i'm too lazy and don't have time to get into zsh for now)
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set -g editor nvim

      alias ls="eza"

      function y
	      set tmp (mktemp -t "yazi-cwd.xxxxxx")
	      yazi $argv --cwd-file="$tmp"
	      if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$pwd" ]
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

  # programs.starship = {
  #   enable = true;
  #   settings = {
  #     
  #   };
  # };
  
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
    userName  = "wasab'";
    userEmail = "le_wasabi_ca_pik@proton.me";
  };

  # everything hyprland related
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [ "eDP-1, 1536x1024@59.99700,0x0,1" ];
      
      # programs
      "$terminal" = "kitty";
      "$filemanager" = "nautilus";
      "$menu" = "tofi-drun | xargs hyprctl dispatch exec --";
      "$browser" = "zen";

      exec-once = [
        "waybar"
        "hyprpaper"
        "hypridle"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        # probably already defined by stylix
        # "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        # "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = true;
        layout = "dwindle"; # what is this, again ?
      };

      decoration = {
        rounding = 10;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          # color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      input = {
        kb_layout = "fr";
        kb_variant = "oss";
        follow_mouse = 1;
        
        touchpad = {
          natural_scroll = true;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      "$mainMod" = "super";

      bind = [
        "$mainMod, r, exec, pkill waybar && hyprctl dispatch exec waybar"
        "$mainMod, t, exec, $terminal"
        "$mainMod, q, killactive,"
        "$mainMod, m, exit,"
        "$mainMod, e, exec, $filemanager"
        "$mainMod, v, togglefloating,"
        "$mainMod, space, exec, $menu"
        "$mainMod, p, pseudo," # dwindle"
        "$mainMod, j, togglesplit," # dwindle
        "$mainMod, b, exec, $browser"
        
        # move focus with arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod, ampersand, workspace, 1"
        "$mainMod, eacute, workspace, 2"
        "$mainMod, quotedbl, workspace, 3"
        "$mainMod, apostrophe, workspace, 4"
        "$mainMod, parenleft, workspace, 5"

        "$mainMod SHIFT, ampersand, movetoworkspace, 1"
        "$mainMod SHIFT, eacute, movetoworkspace, 2"
        "$mainMod SHIFT, quotedbl, movetoworkspace, 3"
        "$mainMod SHIFT, apostrophe, movetoworkspace, 4"
        "$mainMod SHIFT, parenleft, movetoworkspace, 5"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        "$mainMod, return, submap, resize"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl --exponent=1.5 --min-value=1% -- set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl --exponent=1.5 --min-value=1% -- set 5%-"
      ];

      bindl = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl --exponent=1.5 --min-value=1% -- set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl --exponent=1.5 --min-value=1% -- set 5%-"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };

    extraConfig = "
      submap = resize

      binde = , right, resizeactive, 40 0
      binde = , left, resizeactive, -40 0
      binde = , up, resizeactive, 0 -40
      binde = , down, resizeactive, 0 40

      bind = , escape, submap, reset

      submap = reset
    ";
  };

  programs.hyprlock = {
    enable = true;
  };

  services.hypridle.enable = true;
  services.hyprpaper.enable = true;

  # programs.waybar.enable = true;
  programs.tofi = {
    enable = true;
    settings = {
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
  
  # let home manager install and manage itself
  programs.home-manager.enable = true;
}
