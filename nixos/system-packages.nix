{ pkgs, ... }:

{
  # System-level packages: tools useful before Home Manager is activated,
  # for recovery, debugging, or working from a TTY.
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    neovim
    bottom
    pciutils
    usbutils
    lshw
    unzip
    zip
    tree
    file
    ripgrep
    fd
    jq
    home-manager
  ];
}
