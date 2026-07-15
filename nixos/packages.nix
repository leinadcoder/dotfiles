{ pkgs, ... }:

{
  # User-level applications for the Hyprland desktop.
  # Hyprland/keybindings.nix references some of these commands, but does not install them.
  home.packages = with pkgs; [
    # Main apps
    ghostty
    firefox

    # Launcher / bar / desktop services
    rofi
    waybar
    swaynotificationcenter
    hyprpaper
    hyprsunset
    hyprlock

    # Audio, brightness and system tray helpers
    pavucontrol
    brightnessctl
    networkmanagerapplet
    blueman
    kanshi
    libnotify
    wlogout
    fastfetch
    gawk

    # Wayland utilities
    wl-clipboard
    grim
    slurp
    swappy

    # Fonts and icons useful for Waybar/workspaces
    nerd-fonts.jetbrains-mono
  ];
}
