{ config, ... }:

let
  # Place your preferred wallpaper at this path, or change the value below later.
  wallpaper = "${config.home.homeDirectory}/Pictures/wallpapers/nixos-hyprland.png";
in
{
  # Hyprpaper manages the wallpaper in Hyprland.
  # The actual image is intentionally not committed here; the path is declarative
  # and easy to replace once we choose the final wallpaper.
  home.file.".config/hypr/hyprpaper.conf".text = ''
preload = ${wallpaper}
wallpaper = ,${wallpaper}
splash = false
'';
}
