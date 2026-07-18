{ pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./hyprland.nix
    ./waybar.nix
    ./rofi.nix
    ./ghostty.nix
    ./autostart.nix
    ./hyprpaper.nix
    ./modules/swaync.nix
  ];

  services.kanshi = {
    enable = true;

    settings = [
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "DP-1";
            status = "enable";
            mode = "3840x2160@60Hz";
            position = "0,0";
            scale = 1.5;
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      }

      {
        profile.name = "laptop";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "1920x1080@60Hz";
            position = "0,0";
            scale = 1.0;
          }
        ];
      }
    ];
  };

  gtk = {
    enable = true;

    font = {
      name = "Noto Sans";
      size = 10;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 20;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk3.extraCss = ''
      /*
       * Deep Blue — Nemo
       * Settings limited to the file manager.
       */

      .nemo-window {
        background-color: #0b1017;
        color: #e6edf5;
      }

      /* Top bar, menu, and bottom area */
      .nemo-window menubar,
      .nemo-window toolbar,
      .nemo-window .toolbar,
      .nemo-window .primary-toolbar,
      .nemo-window statusbar {
        background-color: #121a24;
        color: #e6edf5;
        border-color: #26364a;
      }

      /* Main area */
      .nemo-window .view,
      .nemo-window iconview,
      .nemo-window treeview,
      .nemo-window scrolledwindow {
        background-color: #0b1017;
        color: #e6edf5;
      }

      /* Sidebar */
      .nemo-window .sidebar {
        background-color: #0f1620;
        color: #e6edf5;
        border-right: 1px solid #26364a;
      }

      .nemo-window .sidebar row {
        min-height: 28px;
        margin: 1px 6px;
        padding: 1px 4px;
        border-radius: 6px;
      }

      .nemo-window .sidebar row:hover {
        background-color: #1d2a3a;
      }

      .nemo-window .sidebar row:selected {
        background-color: #183b5d;
        color: #e6edf5;
      }

      /* Route buttons */
      .nemo-window .path-bar button {
        min-height: 28px;
        padding: 2px 9px;
        background-color: #182230;
        color: #e6edf5;
        border-color: transparent;
        border-radius: 6px;
        box-shadow: none;
      }

      .nemo-window .path-bar button:hover {
        background-color: #1d2a3a;
      }

      .nemo-window .path-bar button:active,
      .nemo-window .path-bar button:checked {
        background-color: #183b5d;
        color: #e6edf5;
      }

      /* Location and search fields */
      .nemo-window entry {
        background-color: #182230;
        color: #e6edf5;
        border: 1px solid #26364a;
        border-radius: 6px;
        box-shadow: none;
      }

      .nemo-window entry:focus {
        border-color: #3b82c4;
        box-shadow: inset 0 0 0 1px #3b82c4;
      }

      /* File selection */
      .nemo-window .view:selected,
      .nemo-window iconview:selected,
      .nemo-window treeview:selected {
        background-color: #183b5d;
        color: #e6edf5;
      }

      /* List view heaers */
      .nemo-window treeview header button {
        background-color: #121a24;
        color: #8e9bab;
        border-color: #26364a;
        border-radius: 0;
        box-shadow: none;
      }

      .nemo-window treeview header button:hover {
        background-color: #182230;
        color: #e6edf5;
      }

      /* Discreet Scrollbars */
      .nemo-window scrollbar slider {
        min-width: 6px;
        min-height: 6px;
        background-color: #536174;
        border-radius: 999px;
      }

      .nemo-window scrollbar slider:hover {
        background-color: #8e9bab;
      }

      /* Nemo's secondary controls */
      .nemo-window button {
        background-image: none;
        background-color: #182230;
        color: #e6edf5;
        border: 1px solid #26364a;
        border-radius: 6px;
        box-shadow: none;
        text-shadow: none;
      }

      .nemo-window button:hover {
        background-color: #1d2a3a;
        border-color: #36506c;
      }

      .nemo-window button:active,
      .nemo-window button:checked {
        background-color: #183b5d;
        border-color: #2f6ea8;
        color: #e6edf5;
      }

      .nemo-window button:disabled {
        background-color: #0f1620;
        border-color: #1b2938;
        color: #536174;
      }

      /* Keep button groups together */
      .nemo-window .linked button {
        border-radius: 0;
      }

      .nemo-window .linked button:first-child {
        border-radius: 6px 0 0 6px;
      }

      .nemo-window .linked button:last-child {
        border-radius: 0 6px 6px 0;
      }

      .nemo-window .linked button:only-child {
        border-radius: 6px;
      }
    '';
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "adw-gtk3-dark";
      icon-theme = "Papirus-Dark";
      cursor-theme = "Adwaita";
      color-scheme = "prefer-dark";
    };
  };

  # Replace these values when we integrate this module into the final flake.
  home.username = "leinad";
  home.homeDirectory = "/home/leinad";

  # Keep this aligned with the Home Manager release used by the flake.
  home.stateVersion = "25.11";

  # Let Home Manager manage itself for this user.
  programs.home-manager.enable = true;

  # Basic environment defaults for the desktop session.
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "ghostty";
    BROWSER = "firefox";
  };

  home.packages = with pkgs; [
    adw-gtk3
    papirus-icon-theme
    noto-fonts
  ];

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 20;

    gtk.enable = true;
    x11.enable = true;
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "inode/directory" = "nemo.desktop";
    };
  };
}
