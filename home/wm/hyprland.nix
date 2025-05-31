{ ... }:

{
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
}