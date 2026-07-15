# Shared color palette migrated from the original Qtile theme.
# Import it from visual modules with:
#   let theme = import ./theme.nix; in
{
  colors = {
    background = "#0f101a";
    backgroundAlpha = "#0f101aee";
    backgroundRgba = "rgba(15, 16, 26, 0.95)";

    grey = "#37383b";
    focus = "#323445";
    foreground = "#e4e4e4";
    active = "#f1ffff";
    inactive = "#615f5f";
    urgent = "#ffbca2";

    blue1 = "#052346";
    blue2 = "#04385e";
    blue3 = "#0b506e";
    blue4 = "#057ba6";
    blue5 = "#0F94D2";

    green = "#8bd49c";
    yellow = "#f6c177";
    purple = "#c4a7e7";
  };

  fonts = {
    monospace = "JetBrainsMono Nerd Font";
    waybar = "JetBrainsMono Nerd Font, Font Awesome 6 Free";
    size = {
      small = 10;
      normal = 11;
      bar = 12;
    };
  };

  icons = {
    theme = "Papirus-Dark";
    distro = "";
  };
}
