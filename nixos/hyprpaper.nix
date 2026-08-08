{ config, ... }:

let
  wallpaper = "${config.home.homeDirectory}/.local/share/wallpapers/nixos-hyprland.png";
in
{
  # Keep the wallpaper inside the dotfiles repository and let Home Manager
  # deploy it to the user's standard local data directory.
  home.file.".local/share/wallpapers/nixos-hyprland.png".source =
    ./assets/wallpapers/nixos-hyprland.png;

  # Hyprpaper configuration.
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ${wallpaper}
    wallpaper = ,${wallpaper}
    splash = false
  '';
}
