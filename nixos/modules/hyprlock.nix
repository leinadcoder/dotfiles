{ config, ... }:

let
  theme = import ../theme.nix;

  c = theme.colors;
  fonts = theme.fonts;

  # Convierte "#0b1017" en "0b1017".
  hex = color:
    builtins.replaceStrings [ "#" ] [ "" ] color;

  rgb = color:
    "rgb(${hex color})";

  # Hyprlock acepta colores rgba en formato RRGGBBAA.
  rgba = color: alpha:
    "rgba(${hex color}${alpha})";

  wallpaper =
    "${config.home.homeDirectory}/Pictures/wallpapers/lock-screen.jpg";
in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
        immediate_render = true;
        fail_timeout = 1800;
      };

      background = [
        {
          monitor = "";

          path = wallpaper;
          color = rgb c.background;

          blur_passes = 2;
          blur_size = 5;

          noise = 0.006;
          contrast = 0.96;
          brightness = 0.62;
          vibrancy = 0.10;
          vibrancy_darkness = 0.03;
        }
      ];

      label = [
        # Reloj
        {
          monitor = "";

          text = "$TIME";
          color = rgb c.foreground;

          font_size = 72;
          font_family = fonts.interface;

          position = "0, 130";
          halign = "center";
          valign = "center";

          shadow_passes = 2;
          shadow_size = 4;
          shadow_color = "rgba(00000099)";
        }

        # Fecha
        {
          monitor = "";

          text = "cmd[update:60000] date '+%A, %d %B %Y'";
          color = rgb c.foregroundMuted;

          font_size = 17;
          font_family = fonts.interface;

          position = "0, 66";
          halign = "center";
          valign = "center";

          shadow_passes = 1;
          shadow_size = 3;
          shadow_color = "rgba(00000099)";
        }
      ];

      "input-field" = [
        {
          monitor = "";

          size = "360, 54";
          position = "0, -34";

          outline_thickness = 2;
          rounding = 12;

          dots_size = 0.18;
          dots_spacing = 0.20;
          dots_center = true;
          dots_rounding = -1;

          fade_on_empty = false;

          inner_color = rgba c.surface "e6";
          outer_color = rgba c.border "ff";
          font_color = rgb c.foreground;

          check_color = rgba c.accentActive "ff";
          fail_color = rgba c.urgent "ff";
          capslock_color = rgba c.warning "ff";

          font_family = fonts.interface;

          placeholder_text =
            ''<span foreground="##${hex c.foregroundMuted}">Password</span>'';

          check_text =
            ''<span foreground="##${hex c.foreground}">Checking…</span>'';

          fail_text =
            ''<span foreground="##${hex c.urgent}">Incorrect password</span>'';

          shadow_passes = 2;
          shadow_size = 5;
          shadow_color = "rgba(00000099)";
        }
      ];
    };
  };
}
