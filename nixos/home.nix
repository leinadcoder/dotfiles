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

    theme = {
      name = "Flat-Remix-GTK-Blue-Dark";
      package = pkgs.flat-remix-gtk;
    };

    iconTheme = {
      name = "Flat-Remix-Blue-Dark";
      package = pkgs.flat-remix-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };

    font = {
      name = "Noto Sans";
      size = 10;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Flat-Remix-GTK-Blue-Dark";
      icon-theme = "Flat-Remix-Blue-Dark";
      cursor-theme = "Bibata-Modern-Ice";
      font-name = "Noto Sans 10";
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
    flat-remix-gtk
    flat-remix-icon-theme
    bibata-cursors
    noto-fonts
  ];

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "inode/directory" = "nemo.desktop";
    };
  };
}
