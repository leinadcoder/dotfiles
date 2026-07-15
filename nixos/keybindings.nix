{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    # Application commands.
    # These applications should be installed from a separate packages.nix file.
    "$terminal" = "ghostty";
    "$browser" = "firefox";
    "$fileManager" = "nemo";
    "$launcher" = "rofi -show drun";
    "$launcherAlt" = "rofi -show";
    "$screenshotsPath" = "~/Pictures/screenshots";

    bind = [
      # ---------- Windows / Focus ----------
      "$mod, H, movefocus, l"
      "$mod, J, movefocus, d"
      "$mod, K, movefocus, u"
      "$mod, L, movefocus, r"

      # Move active window inside the current layout.
      "$mod SHIFT, H, movewindow, l"
      "$mod SHIFT, J, movewindow, d"
      "$mod SHIFT, K, movewindow, u"
      "$mod SHIFT, L, movewindow, r"

      # Layout / floating behavior.
      "$mod, TAB, cyclenext"
      "$mod SHIFT, F, togglefloating"
      "$mod, W, killactive"

      # Hyprland session actions.
      "$mod CTRL, R, exec, hyprctl reload"
      "$mod CTRL, Q, exit"

      # Swaync notification center 
      "$mod, N, exec, swaync-client -t"

      # ---------- Apps ----------
      "$mod, Return, exec, $terminal"
      "$mod, B, exec, $browser"
      "$mod, E, exec, $fileManager"
      "$mod, M, exec, $launcher"
      "$mod SHIFT, M, exec, $launcherAlt"

      # ---------- Screenshots ----------
      ", Print, exec, mkdir -p $screenshotsPath && grim -g \"$(slurp)\" $screenshotsPath/screenshot-$(date +%Y-%m-%d-%H-%M-%S).png"
      "SHIFT, Print, exec, grim -g \"$(slurp)\" - | wl-copy"
      "CTRL, Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
      "SUPER, Print, exec, mkdir -p $screenshotsPath && grim $screenshotsPath/screenshot-$(date +%Y-%m-%d-%H-%M-%S).png"

      # ---------- Screen temperature ----------
      # Qtile used: redshift -O 3500 / redshift -x.
      # In Hyprland we will use hyprsunset. These binds require the
      # hyprsunset service/process to be started from autostart.nix later.
      "$mod, R, exec, hyprctl hyprsunset temperature 3500"
      "$mod SHIFT, R, exec, hyprctl hyprsunset identity"

      # ---------- Workspaces ----------
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"

      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"

      # ---------- Power menu options ----------
      "$mod SHIFT, Q, exec, wlogout"
    ];

    bindel = [
      # ---------- Multimedia Keys ----------
      # PipeWire/WirePlumber-friendly replacements for amixer.
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"
      ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
    ];

    bindl = [
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ];

    bindm = [
      # ---------- Mouse ----------
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
