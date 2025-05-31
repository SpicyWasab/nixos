{ config, lib, ... }:

{
  stylix.targets.hyprlock.enable = false;
  programs.hyprlock = {
    enable = true;
    extraConfig = with config.lib.stylix.colors; lib.mkAfter ''
      # hyprlock (and also waybar) from : https://github.com/elifouts/Dotfiles/blob/main/.config/hypr/hyprlock.conf
      background {
        monitor =
        path = screenshot
        blur_size = 5
        blur_passes = 3
        brightness = .6
      }
      input-field {
        monitor =
        size = 15%, 4%
        outline_thickness = 0
        dots_rounding = 4
        dots_spacing = .5
        # dots_fase_time = 300
        inner_color = rgb(${base03})
        outer_color = rgb(${base0C}) rgb(${base0D})
        check_color= rgb(${base0B}) rgb(${base0B})
        fail_color= rgb(${base08}) rgb(${base08})
        font_color = rgb(${base05})
        font_family = CodeNewRoman Nerd Font Propo
        fade_on_empty = false
        shadow_color = rgba(0,0,0,0.5)
        shadow_passes = 2
        shadow_size = 2
        rounding = 20
        placeholder_text = <i></i>
        fail_text = <b>FAIL</b>
        # fail_timeout = 300
        position = 0, -100
        halign = center
        valign = center
      }
      label {
        monitor =
        text = cmd[update:1000] date +"<b>%H</b>"
        color = rgb(${base09})
        font_size = 150
        font_family = CodeNewRoman Nerd Font Propo
        shadow_passes = 0
        shadow_size = 5
        position = -100, 230
        halign = center
        valign = center
      }
      label {
        monitor =
        text = cmd[update:1000] date +"<b>%M</b>"
        color = rgba(${base05}, .4)
        font_size = 150
        font_family = CodeNewRoman Nerd Font Propo
        shadow_passes = 0
        shadow_size = 5
        position = 100, 130
        halign = center
        valign = center
      }
      label {
        monitor =
        text = cmd[update:1000] date +"<b>%A %d %B %Y</b>"
        color = rgb(${base04})
        font_size = 15
        font_family = CodeNewRoman Nerd Font Propo
        shadow_passes = 0
        shadow_size = 4
        position = -15,-7
        halign = right
        valign = top
      }
      label {
        monitor =
        text = <i>Hello</i> <b>$USER</b>
        color = rgb(${base05})
        font_size = 15
        font_family = CodeNewRoman Nerd Font Propo
        shadow_passes = 0
        shadow_size = 4
        position = 15,-7
        halign = left
        valign = top
      }
    '';
  };
}