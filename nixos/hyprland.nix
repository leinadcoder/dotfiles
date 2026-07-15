{ ... }:

{
  imports = [
    ./keybindings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      # Default monitor behavior:
      # Use preferred resolution, automatic position and scale 1.
      # We can later replace this with your exact laptop/external monitor setup.
      monitor = [
        ",preferred,auto,1"
      ];

      # Environment variables commonly needed for Wayland desktop apps.
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "MOZ_ENABLE_WAYLAND,1"
      ];

      input = {
        kb_layout = "us";
        kb_variant = "intl";
        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
          disable_while_typing = true;
        };

        sensitivity = 0;
      };

      general = {
        gaps_in = 4;
        gaps_out = 4;
        border_size = 1;

        # Qtile used MonadTall/MonadWide/Max. Master is the closest initial
        # match for a main-window workflow similar to MonadTall.
        layout = "master";

        # Theme migrated from the current Qtile dark palette.
        "col.active_border" = "rgba(f1ffffee)";
        "col.inactive_border" = "rgba(615f5fee)";

        resize_on_border = false;
        allow_tearing = false;
      };

      decoration = {
        rounding = 6;

        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 8;
          render_power = 2;
          color = "rgba(0f101aaa)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.16;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
        ];

        animation = [
          "windows,1,4,easeOutQuint"
          "windowsOut,1,4,easeInOutCubic"
          "border,1,8,linear"
          "fade,1,4,easeOutQuint"
          "workspaces,1,4,easeOutQuint"
        ];
      };

      master = {
        new_status = "master";
        mfact = 0.55;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
      };

      gesture = [ 
        "3, horizontal, workspace"
      ];

      # Initial floating rules migrated from Qtile's floating_layout rules.
      # We can expand these once we see real app classes/titles in Hyprland.
      windowrulev2 = [
        "float,title:^(confirmreset)$"
        "float,title:^(makebranch)$"
        "float,title:^(maketag)$"
        "float,title:^(branchdialog)$"
        "float,class:^(ssh-askpass)$"
        "float,class:^(pinentry)$"
        "float,title:^(pinentry)$"
      ];
    };
  };
}
