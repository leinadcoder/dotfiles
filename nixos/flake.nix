{
  description = "Leinad's NixOS + Hyprland workstation configuration";

  inputs = {
    # Stable base. You can change this to nixos-26.05 when you decide to move
    # to that release and update home-manager to release-26.05 as well.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Unstable channel, used selectively via the `pkgs.unstable.*` overlay
    # for packages that move too fast for the stable release (e.g. claude-code).
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "leinad";
      hostname = "coder";

      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
	  inherit inputs;
	  inherit username hostname;
	};

        modules = [
          ({ ... }: { nixpkgs.overlays = [ overlay-unstable ]; })
          ./configuration.nix
          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";

            home-manager.users.${username} = import ./home.nix;
          }
        ];
      };
    };
}
