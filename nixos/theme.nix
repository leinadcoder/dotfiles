# Shared visual language for the Hyprland desktop.
# Import it from visual modules with:
#   let theme = import ./theme.nix; in
{
  colors = {
    background = "#0b1017";
    backgroundAlpha = "#0b1017f2";
    backgroundRgba = "rgba(11, 16, 23, 0.95)";

    surface = "#121a24";
    surfaceAlpha = "#121a24e8";
    surfaceRgba = "rgba(18, 26, 36, 0.91)";
    surfaceElevated = "#182230";
    surfaceHover = "#1d2a3a";

    border = "#26364a";
    foreground = "#e6edf5";
    foregroundMuted = "#8e9bab";
    inactive = "#536174";

    accent = "#2f6ea8";
    accentActive = "#3b82c4";
    accentSoft = "#183b5d";

    success = "#8bd49c";
    warning = "#f6c177";
    urgent = "#ff9b8f";
  };

  fonts = {
    interface = "Noto Sans";
    monospace = "JetBrainsMono Nerd Font";
    waybar = "Noto Sans, JetBrainsMono Nerd Font";
    size = {
      small = 10;
      normal = 11;
      bar = 13;
    };
  };

  metrics = {
    radius = 9;
    radiusSmall = 7;
    borderWidth = 1;
    barHeight = 38;
  };

  icons = {
    theme = "Papirus-Dark";
    distro = "";
  };
}
