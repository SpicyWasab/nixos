{ lib, ... }:

{
  programs.waybar.style = lib.mkAfter ''
    * {
      font-size: 14px;
      font-family: "CodeNewRoman Nerd Font Propo";
    }

    #waybar {
      background-color: transparent;
    }

    .modules-left, .modules-right {
      color: @base04;
    }

    .modules-left, .modules-center, .modules-right {
      padding: 7px;
      margin: 5 5 5 5;
      border-radius: 10px;
      background: alpha(@base00,.85);
      box-shadow: 0px 0px 2px rgba(0, 0, 0, .6); 
    }

    tooltip {
      background: @base01;
      color: @base04;
    }

    #workspaces {
      padding: 0px 5px;
    }

    #workspaces button.empty {
      color: @base01;
    }

    #workspaces button {
      all: unset;
      color: alpha(@base0D, 0.5); /* if workspace contains windows */
      padding: 0px 5px;
      border: none;
    }

    #workspaces button.active {
      color: @base0D;
    }

    #custom-distro, #clock, #window, #submap, #wireplumber #bluetooth, #network, #battery, #group-expand, #custom-expand, #cpu, #memory, #temperature {
      transition: all .3s ease;
      padding: 0px 5px;
    }

    #submap {
      color: @base0A;
    }

    #custom-distro:hover, #clock:hover, #window:hover, #wireplumber:hover, #bluetooth:hover, #network:hover, #battery:hover, #group-expand:hover, #custom-expand:hover, #cpu:hover, #memory:hover, #temperature:hover {
      color: @base0D;
    }

    #battery.charging {
      color: @base0B;
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
        color: @base04;
      }
    }
  '';
}
