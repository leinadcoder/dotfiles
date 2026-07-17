{ config, pkgs, ... }:

let
  theme = import ./theme.nix;
  c = theme.colors;
  fonts = theme.fonts;
  metrics = theme.metrics;

  audioMenu = pkgs.writeShellScript "waybar-audio-menu" ''
    set -eu

    choice="$(${pkgs.rofi}/bin/rofi -dmenu -i -p "Audio" <<'MENU'
Toggle mute
Volume +5%
Volume -5%
Open audio settings
MENU
    )" || exit 0

    case "$choice" in
      "Toggle mute") ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
      "Volume +5%") ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ ;;
      "Volume -5%") ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
      "Open audio settings") ${pkgs.pavucontrol}/bin/pavucontrol >/dev/null 2>&1 & ;;
    esac
  '';

  networkMenu = pkgs.writeShellScript "waybar-network-menu" ''
    set -eu

    wifi_state="$(${pkgs.networkmanager}/bin/nmcli -t -f WIFI general 2>/dev/null || true)"
    if [ "$wifi_state" = "enabled" ]; then
      toggle_label="Disable Wi-Fi"
    else
      toggle_label="Enable Wi-Fi"
    fi

    choice="$(${pkgs.rofi}/bin/rofi -dmenu -i -p "Network" <<MENU
$toggle_label
Connect to Wi-Fi…
Open advanced settings
MENU
    )" || exit 0

    case "$choice" in
      "Enable Wi-Fi") ${pkgs.networkmanager}/bin/nmcli radio wifi on ;;
      "Disable Wi-Fi") ${pkgs.networkmanager}/bin/nmcli radio wifi off ;;
      "Open advanced settings") ${pkgs.networkmanagerapplet}/bin/nm-connection-editor >/dev/null 2>&1 & ;;
      "Connect to Wi-Fi…")
        ${pkgs.networkmanager}/bin/nmcli device wifi rescan >/dev/null 2>&1 || true
        network="$(${pkgs.networkmanager}/bin/nmcli -t -f SSID,SIGNAL,SECURITY device wifi list \
          | ${pkgs.gawk}/bin/awk -F: 'NF && $1 != "" && !seen[$1]++ { printf "%-34s  %3s%%  %s\n", $1, $2, ($3 == "" ? "open" : $3) }' \
          | ${pkgs.rofi}/bin/rofi -dmenu -i -p "Wi-Fi")" || exit 0
        ssid="$(printf '%s' "$network" | ${pkgs.gawk}/bin/awk '{sub(/[[:space:]]+[0-9]+%.*$/, ""); sub(/[[:space:]]+$/, ""); print}')"
        [ -n "$ssid" ] && ${pkgs.networkmanager}/bin/nmcli device wifi connect "$ssid"
        ;;
    esac
  '';

  batteryMenu = pkgs.writeShellScript "waybar-battery-menu" ''
    set -eu
    choice="$(${pkgs.rofi}/bin/rofi -dmenu -i -p "Power" <<'MENU'
Lock
Suspend
Log out
Restart
Shut down
MENU
    )" || exit 0

    case "$choice" in
      "Lock") ${pkgs.hyprlock}/bin/hyprlock ;;
      "Suspend") ${pkgs.systemd}/bin/systemctl suspend ;;
      "Log out") ${pkgs.hyprland}/bin/hyprctl dispatch exit ;;
      "Restart") ${pkgs.systemd}/bin/systemctl reboot ;;
      "Shut down") ${pkgs.systemd}/bin/systemctl poweroff ;;
    esac
  '';
in
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = metrics.barHeight;
        spacing = 4;
        margin-top = 6;
        margin-left = 8;
        margin-right = 8;

        modules-left = [
          "custom/distro"
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [];

        modules-right = [
          "pulseaudio"
          "network"
          "bluetooth"
          "battery"
          "custom/notifications"
          "clock"
        ];

        "custom/distro" = {
          format = theme.icons.distro;
          tooltip = false;
          on-click = "rofi -show drun";
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
            active = "●";
            visible = "●";
            empty = "■";
            default = "■";
            urgent = "■";
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 24;
          separate-outputs = true;

          rewrite = {
            "com\\.mitchellh\\.ghostty" = "Ghostty";
            ".*Mozilla Firefox.*" = "Firefox";
            ".*Nemo.*" = "Files";
          };
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "󰖁";
          format-icons = {
            headphone = "";
            hands-free = "󰋎";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          scroll-step = 2;
          on-click = "${audioMenu}";
          on-click-right = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          tooltip-format = "Volume: {volume}%\nClick for quick controls";
        };

        network = {
          format-wifi = "";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
          on-click = "${networkMenu}";
          tooltip-format-wifi = "{essid}\nSignal: {signalStrength}%\n{ipaddr}";
          tooltip-format-ethernet = "Ethernet\n{ipaddr}";
          tooltip-format-disconnected = "Network disconnected";
        };

        bluetooth = {
          format = "";
          format-disabled = "";
          format-off = "";
          format-on = "";
          format-connected = "";
          format-connected-battery = "";
          tooltip-format = "Bluetooth";
          tooltip-format-connected = "{device_alias}";
          tooltip-format-connected-battery = "{device_alias} · {device_battery_percentage}%";
          on-click = "${pkgs.blueman}/bin/blueman-manager";
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
          on-click = "${batteryMenu}";
          tooltip-format = "{timeTo}\nClick for power options";
        };

        "custom/notifications" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "󱅫";
            none = "󰂚";
            dnd-notification = "󰂛";
            dnd-none = "󰂛";
            inhibited-notification = "󰂛";
            inhibited-none = "󰂛";
            dnd-inhibited-notification = "󰂛";
            dnd-inhibited-none = "󰂛";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t";
          on-click-right = "swaync-client -d";
          escape = true;
        };

        clock = {
          format = "{:%a %d %b   %H:%M}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='${c.accentActive}'><b>{}</b></span>";
              days = "<span color='${c.foreground}'>{}</span>";
              weeks = "<span color='${c.foregroundMuted}'>W{}</span>";
              weekdays = "<span color='${c.accent}'><b>{}</b></span>";
              today = "<span color='${c.urgent}'><b><u>{}</u></b></span>";
            };
          };
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "${fonts.interface}", "${fonts.monospace}";
        font-size: ${toString fonts.size.bar}px;
        min-height: 0;
      }

      window#waybar {
        background: ${c.backgroundRgba};
        color: ${c.foreground};
        border: ${toString metrics.borderWidth}px solid ${c.border};
        border-radius: ${toString metrics.radius}px;
      }

      tooltip {
        background: ${c.surfaceRgba};
        color: ${c.foreground};
        border: 1px solid ${c.border};
        border-radius: ${toString metrics.radiusSmall}px;
      }

      #custom-distro {
        color: ${c.foreground};
        padding: 0 13px;
        font-size: 18px;
      }

      #custom-distro:hover,
      #pulseaudio:hover,
      #network:hover,
      #bluetooth:hover,
      #battery:hover,
      #custom-notifications:hover,
      #clock:hover {
        background: ${c.surfaceHover};
      }

      #workspaces {
        padding: 0 8px;
      }

      #workspaces button {
        min-width: 18px;
        padding: 0 3px;
        margin: 0;

        color: ${c.inactive};
        background: transparent;
        background-image: none;

        border: none;
        box-shadow: none;
        text-shadow: none;

        font-family: "DejaVu Sans", "${fonts.monospace}";
        font-size: 16px;
        font-weight: 700;
      }

      #workspaces button.active {
        color: ${c.accentActive};
        font-size: 20px;
      }

      #workspaces button.visible {
        color: ${c.accent};
        font-size: 20px;
      }

      #workspaces button.empty {
        color: ${c.inactive};
        font-size: 13px;
        opacity: 0.75;
      }

      #workspaces button.urgent {
        color: ${c.urgent};
        font-size: 15px;
      }

      #workspaces button:hover {
        color: ${c.foreground};
        background: transparent;
        box-shadow: none;
        text-shadow: none;
      }

      #window {
        color: ${c.foreground};
        padding: 0 12px;
        font-weight: 500;
      }

      #pulseaudio,
      #network,
      #bluetooth,
      #battery,
      #custom-notifications,
      #clock {
        color: ${c.foreground};
        padding: 0 11px;
        margin: 4px 0;
        border-radius: ${toString metrics.radiusSmall}px;
      }

      #pulseaudio.muted,
      #network.disconnected {
        color: ${c.foregroundMuted};
      }

      #bluetooth.disabled,
      #bluetooth.off,
      #bluetooth.no-controller {
        color: ${c.foregroundMuted};
      }

      #battery.warning {
        color: ${c.warning};
      }

      #battery.critical {
        color: ${c.urgent};
        font-weight: 700;
      }

      #custom-notifications.notification {
        color: ${c.accentActive};
      }

      #clock {
        margin-right: 5px;
        padding-right: 13px;
      }
    '';
  };
}
