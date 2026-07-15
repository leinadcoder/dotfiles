{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    # Applications and small desktop services started once when Hyprland begins.
    # Keep this file focused only on session startup, not on installing packages.
    exec-once = [
      # Top bar, equivalent to the Qtile bar.
      "waybar"

      # Notification daemon.
      "swaync"

      # Wallpaper daemon.
      "hyprpaper"

      # Warm screen temperature helper. It is controlled from keybindings.nix.
      "hyprsunset"

      # Network and Bluetooth tray applets.
      "nm-applet --indicator"
      "blueman-applet"
    ];
  };
}
