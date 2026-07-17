{ ... }:

let
  theme = import ../theme.nix;
  c = theme.colors;
in
{
  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";

      control-center-positionX = "right";
      control-center-positionY = "top";

      control-center-width = 390;
      control-center-height = 560;

      notification-window-width = 380;

      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 180;

      hide-on-clear = false;
      hide-on-action = true;

      widgets = [
        "title"
        "dnd"
        "notifications"
      ];

      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear";
        };

        dnd = {
          text = "Do not disturb";
        };

        notifications = {
          vexpand = true;
        };
      };
    };

    style = ''
      * {
        font-family: "Noto Sans", "JetBrainsMono Nerd Font";
        font-size: 13px;
        color: ${c.foreground};
      }

      .control-center {
        background: ${c.surfaceRgba};
        border: 1px solid ${c.border};
        border-radius: 12px;
        margin: 8px;
        padding: 8px;
      }

      .control-center-list {
        background: transparent;
      }

      .widget-title {
        background: transparent;
        padding: 8px 10px 10px 10px;
        margin: 0;
      }

      .widget-title > label {
        font-size: 18px;
        font-weight: 600;
        color: ${c.foreground};
      }

      .widget-title > button {
        background: ${c.surfaceElevated};
        color: ${c.foregroundMuted};
        border: 1px solid ${c.border};
        border-radius: 8px;
        padding: 6px 12px;
        box-shadow: none;
      }

      .widget-title > button:hover {
        background: ${c.surfaceHover};
        color: ${c.foreground};
      }

      .widget-dnd {
        background: ${c.surface};
        border: 1px solid ${c.border};
        border-radius: 9px;
        margin: 0 4px 8px 4px;
        padding: 8px 10px;
      }

      .widget-dnd > label {
        color: ${c.foreground};
        font-weight: 500;
      }

      .widget-dnd > switch {
        background: ${c.inactive};
        border-radius: 999px;
        min-width: 38px;
        min-height: 20px;
        box-shadow: none;
      }

      .widget-dnd > switch:checked {
        background: ${c.accentActive};
      }

      .widget-dnd > switch slider {
        background: ${c.foreground};
        border-radius: 999px;
        min-width: 16px;
        min-height: 16px;
        margin: 2px;
        box-shadow: none;
      }

      .notification-row {
        outline: none;
        background: transparent;
        margin: 4px;
      }

      .notification {
        background: ${c.surfaceElevated};
        border: 1px solid ${c.border};
        border-radius: 10px;
        padding: 0;
        box-shadow: none;
      }

      .notification:hover {
        background: ${c.surfaceHover};
      }

      .notification-content {
        background: transparent;
        padding: 12px;
      }

      .summary {
        color: ${c.foreground};
        font-size: 14px;
        font-weight: 600;
      }

      .body {
        color: ${c.foregroundMuted};
        font-size: 13px;
        margin-top: 4px;
      }

      .time {
        color: ${c.foregroundMuted};
        font-size: 11px;
      }

      .close-button {
        background: transparent;
        color: ${c.foregroundMuted};
        border: none;
        border-radius: 999px;
        box-shadow: none;
        min-width: 24px;
        min-height: 24px;
      }

      .close-button:hover {
        background: ${c.surfaceHover};
        color: ${c.foreground};
      }

      .notification.critical {
        border-color: ${c.urgent};
      }

      .notification-action {
        background: ${c.surface};
        color: ${c.foreground};
        border: 1px solid ${c.border};
        border-radius: 7px;
        margin: 4px;
        padding: 6px;
        box-shadow: none;
      }

      .notification-action:hover {
        background: ${c.accentSoft};
      }

      .blank-window {
        background: transparent;
      }

      .floating-notifications {
        background: transparent;
      }

      .floating-notifications .notification {
        background: ${c.surfaceRgba};
        border: 1px solid ${c.border};
        border-radius: 10px;
      }
    '';
  };
}
