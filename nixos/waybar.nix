{ ... }:

let
  colors = {
    background = "#0f101a";
    foreground = "#e4e4e4";
    grey = "#37383b";
    focus = "#323445";
    active = "#f1ffff";
    inactive = "#615f5f";
    urgent = "#ffbca2";
    blue1 = "#052346";
    blue2 = "#04385e";
    blue3 = "#0b506e";
    blue4 = "#057ba6";
    blue5 = "#0F94D2";
  };
in
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 28;
        spacing = 0;

        modules-left = [
          "custom/distro"
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [];

        modules-right = [
          "pulseaudio"
          "network"
          "clock#date"
          "clock#time"
          "battery"
          "tray"
        ];

        "custom/distro" = {
          format = "  ";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
          };
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "󰉋";
            default = "";
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 80;
          separate-outputs = true;
        };

        pulseaudio = {
          format = "  {volume}%";
          format-muted = "󰖁 muted";
          scroll-step = 2;
          on-click = "pavucontrol";
        };

        network = {
          format-wifi = "  {essid}";
          format-ethernet = "󰈀  wired";
          format-disconnected = "󰖪  offline";
          tooltip-format = "{ifname}: {ipaddr}";
        };

        "clock#date" = {
          format = "  {:%a %d/%m/%Y}";
          tooltip-format = "{:%A, %d %B %Y}";
        };

        "clock#time" = {
          format = "  {:%H:%M}";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-plugged = "󰚥  {capacity}%";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };

        tray = {
          icon-size = 16;
          spacing = 8;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free", sans-serif;
        font-size: 12px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(15, 16, 26, 0.95);
        color: ${colors.foreground};
      }

      #custom-distro {
        background: ${colors.blue5};
        color: ${colors.active};
        padding: 0 10px;
        font-size: 15px;
      }

      #workspaces {
        background: ${colors.background};
        padding: 0 4px;
      }

      #workspaces button {
        color: ${colors.inactive};
        padding: 0 8px;
        margin: 0 1px;
      }

      #workspaces button.active {
        color: ${colors.active};
        background: ${colors.focus};
      }

      #workspaces button.urgent {
        color: ${colors.background};
        background: ${colors.urgent};
      }

      #window {
        color: ${colors.foreground};
        padding: 0 12px;
      }

      #pulseaudio,
      #network,
      #clock.date,
      #clock.time,
      #battery,
      #tray {
        background: ${colors.grey};
        color: ${colors.foreground};
        padding: 0 10px;
        margin: 0 0 0 1px;
      }

      #pulseaudio {
        background: ${colors.blue2};
      }

      #network {
        background: ${colors.blue3};
      }

      #clock.date {
        background: ${colors.blue4};
      }

      #clock.time {
        background: ${colors.blue5};
      }

      #battery.warning {
        color: ${colors.urgent};
      }

      #battery.critical {
        color: ${colors.urgent};
        font-weight: bold;
      }
    '';
  };
}
