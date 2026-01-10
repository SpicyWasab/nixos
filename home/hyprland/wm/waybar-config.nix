{ config, ... }:

{
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      reload_style_on_change = true;
      modules-left = ["custom/distro" "clock" "hyprland/window" "hyprland/submap" ];
      modules-center = ["hyprland/workspaces"];
      modules-right = ["group/expand" "wireplumber" "bluetooth" "network" "battery"];
      "custom/distro" = {
          format = "";
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
      };
      clock = {
        format = "{:%H:%M}";
        interval = 1;   
        tooltip-format = "<tt>{calendar}</tt>";
        calendar = {
            format = {
                today = "<span color='${config.lib.stylix.colors.withHashtag.base08}'><b>{}</b></span>";
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
}