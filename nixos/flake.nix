{
  description = "Leinad's NixOS + Hyprland workstation configuration";

  inputs = {
    # Stable base. You can change this to nixos-26.05 when you decide to move
    # to that release and update home-manager to release-26.05 as well.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pixie-sddm.url = "github:xCaptaiN09/pixie-sddm";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "leinad";
      hostname = "coder";
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
	  inherit inputs;
	  inherit username hostname;
	};

        modules = [
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
