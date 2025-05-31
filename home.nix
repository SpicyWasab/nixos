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
  };

  # enabling user fonts
  fonts.fontconfig.enable = true;

  stylix = {
    enable = true;
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
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
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

  stylix.targets.waybar.addCss = false;
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        reload_style_on_change = true;
        modules-left = ["custom/distro" "clock" "hyprland/window" "hyprland/submap" ];
        modules-center = ["hyprland/workspaces"];
        modules-right = ["group/expand" "wireplumber" "bluetooth" "network" "battery"];
        "custom/distro" = {
            format = "";
        };
        clock = {
          format = "{:%H:%M}";
          interval = 1;   
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
              format = {
                  today = "<span color='#fAfBfC'><b>{}</b></span>";
              };
          };
          actions = {
              on-click-right = "shift_down";
              on-click = "shift_up";
          };
        };
        "hyprland/window" = {
          format = "{initialTitle}";
        };
        "hyprland/submap" = {
          format = "{}";
        };
        "hyprland/workspaces" = {
          format = "";
          persistent-workspaces = {
              "*" = [ 1 2 3 4 5 ];
          };
        };
        "custom/expand" = {
          format = "";
          tooltip = false;
        };
        "group/expand" = {
          orientation ="horizontal";
          drawer = {
              transition-duration = 600;
              transition-to-left = true;
              click-to-reveal = true;
          };
          modules = ["custom/expand" "cpu" "memory" "temperature" "custom/endpoint"];
        };
        cpu = {
          format = "";
          tooltip = true;
        };
        memory = {
          format = "";
        };
        temperature = {
          critical-threshold = 80;
          format = "";
        };
        "custom/endpoint" = {
          format = "|";
          tooltip = false;
        };
        wireplumber = {
          format = "{volume}% {icon}";
          format-muted = "";
          max-volume = 100;
          format-icons = ["" "" ""];
        };
        bluetooth = {
          format-on = "󰂯";
          format-off = "BT-off";
          format-disabled = "󰂲";
          format-connected-battery = "{device_battery_percentage}% 󰂯";
          format-alt = "{device_alias} 󰂯";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\n{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\n{device_address}\n{device_battery_percentage}%";
          on-click-right = "blueman-manager";
        };
        network = {
          format-wifi = "";
          format-ethernet = "";
          format-disconnected = "";
          tooltip-format-disconnected = "Error";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} 🖧 ";
          on-click = "kitty nmtui";
        };
        battery = {
          interval = 30;
          states = {
              good = 95;
              warning = 30;
              critical = 20;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% 󰂄 ";
          format-alt = "{time} {icon}";
          format-icons = [
              "󰁻" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹"
          ];
        };
      };
    };
    style = lib.mkAfter ''
      * {
        font-size: 14px;
        font-family: "CodeNewRoman Nerd Font Propo";
      }

      .modules-left, .modules-right {
        color: @base04;
      }

      .modules-left, .modules-center, .modules-right {
        padding: 7px;
        margin: 5 5 5 5;
        border-radius: 10px;
        background: alpha(black,.6);
        box-shadow: 0px 0px 2px rgba(0, 0, 0, .6); 
      }

      #workspaces {
        padding: 0px 5px;
      }

      #workspaces button.empty {
        color: @base01;
      }

      #workspaces button {
        all: unset;
        color: alpha(@base09, 0.4); /* if workspace contains windows */
        padding: 0px 5px;
        border: none;
      }

      #workspaces button.active {
        color: @base08;
      }

      #custom-distro, #clock, #window, #submap, #bluetooth, #network, #battery, #group-expand, #custom-expand, #cpu, #memory, #temperature {
        transition: all .3s ease;
        padding: 0px 5px;
      }

      #submap {
        color: @base0A;
      }

      #custom-distro:hover, #clock:hover, #window:hover, #bluetooth:hover, #network:hover, #battery:hover, #group-expand:hover, #custom-expand:hover, #cpu:hover, #memory:hover, #temperature:hover {
        color: @base0B;
      }

      #battery.charging {
        color: @base0C;
      }

      #battery.warning:not(.charging) {
        color: @base0A;
      }

      #battery.critical:not(.charging) {
        color: @base08;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      @keyframes blink {
        to {
          color: white;
        }
      }
    '';
  };
  
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
